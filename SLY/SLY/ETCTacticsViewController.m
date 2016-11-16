//
//  ETCTacticsViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/11/9.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "ETCTacticsViewController.h"
#import "ETCTacticsChatView.h"
#import "PNChart.h"
#import "SLYArticleListTableViewCell.h"
#import "SLYArticleModel.h"
#import "NSArray+JKBlock.h"
#import "ETCPracticeModel.h"
#import "ETCPracticeTableViewCell.h"
#import "SLYSearchViewController.h"



static NSString * Identifier = @"article";
static NSString * Identifier1 = @"article1";

@interface ETCTacticsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *TableView;
@property (strong, nonatomic) PNLineChart *lineChat;
@property (strong, nonatomic)   ETCTacticsChatView * chatView;
@property (strong, nonatomic) NSMutableArray * lists;
@property (assign, nonatomic) int currentPage;
@property(strong,nonatomic) NSString  * type;
@property(strong,nonatomic) NSString  * pcode;
@property (strong, nonatomic) UISegmentedControl * control;
@property(strong,nonatomic)NSArray * charData;
@end

@implementation ETCTacticsViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupNav];
    
    self.currentPage = 1;
    
    if(self.tacticsType == TacticsTypeRobustness){
        
        self.type = @"1";
    }else{
        
        self.type = @"3";
    }
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self setupHeaderView];
    
    [self setupTableView];
    
    [self loadList];
    
    [self getChatData];
    
}


-(void)getChatData{


    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
    Parms[@"pcode"] = self.pcode;
    Parms[@"sign"] = [SLYTools getSignValue:Parms];
    
    [[SLYNetRequestManage  sharedInstance] SLYGetWithUrl:SLYNet_quotation Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
       
        self.charData = [messageResponse.context[@"Quotation"] copy];
        
        [self fetchChatDateWithType:1];

        
    }];

}

-(void)fetchChatDateWithType:(int)type{

    NSArray * oneMonthList =  [self.charData jk_filter:^BOOL(NSDictionary * object) {
        
        if([object[@"Type"] intValue] == type){
            
            return YES;
        }
        
        return NO;
    }];
    
    NSMutableArray * x = [[NSMutableArray alloc]init];
    
    NSMutableArray *y1  = [[NSMutableArray alloc]init];
    
    NSMutableArray *y2 = [[NSMutableArray alloc]init];
    
    for (NSDictionary * dic in oneMonthList) {
        
        NSString * x1 = [dic[@"X"] substringFromIndex:5];
        [x addObject:x1];        
        [y1 addObject:dic[@"Y1"]];
        [y2 addObject:dic[@"Y2"]];
    }
    
    
    [self.lineChat setXLabels:x];
    
    NSArray * data01Array = y1;
    PNLineChartData *data01 = [PNLineChartData new];
    data01.showPointLabel = YES;
    data01.color = SLYColor(0xEB5957, 1);
    data01.dataTitle = @"组合";
    data01.itemCount = data01Array.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = y2;
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = SLYColor(0x557fD0, 1);
    data02.showPointLabel = YES;
    data02.dataTitle = @"沪深300";
    data02.itemCount = data02Array.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChat.chartData = @[data01, data02];
    [self.lineChat strokeChart];
    


}

-(void)setupNav{
    
    
    NSString *title = nil;
    
    if(self.tacticsType == TacticsTypeRobustness){
    
        title = @"实盘策略--稳健型";
        
        self.pcode = @"p000001";
        
        
    }else{
    
        title = @"实盘策略--进取型";
        
        self.pcode = @"p000002";

    }
    
    self.title = title;
    
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [back setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    
    back.frame = CGRectMake(0, 0, back.currentImage.size.width, back.currentImage.size.height);
    
    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [right setImage:[UIImage imageNamed:@"home-搜索"] forState:UIControlStateNormal];
    
    [[right rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
        
        SLYSearchViewController *search = [[SLYSearchViewController alloc]init];
        
        [search setHidesBottomBarWhenPushed:YES];
        
        
        [self.navigationController pushViewController:search animated:YES];
        
    }];
    
    right.frame = CGRectMake(0, 0,30, 44);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}


-(NSMutableArray *)lists{
    
    if(_lists == nil){
        
        _lists = [[NSMutableArray alloc]init];
    }
    
    return _lists;
}


-(void)loadList{
    
    
    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
    Parms[@"index"] = [NSString stringWithFormat:@"%d",self.currentPage];
    Parms[@"size"] = @"10";
    Parms[@"type"] = self.type;
    Parms[@"sign"] = [SLYTools getSignValue:Parms];
    
    
    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_ArticleList Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
        
        NSArray * listArr = messageResponse.context[@"articles"][@"Result"];
        
    
        
        for (NSDictionary *  listDic in listArr) {
            
            SLYArticleModel *model = [SLYArticleModel yy_modelWithDictionary:listDic];
            
            [self.lists addObject:model];
        }
        
        [self.TableView reloadData];
        
        [self.TableView.mj_header endRefreshing];
        
        if(self.lists.count == [messageResponse.context[@"articles"][@"TotalCount"] intValue]){
            
            [self.TableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.TableView.mj_footer endRefreshing];
            
        }
        
    }];
    
}

-(void)loadPractice{

    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
    Parms[@"pcode"] = self.pcode;
    Parms[@"size"] = @"10";
    Parms[@"index"] = [NSString stringWithFormat:@"%d",self.currentPage];
    Parms[@"sign"] = [SLYTools getSignValue:Parms];
    
    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_Practice Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
        
        NSArray * listArr = messageResponse.context[@"position"];
        
    
        for (NSDictionary *  listDic in listArr) {
            
            ETCPracticeModel *model = [ETCPracticeModel yy_modelWithDictionary:listDic];
            
            [self.lists addObject:model];
        }
        
        [self.TableView reloadData];
        
        [self.TableView.mj_header endRefreshing];
        
        if(self.lists.count == 0){
            
            [self.TableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.TableView.mj_footer endRefreshing];
            
        }
        
    }];

    
}

-(void)setupTableView{

    [self.TableView registerNib:[UINib nibWithNibName:@"SLYArticleListTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    [self.TableView registerNib:[UINib nibWithNibName:@"ETCPracticeTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier1];

    
    self.TableView.tableFooterView = [[UIView alloc]init];
    
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.currentPage = 1;
        
        [self.lists removeAllObjects];
        
        if([self.type isEqualToString:@"5"]){
            

            [self loadPractice];
            
            return ;
        }
        
        [self loadList];
        
    }];
    
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.currentPage ++;
        
        if([self.type isEqualToString:@"5"]){
            
            [self loadPractice];
            
            return ;
        }
        
        [self loadList];
    }];
}


-(UIView *)setupTableViewSectionHeader{
    
    UIView * sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SLYScreenWidth, 70)];
    
    sectionHeader.backgroundColor = [UIColor whiteColor];
    
    self.control = [[UISegmentedControl alloc]initWithItems:@[@"操盘明细",@"调仓记录",@"持仓品种"]];
    
    self.control.tintColor = SLYColor(0xd7d7d7, 1);
    
    
    
    
    [sectionHeader addSubview:self.control];
    
    
    [[self.control rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISegmentedControl * x) {
        
        [self.lists removeAllObjects];
        
        self.currentPage = 1;

        
        switch (x.selectedSegmentIndex) {
            case 0:
            {
                if(self.tacticsType == TacticsTypeRobustness){
                    
                        self.type = @"1";
                }else{
                    
                        self.type = @"3";
                }
                
                
                [self loadList];
                
                
                break;
            }
                
            case 1:
            {
                if(self.tacticsType == TacticsTypeRobustness){
                    
                    self.type = @"2";
                }else{
                    
                    self.type = @"4";
                }
                
                [self loadList];

                
                break;
            }
                
            default:
                
                self.type = @"5";
                
                [self loadPractice];
                
                break;
        }
        
    }];
    
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                             NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.control setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                               NSForegroundColorAttributeName: SLYColor(0x545454, 1)};
    [self.control setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    if([self.type intValue] == 1 || [self.type intValue] == 3){
    
        self.control.selectedSegmentIndex = 0;
    }
    
    if([self.type intValue] == 2 || [self.type intValue] == 4){
        
        self.control.selectedSegmentIndex = 1;
    }
    
    if([self.type intValue] == 5){
        
        self.control.selectedSegmentIndex = 2;
    }
    
    
    
    [self.control setBackgroundImage:[UIImage imageNamed:@"操作明细-bg-默认"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.control setBackgroundImage:[UIImage imageNamed:@"近三个月-bg"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    
    [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(sectionHeader.mas_left).offset(12);
        make.right.equalTo(sectionHeader).offset(-12);
        make.height.equalTo(@40);
        make.top.equalTo(sectionHeader).offset(15);
        
    }];
    
    if([self.type integerValue] == 5){
        
        sectionHeader.sr_Heigth = sectionHeader.sr_Heigth + 44;
        
        SLYView * parView = [[SLYView alloc]initWithFrame:CGRectMake(0,70, SLYScreenWidth, 40)];
        parView.backgroundColor = [UIColor clearColor];
        [sectionHeader addSubview:parView];
    
        UILabel * name = [[UILabel alloc]init];
        name.text = @"股票名称";
        name.font = [UIFont systemFontOfSize:13];
        name.textColor = SLYColor(0x666666, 1);
        [parView addSubview:name];
        name.textAlignment = NSTextAlignmentCenter;
        
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.centerY.equalTo(parView);
            make.left.equalTo(parView.mas_left).offset(12);
            make.width.equalTo(parView.mas_width).multipliedBy(0.2);
        }];
        
        
        UILabel * code = [[UILabel alloc]init];
        code.text = @"代码";
        code.font = [UIFont systemFontOfSize:13];
        code.textColor = SLYColor(0x666666, 1);
        [parView addSubview:code];
        code.textAlignment = NSTextAlignmentCenter;
        
        [code mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(parView);
            make.left.equalTo(name.mas_right).offset(10);
            make.width.equalTo(parView.mas_width).multipliedBy(0.167);
        }];
        
        UILabel * count = [[UILabel alloc]init];
        count.text = @"持有股数";
        count.font = [UIFont systemFontOfSize:13];
        count.textColor = SLYColor(0x666666, 1);
        [parView addSubview:count];
        count.textAlignment = NSTextAlignmentCenter;
        
        [count mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(parView);
            make.left.equalTo(code.mas_right).offset(10);
            make.width.equalTo(parView.mas_width).multipliedBy(0.167);
        }];
        
        
        UILabel * ptice = [[UILabel alloc]init];
        ptice.text = @"持有价格";
        ptice.font = [UIFont systemFontOfSize:13];
        ptice.textColor = SLYColor(0x666666, 1);
        [parView addSubview:ptice];
        ptice.textAlignment = NSTextAlignmentCenter;
        
        [ptice mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(parView);
            make.left.equalTo(count.mas_right).offset(10);
            make.width.equalTo(parView.mas_width).multipliedBy(0.167);
        }];
        
        
        
        UILabel * time = [[UILabel alloc]init];
        time.text = @"买入时间";
        time.font = [UIFont systemFontOfSize:13];
        time.textColor = SLYColor(0x666666, 1);
        [parView addSubview:time];
        time.textAlignment = NSTextAlignmentRight;
    
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(parView);
            make.right.equalTo(parView.mas_right).offset(-10);
            make.width.equalTo(parView.mas_width).multipliedBy(0.167);
        }];
        
        
    }
    
    
    return sectionHeader;
}


-(void)setupHeaderView{

    
    self.chatView = [[[NSBundle mainBundle]loadNibNamed:@"ETCTacticsChatView" owner:nil options:nil]lastObject];
    
    self.chatView.frame = CGRectMake(0, 0, SLYScreenWidth, SLYScreenWidth/750*650 + 10);
    
    
    self.chatView.layer.borderWidth = 0.5;
    
    self.chatView.layer.borderColor = SLYColor(0xd7d7d7, 1).CGColor;
    
    
    NSDictionary* selectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                             NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.chatView.Segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];//设置文字属性
    NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                               NSForegroundColorAttributeName: SLYColor(0x545454, 1)};
    [self.chatView.Segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
    
    self.chatView.Segment.tintColor = SLYColor(0xd7d7d7, 1);

    
    [self.chatView.Segment setBackgroundImage:[UIImage imageNamed:@"操作明细-bg-默认"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.chatView.Segment setBackgroundImage:[UIImage imageNamed:@"近三个月-bg"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [[self.chatView.Segment rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISegmentedControl * x) {
        
        [self fetchChatDateWithType:((int)x.selectedSegmentIndex + 1)];
    }];
    
    self.TableView.tableHeaderView = self.chatView;
    
    
    [self setupPNChat];
    
    
}

-(void)setupPNChat{
    
    [self.chatView layoutIfNeeded];

    self.lineChat = [[PNLineChart alloc]initWithFrame:CGRectMake(0.5, 10, SLYScreenWidth - 24-1, SLYScreenWidth/750*650 - SLYScreenWidth/750*88 - 25 - 35 - 10 - 0.5)];

    
    [self.chatView.chatContentView addSubview:self.lineChat];
    
    
    self.lineChat.legendStyle = PNLegendItemStyleSerial;
    self.lineChat.legendFont = [UIFont systemFontOfSize:12];
    
    NSMutableArray * x = [[NSMutableArray alloc]init];
    [self.lineChat setXLabels:x];

    NSArray * data01Array = @[];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.showPointLabel = YES;
    data01.color = SLYColor(0xEB5957, 1);
    data01.dataTitle = @"组合";
    data01.itemCount = self.lineChat.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = SLYColor(0x557fD0, 1);
    data02.showPointLabel = YES;
    data02.dataTitle = @"沪深300";
    data02.itemCount = self.lineChat.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    self.lineChat.chartData = @[data01, data02];
    [self.lineChat strokeChart];

    
    
    UIView * legend = [self.lineChat getLegendWithMaxWidth:200];
    [legend setFrame:CGRectMake(SLYScreenWidth - legend.frame.size.width,0, legend.frame.size.width, legend.frame.size.height)];
    [self.lineChat addSubview:legend];

    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if([self.type intValue] == 5){
    
        ETCPracticeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier1];
        
        cell.model = self.lists[indexPath.row];

        return cell;
    }
    
    SLYArticleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.lists[indexPath.row];
    
    return  cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.lists.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if([self.type intValue] != 5){

        SLYArticleDetailViewController * detail = [[SLYArticleDetailViewController alloc]init];
        
        SLYArticleModel *model = self.lists[indexPath.row];
        
        [detail setHidesBottomBarWhenPushed:YES];
        
        detail.articelId = model.Id;
        
        [self.navigationController pushViewController:detail animated:YES];
 
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if([self.type intValue] == 5){
    
        return 45;
    }

    
    SLYArticleModel *model = self.lists[indexPath.row];
    
    CGFloat titleHeight = [SLYTools getCellHightWithString:model.Title Size:CGSizeMake(SLYScreenWidth - 24, 100) Fontsize:16 lineSpacing:5];
    
    CGFloat contentHeight = [SLYTools getCellHightWithString:model.Intro Size:CGSizeMake(SLYScreenWidth - 24, 61) Fontsize:14 lineSpacing:5];
    
    return titleHeight + contentHeight + 15 + 15 + 15 + 15 + 10;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    
    return [self setupTableViewSectionHeader];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    
    if([self.type intValue] == 5){
    
        return 70+40;
    }
    
    return 70.0f;
}


@end
