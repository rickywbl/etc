//
//  SLYHomeViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYHomeViewController.h"
#import "SLYHomeButton.h"
#import "SLYHomeTableViewCell.h"
#import "SLYRootViewController.h"
#import "SLYTabbleBarViewController.h"
#import "AppDelegate.h"
#import "SLYArticleListViewController.h"
#import "SLYArticleModel.h"
#import "SLYSearchViewController.h"

static NSString *Identifier = @"home";

@interface SLYHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (copy, nonatomic) NSMutableArray * lists;

@end

@implementation SLYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self home_setUpLeftItem];
    
    self.navigationItem.title = @"三连阳实盘版";
    
    [self home_setUpAllItems];
    
    [self home_setUpTableView];
    
}

-(NSMutableArray *)lists{
    
    if(_lists == nil){
        
        _lists = [[NSMutableArray alloc]init];
    }
    
    return _lists;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
    
    [self home_loadLists];
    
}


-(void)home_loadLists{
    
    
    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
    Parms[@"index"] = [NSString stringWithFormat:@"%d",1];
    Parms[@"size"] = @"4";
    Parms[@"id"] = @"8";
    Parms[@"sign"] = [SLYTools getSignValue:Parms];
    
    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_MessageList Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
        
        NSArray * listArr = messageResponse.context[@"articles"][@"Result"];
        
        [self.lists removeAllObjects];
        
        for (NSDictionary *  listDic in listArr) {
            
            SLYArticleModel *model = [SLYArticleModel yy_modelWithDictionary:listDic];
            
            [self.lists addObject:model];
        }
        
        [self.tableView reloadData];
        
        
    }];


}


#pragma mark --- 初始化TableView

-(void)home_setUpTableView{

    [self.tableView registerNib:[UINib nibWithNibName:@"SLYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    self.tableView.tableFooterView = [[UIView alloc]init];

}

-(void)home_setUpLeftItem{

    UIButton *leftMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [leftMenu setImage:[UIImage imageNamed:@"home_left"] forState:UIControlStateNormal];
    
    [[leftMenu rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
        
        SLYNavigationController *nav = (SLYNavigationController *) [UIApplication sharedApplication].keyWindow.rootViewController;
        
        SLYRootViewController *root = (SLYRootViewController *)nav.visibleViewController;
        
    
        if(![root.show boolValue]){
            
            
            [root showMenuView];
        
        }else{
        
        
            [root hideMenuView];
        }
        
    }];
    
    leftMenu.frame = CGRectMake(0, 0,30, 44);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftMenu];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [right setImage:[UIImage imageNamed:@"home-搜索"] forState:UIControlStateNormal];
    
    [[right rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
        
        SLYSearchViewController *search = [[SLYSearchViewController alloc]init];
        
        [search setHidesBottomBarWhenPushed:YES];
        
        [self setmenuHide];

        
        [self.navigationController pushViewController:search animated:YES];
        
    }];
    
    right.frame = CGRectMake(0, 0,30, 44);
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:right];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
}


#pragma mark --- 初始化Items

-(void)home_setUpAllItems{

    
    CGFloat space = ([UIScreen mainScreen].bounds.size.width - 70 * 4) / 5;
    
    NSArray * imageNames = @[@"实盘策略",@"操盘笔记",@"藏金阁",@"操盘前瞻",@"私募情报",@"量化组合",@"藏金阁",@"交易提醒"];
    NSArray * subContents = @[
                              @"专注于给投资者提供有前瞻性、实用性、有效性和指导性的股市操作建议，是投资者理想、权威的投资顾问。",
                              @"工作室盘中获取第一手私募信息，及时发布，投资者可密切关注。",
                              @"通过监测资金流向，机构和游资席位及技术分析等方法，大概率捕捉短线最具爆发力的个股。",
                              @"借鉴两位传奇投资大师——把彼得林奇的PEG选股法和威廉欧奈尔的CANSLIM策略相结合，中线持有超高速成长股穿越熊市，获取超额收益。",
                              @"独有渠道收集整理最新私募操作动态，为投资者提供最为及时、最为全面和最具有参考价值的投资情报信息。",
                              @"每个月从财经智库证券研究所的独家研究成果中精挑细选，并由投资决策委员会层层把关，最终筛选十只个股构成当月股票池组合。",
                              @"汇集财经智库证券研究所最新策略观点，囊括每周交易核心要义，更有不定期发布的财经智库证券研究所最新独家研究成果。",
                              @"针对市场重大政策更新、新股申购等重要信息，本栏目将第一时间发布提示。"];
    
    SLYHomeButton * lastItem = nil;
    
    for (int i = 0 ; i <  4;  i ++) {
    
        SLYHomeButton * Item = [[SLYHomeButton alloc]init];
        
//        Item.backgroundColor = [UIColor yellowColor];
        
        int row = i / 4;
                
        Item.tag = 101+i;
        
        NSString * imageName = [NSString stringWithFormat:@"home_%@",imageNames[i]];
        
        [Item setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        Item.imageView.contentMode = UIViewContentModeTop;
        
        [Item setTitle:imageNames[i] forState:UIControlStateNormal];
        
        [Item setTitleColor:SLYColor(0x545454, 1) forState:UIControlStateNormal];
        
        
        [[Item rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
           
            SLYArticleListViewController * list = [[SLYArticleListViewController alloc]init];
            
            list.ArticleTitle = imageNames[i];
            
            [list setHidesBottomBarWhenPushed:YES];
            
            list.subcontent = subContents[i];
            
            list.type = (int)x.tag -100 + 3;
            
            [self setmenuHide];
            
            [self.navigationController pushViewController:list animated:YES];
            
            
        }];
        
        [self.MiddleView addSubview:Item];
        
        if(lastItem == nil){
        
            [Item mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(self.MiddleView.mas_left).offset(space);
                make.top.equalTo(self.MiddleView.mas_top).offset(15);
                make.bottom.equalTo(self.MiddleView.mas_bottom).offset(-15);
                make.width.equalTo(@70);
                
            }];
            
        }else{
            
            if(row == 0){
            
                [Item mas_makeConstraints:^(MASConstraintMaker *make) {
                    
                    make.left.equalTo(lastItem.mas_right).offset(space);
                    make.centerY.equalTo(lastItem.mas_centerY);
                    make.size.equalTo(lastItem);
                    
                }];
            }
        
  
        }
        
        lastItem = Item;
    }
    
}


-(void)setmenuHide{
    
    
    SLYNavigationController *nav = (SLYNavigationController *) [UIApplication sharedApplication].keyWindow.rootViewController;
    
    SLYRootViewController *root = (SLYRootViewController *)nav.visibleViewController;
 
    
    [root hideMenuView];


}



#pragma mark --- TableViewDelegate && TableViewDataResoure


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SLYHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    
    SLYArticleModel *model = self.lists[indexPath.row];
    
    cell.title.attributedText = [SLYTools AttributedStringWithString:model.Title lineSpacing:5 FontSize:16 Color:SLYColor(0x333333, 1)];
    
    return  cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.lists.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}

- (IBAction)home_moreInformartion:(UIButton *)sender {
    
    SLYNavigationController *nav = (SLYNavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    SLYRootViewController *root = (SLYRootViewController *)nav.visibleViewController;
    
    
    [self setmenuHide];

    [root.tabBar setSelectedIndex:2];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    SLYArticleDetailViewController * detail = [[SLYArticleDetailViewController alloc]init];
    
    [detail setHidesBottomBarWhenPushed:YES];
    
    SLYArticleModel *model = self.lists[indexPath.row];
    
    detail.articelId = model.Id;
    
    [self setmenuHide];

    
    [self.navigationController pushViewController:detail animated:YES];
    
}


@end
