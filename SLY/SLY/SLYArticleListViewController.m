//
//  SLYArticleListViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/10/18.
//  Copyright © 2016年 Ricky. All rights reserved.
//


#import "SLYArticleListViewController.h"
#import "SLYArticleListTableViewCell.h"
#import "SLYArticleModel.h"
#import "SLYNotesTableViewCell.h"
#import "SLYStrategyTableViewCell.h"
#import "ETCTacticsViewController.h"

static NSString * Identifier = @"article";
@interface SLYArticleListViewController ()<UITableViewDelegate,UITableViewDataSource,CYLTableViewPlaceHolderDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,copy)NSMutableArray *lists;
@property(nonatomic,strong)UIImageView * headerImage;
@property(nonatomic,strong)UILabel * titleLab;
@property(nonatomic,strong)UILabel * content;
@property(nonatomic,assign)int currentPage;

@end

@implementation SLYArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = SLYColor(0xf4f4f4, 0);
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;

    
    [self setupNavItem];
    
    [self setupTableView];
    
    [self setupHeaderView];
    
    [self loadList];
    
    [self setupBack];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    if(self.tableView.contentOffset.y + 20 > SLYScreenWidth * 0.667){
        
        
        [self.navigationController.navigationBar setHidden:NO];
        
        
    }else{
        
        [self.navigationController.navigationBar setHidden:YES];
        
    }

}


- (UIView *)makePlaceHolderView {
    
    UIView *bgView = [[UIView alloc]initWithFrame:self.tableView.bounds];
    
    
    UIImageView *image =[[UIImageView alloc]initWithFrame:CGRectMake(SLYScreenWidth/2 -50,300, 100, 110)];
    
    [bgView addSubview:image];
    
    [image  mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(100, 110));
        make.centerX.equalTo(bgView);
        make.top.equalTo(bgView.mas_top).offset(300);
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


-(void)setupBack{

    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [back setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    
    back.frame = CGRectMake(5,30,40,40);
    
    back.contentMode = UIViewContentModeTopLeft;
    
    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [self.view addSubview:back];


}

-(void)setupHeaderView{

    UIView * headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SLYScreenWidth, SLYScreenWidth * 0.667)];
    
    
    self.headerImage = [[UIImageView alloc]init];
    
    [headerView addSubview:self.headerImage];
    
    [self.headerImage setImage:[UIImage imageNamed:self.title]];
    
    [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.right.bottom.equalTo(headerView);
    }];
    
    
    self.titleLab = [UILabel new];
    
    self.titleLab.backgroundColor = SLYColor(0xe61f31, 1);

    
    self.titleLab.clipsToBounds = YES;
    
    self.titleLab.layer.cornerRadius = 2;
    
    self.titleLab.textColor = [UIColor whiteColor];
    
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    
    self.titleLab.font = [UIFont boldSystemFontOfSize:18];
    
    
    self.titleLab.text = self.ArticleTitle;
    
    [headerView addSubview:self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(headerView.mas_top).offset(185/2);
        make.size.mas_equalTo(CGSizeMake(self.ArticleTitle.length * 20 + 20, 30 * SLYScreenScale));
        make.centerX.equalTo(headerView);
    }];
    
    
    self.content = [UILabel new];
    self.content.textColor = [UIColor whiteColor];
    
    self.content.numberOfLines = 0;
    
    self.content.attributedText = [SLYTools AttributedStringWithString:self.subcontent lineSpacing:5 FontSize:14 Color:[UIColor whiteColor]];
    self.content.textAlignment = NSTextAlignmentCenter;
      self.content.font = [UIFont boldSystemFontOfSize:14];
    
    [headerView addSubview:self.content];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(headerView).offset(12);
        make.right.equalTo(headerView).offset(-12);
        make.top.equalTo(self.titleLab.mas_bottom).offset(15);
    }];
    
  
    self.tableView.tableHeaderView = headerView;
    
    
}

-(void)setupNavItem{
    
    self.title = self.ArticleTitle;
    
    
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [back setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    
    back.frame = CGRectMake(0, 0, back.currentImage.size.width, back.currentImage.size.height);
    
    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    
}


-(void)setupTableView{
    
    if([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]){
    
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableView.backgroundColor = SLYColor(0xf4f4f4, 1);
    
    
    if(self.type == ArticelListTypeNotice){
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SLYNotesTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    }else if(self.type == ArticelListTypeTactics){
    
        [self.tableView registerNib:[UINib nibWithNibName:@"SLYStrategyTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }else{
    
        
        [self.tableView registerNib:[UINib nibWithNibName:@"SLYArticleListTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    }

    
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    
        if(self.type != ArticelListTypeTactics){
    
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            self.currentPage = 1;
            
            [self.lists removeAllObjects];
            
            [self loadList];
            
        }];
        
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            self.currentPage ++;
            
            [self loadList];
        }];
            
        [self.tableView.mj_header beginRefreshing];

        
    }
    

    

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
    Parms[@"type"] = [NSString stringWithFormat:@"%d",self.type];
    Parms[@"sign"] = [SLYTools getSignValue:Parms];

    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_ArticleList Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
        
       NSArray * listArr = messageResponse.context[@"articles"][@"Result"];
        
        for (NSDictionary *  listDic in listArr) {
            
            SLYArticleModel *model = [SLYArticleModel yy_modelWithDictionary:listDic];
            
            [self.lists addObject:model];
        }
        
        [self.tableView cyl_reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        if(self.lists.count == [messageResponse.context[@"articles"][@"TotalCount"] intValue]){
        
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
        
            [self.tableView.mj_footer endRefreshing];

        }
        
    }];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.type == ArticelListTypeNotice){
    
        SLYNotesTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
        
        cell.model = self.lists[indexPath.row];


        return cell;
        
    }
    
    if(self.type == ArticelListTypeTactics){
        
        SLYStrategyTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
        
        cell.indexPath = indexPath;
        
        return cell;
        
    }
    
    
    SLYArticleListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.lists[indexPath.row];
    
    return  cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    self.tableView.mj_footer.hidden = !self.lists.count;
    
    int rowCount = (int)self.lists.count;
    
    if(self.type == ArticelListTypeTactics){
    
        rowCount = 2;
    }
    
    return rowCount;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(self.type == ArticelListTypeTactics){
        
        return 100;
    }
    SLYArticleModel *model = self.lists[indexPath.row];

    
    if(self.type == ArticelListTypeNotice){
        
    
        CGFloat titleHeight = [SLYTools getCellHightWithString:model.Title Size:CGSizeMake(SLYScreenWidth - 24, 100) Fontsize:16 lineSpacing:5];
        
        CGFloat contentHeight = [SLYTools getCellHightWithString:model.Intro Size:CGSizeMake(SLYScreenWidth - 24, 61) Fontsize:14 lineSpacing:5];
        
          return titleHeight + contentHeight + 100;


    }
    
    CGFloat titleHeight = [SLYTools getCellHightWithString:model.Title Size:CGSizeMake(SLYScreenWidth - 24, 100) Fontsize:16 lineSpacing:5];
    
    CGFloat contentHeight = [SLYTools getCellHightWithString:model.Intro Size:CGSizeMake(SLYScreenWidth - 24, 61) Fontsize:14 lineSpacing:5];
    
    return titleHeight + contentHeight + 15 + 15 + 15 + 15 + 10;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(self.type == ArticelListTypeTactics){
    
        ETCTacticsViewController *tact = [[ETCTacticsViewController alloc]init];
        
        tact.tacticsType = (int)indexPath.row;
        
        [self.navigationController pushViewController:tact animated:YES];
        
        return;
        
    }
    
    SLYArticleDetailViewController * detail = [[SLYArticleDetailViewController alloc]init];
    
    SLYArticleModel *model = self.lists[indexPath.row];
    
    [detail setHidesBottomBarWhenPushed:YES];
    
    detail.articelId = model.Id;
    
    [self.navigationController pushViewController:detail animated:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    if(self.tableView.contentOffset.y + 20 > SLYScreenWidth * 0.667){
        
        [self.navigationController.navigationBar setHidden:NO];
        
    }else{
        
        [self.navigationController.navigationBar setHidden:YES];
        
    }
}
//完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
{
    if(self.tableView.contentOffset.y + 20 > SLYScreenWidth * 0.667){
        
        
        [self.navigationController.navigationBar setHidden:NO];
        
        
    }else{
        
        [self.navigationController.navigationBar setHidden:YES];
        
    };
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView;
{
    
    if(self.tableView.contentOffset.y + 20 > SLYScreenWidth * 0.667){
        
        
        [self.navigationController.navigationBar setHidden:NO];
        
        
    }else{
        
        [self.navigationController.navigationBar setHidden:YES];
        
    };
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    if(self.tableView.contentOffset.y + 20 > SLYScreenWidth * 0.667){
        
        
        [self.navigationController.navigationBar setHidden:NO];
        
        
    }else{
        
        [self.navigationController.navigationBar setHidden:YES];
        
    };
}



@end
