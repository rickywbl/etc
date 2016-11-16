//
//  SLYMessageViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYMessageViewController.h"
#import "SLYReMessageTableViewCell.h"
#import "SLYArticleModel.h"

static NSString * Identifier  = @"message";

@interface SLYMessageViewController ()<UITabBarDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray * messages;
@property (assign, nonatomic) int currentPage;

@end

@implementation SLYMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor redColor];
    
    
    [self setupTableView];
    
    
    
}

-(NSMutableArray *)messages{
    
    if(_messages == nil){
        
        _messages = [[NSMutableArray alloc]init];
    }
    
    return _messages;
}


-(void)loadMessages{


    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
    Parms[@"index"] = [NSString stringWithFormat:@"%d",self.currentPage];
    Parms[@"size"] = @"10";
    Parms[@"id"] = [SLYConfig sharedInstance].Id;
    Parms[@"sign"] = [SLYTools getSignValue:Parms];
    
    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_MessageList Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
        
        NSArray * listArr = messageResponse.context[@"articles"][@"Result"];
        
        int TotalCount = [messageResponse.context[@"articles"][@"TotalCount"] intValue];
        
        for (NSDictionary *  listDic in listArr) {
            
            SLYArticleModel *model = [SLYArticleModel yy_modelWithDictionary:listDic];
            
            [self.messages addObject:model];
        }
        
        [self.TableView reloadData];
        
        [self.TableView.mj_header endRefreshing];
        
        if(self.messages.count == TotalCount){
            
            [self.TableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.TableView.mj_footer endRefreshing];
            
        }
        
    }];

    
}

-(void)setupTableView{

    
    [self.TableView registerNib:[UINib nibWithNibName:@"SLYReMessageTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    self.TableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        self.currentPage = 1;
        
        [self.messages removeAllObjects];
        
        [self loadMessages];
    }];
    
    
    self.TableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       
        self.currentPage++;
        
        [self loadMessages];

        
    }];
    
    [self.TableView.mj_header beginRefreshing];
    
    self.TableView.tableFooterView = [[UIView alloc]init];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SLYReMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    SLYArticleModel * model = self.messages[indexPath.row];
    
    cell.model = model;

    
    return  cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    self.TableView.mj_footer.hidden = !self.messages.count;
    
    return  self.messages.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SLYReMessageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.readImage setHidden:YES];
    
    
    SLYArticleDetailViewController * detail = [[SLYArticleDetailViewController alloc]init];
    
    SLYArticleModel *model = self.messages[indexPath.row];
    
    detail.articelId = model.Id;
    
    
    [detail setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}


@end
