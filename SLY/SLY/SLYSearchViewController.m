//
//  SLYSearchViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/10/24.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYSearchViewController.h"
#import "SLYArticleModel.h"
#import "SLYArticleListTableViewCell.h"

static NSString * Identifier =  @"article";


@interface SLYSearchViewController ()<CYLTableViewPlaceHolderDelegate>

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UITableView *TableView;

@property (strong, nonatomic) UITextField * textField;

@property (assign, nonatomic) int currentPage;

@property (strong, nonatomic) NSMutableArray * lists;
@end

@implementation SLYSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self setupTopView];
    
    [self setupTableView];
    
    [self setupNavItem];
}

-(NSMutableArray *)lists{
    
    if(_lists == nil){
        
        _lists = [[NSMutableArray alloc]init];
    }
    
    return _lists;
}


-(void)setupTableView{
    
    if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
    
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    [self.TableView registerNib:[UINib nibWithNibName:@"SLYArticleListTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    self.TableView.tableFooterView = [[UIView alloc]init];
    
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.currentPage = 1;
        
        [self.lists removeAllObjects];
        
        [self loadlist];
        
    }];
    
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.currentPage ++;
        
        [self loadlist];
    }];

}

-(void)setupNavItem{
    
    self.title = @"搜索";
    
    
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [back setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    
    back.frame = CGRectMake(0, 0, back.currentImage.size.width, back.currentImage.size.height);
    
    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
        
}

-(void)setupTopView{

    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(12, 9, SLYScreenWidth - 24, 32)];
    
    [self.topView addSubview:self.textField];
    
    self.topView.backgroundColor = SLYColor(0xeeeeee, 1);
    
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.topView.mas_left).offset(12);
        make.right.equalTo(self.topView.mas_right).offset(-12);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.height.equalTo(@30);
    }];
    
    self.textField.placeholder = @"请输入股票代码,关键字等";
    
    [self.textField setValue:SLYColor(0xeeeeee, 1) forKeyPath:@"_placeholderLabel.textColor"];
    [self.textField setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    
    UIButton * search = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [[search rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.lists removeAllObjects];
       
        self.currentPage = 1;
        
        [self loadlist];
        
        [self.textField  resignFirstResponder];
    }];
    
    search.titleLabel.font = [UIFont systemFontOfSize:14];
    [search setTitle:@"搜索" forState:UIControlStateNormal];
    
    [search setBackgroundImage:[UIImage imageNamed:@"搜索-bg"] forState:UIControlStateNormal];
    
    search.frame = CGRectMake(0, 0, 50, 30);
    
    self.textField.rightView = search;
    
    self.textField.rightViewMode = UITextFieldViewModeAlways;
    
}

-(void)loadlist{
    
    
    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
    Parms[@"index"] = [NSString stringWithFormat:@"%d",self.currentPage];
    Parms[@"size"] = @"10";
    Parms[@"type"] = @"0";
    Parms[@"title"] = self.textField.text;

    Parms[@"sign"] = [SLYTools getSignValue:Parms];
    
    
    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_ArticleList Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
        
        NSArray * listArr = messageResponse.context[@"articles"][@"Result"];
        
        int TotalCount = [messageResponse.context[@"articles"][@"TotalCount"] intValue];
        
        for (NSDictionary *  listDic in listArr) {
            
            SLYArticleModel *model = [SLYArticleModel yy_modelWithDictionary:listDic];
            
            [self.lists addObject:model];
        }
        
        [self.TableView cyl_reloadData];
        
        [self.TableView.mj_header endRefreshing];
        
        if(self.lists.count == TotalCount){
            
            [self.TableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.TableView.mj_footer endRefreshing];
            
        }
        
    }];
    
    

//    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
//    Parms[@"token"] = [SLYConfig sharedInstance].token;
//    Parms[@"index"] = [NSString stringWithFormat:@"%d",self.currentPage];
//    Parms[@"size"] = @"10";
//    Parms[@"type"] = @"0";
//    Parms[@"title"] = self.textField.text;
//    
//    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_ArticleList Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
//        
//        NSArray * listArr = messageResponse.context[@"articles"];
//        
//        for (NSDictionary *  listDic in listArr) {
//            
//            SLYArticleModel *model = [SLYArticleModel yy_modelWithDictionary:listDic];
//            
//            [self.lists addObject:model];
//        }
//        
//        [self.TableView cyl_reloadData];
//        
//        [self.TableView.mj_header endRefreshing];
//        [self.TableView.mj_footer endRefreshing];
//        
//    }];


}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SLYArticleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.lists[indexPath.row];
    
    return  cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    [self.TableView.mj_footer setHidden:!self.lists.count];
    
    
    return self.lists.count;
}

- (UIView *)makePlaceHolderView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.TableView.bounds];
    
    
    UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(SLYScreenWidth/2 -50,100, 100, 110)];
    
    [bgView addSubview:image];
    
    [image  mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(100, 110));
        make.centerX.equalTo(bgView);
        make.top.equalTo(bgView.mas_top).offset(100);
    }];
    
    [image setImage:[UIImage imageNamed:@"矢量图"]];
    
    
    
    UILabel *lab = [UILabel new];
    lab.text = @"哦,暂无数据!";
    lab.font = [UIFont systemFontOfSize:13];
    lab.textColor = SLYColor(0x999999, 1);
    
    [bgView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(image);
        make.top.equalTo(image.mas_bottom).offset(15);
        
    }];
    
    
    return bgView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SLYArticleModel *model = self.lists[indexPath.row];
    
    
    CGFloat titleHeight = [SLYTools getCellHightWithString:model.Title Size:CGSizeMake(SLYScreenWidth - 24, 100) Fontsize:16 lineSpacing:5];
    
    CGFloat contentHeight = [SLYTools getCellHightWithString:model.Intro Size:CGSizeMake(SLYScreenWidth - 24, 61) Fontsize:14 lineSpacing:5];
    
    
    return titleHeight + contentHeight + 15 + 15 + 15 + 15 + 10;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SLYArticleDetailViewController * detail = [[SLYArticleDetailViewController alloc]init];
    
    SLYArticleModel *model = self.lists[indexPath.row];
    
    [detail setHidesBottomBarWhenPushed:YES];
    
    detail.articelId = model.Id;
    
    [self.navigationController pushViewController:detail animated:YES];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

    [self.textField  resignFirstResponder];

    
}

@end
