//
//  SLYServiceViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYServiceViewController.h"
#import "SLYServiceTableViewCell.h"
#import "SLYTableViewHeaderView.h"


static NSString * Identifier = @"service";


@interface SLYServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray * messages;
@property(nonatomic,strong)SLYTableViewHeaderView *headerView;
@end

@implementation SLYServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setupTableView];
    
    [self loadMessages];

}

-(NSMutableArray *)messages{
    
    if(_messages == nil){
        
        _messages = [[NSMutableArray alloc]init];
    }
    
    return _messages;
}


-(SLYTableViewHeaderView *)headerView{
    
    if(_headerView == nil){
        
        _headerView = [[[NSBundle mainBundle] loadNibNamed:@"SLYTableViewHeaderView" owner:self options:nil] lastObject];
    }
    
    return _headerView;
}

-(void)setupTableView{
    
    self.TableView.tableFooterView = [[UIView alloc]init];

    [self.TableView registerNib:[UINib nibWithNibName:@"SLYServiceTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    self.headerView.frame = CGRectMake(0, 0, SLYScreenWidth, 60);
    self.TableView.tableHeaderView = self.headerView;

}



-(void)loadMessages{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MessageList.plist" ofType:nil];
    
    
    self.messages = [NSMutableArray arrayWithContentsOfFile:path];
    
    
    
    [self.TableView reloadData];
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SLYServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary * messDic = self.messages[indexPath.row];
    
    cell.teaName.text = messDic[@"name"];
    cell.headerImage.image = [UIImage imageNamed:messDic[@"image"]];
    
    return  cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.messages.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary * messDic = self.messages[indexPath.row];
    
    NSString * path = [NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",messDic[@"qq"]];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];


}
@end
