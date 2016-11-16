//
//  SLYLiveListViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/10/19.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYLiveListViewController.h"
#import "SLYVideoListTableViewCell.h"
#import "SLYVideoModel.h"
#import "SLYVideoDetailViewController.h"

static NSString * Identifier = @"Video";


@interface SLYLiveListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray * videos;
@property(assign,nonatomic)int currentPage;



@end

@implementation SLYLiveListViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupNav];
    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
}

-(void)setupNav{

    self.title = @"录播";
    
    
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [back setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    
    back.frame = CGRectMake(0, 0, back.currentImage.size.width, back.currentImage.size.height);
    
    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    
}


#pragma mark --- layer

-(NSMutableArray *)videos{
    
    if(_videos == nil){
        
        _videos = [[NSMutableArray alloc]init];
    }
    
    return _videos;
}

-(void)loadVideos{
    
    
    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
    Parms[@"index"] = [NSString stringWithFormat:@"%d",self.currentPage];
    Parms[@"size"] = @"20";
    Parms[@"type"] = self.type;
    Parms[@"sign"] = [SLYTools getSignValue:Parms];

    
    
    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_VideoList Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
       
        if(!err){
        
            NSArray * videoArr = messageResponse.context[@"articles"][@"Result"];
            
            for (NSDictionary * videoDic in videoArr) {
                
                SLYVideoModel *model = [SLYVideoModel yy_modelWithDictionary:videoDic];
                
                [self.videos addObject:model];
            }
            
            
            [self.tableView reloadData];
            
            [self.tableView.mj_header endRefreshing];
            
            
            if(self.videos.count == 0){
            
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            else{
            
                [self.tableView.mj_footer endRefreshing];

            }
        
        }
    }];

}

-(void)setupTableView{

    
    [self.tableView registerNib:[UINib nibWithNibName:@"SLYVideoListTableViewCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.currentPage = 1;
        
        [self.videos removeAllObjects];
        
        [self loadVideos];
        
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        self.currentPage ++;
        
        [self loadVideos];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SLYVideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];

    SLYVideoModel * model =  self.videos[indexPath.row];
    
    cell.titleLab.font = [UIFont systemFontOfSize:17];
    
    cell.titleLab.textColor = SLYColor(0x333333, 1);
    
    cell.teacher.textColor = SLYColor(0x666666, 1);
    
    cell.teacher.font = [UIFont systemFontOfSize:14];
    
    cell.time.textColor = SLYColor(0x666666, 1);
    
    cell.time.font = [UIFont systemFontOfSize:14];
    
    
    NSMutableAttributedString *attri = [[SLYTools AttributedStringWithString:model.Title lineSpacing:5 FontSize:16 Color:SLYColor(0x333333, 1)] mutableCopy];
    
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:@"video_new"];
    // 设置图片大小
    attch.bounds = CGRectMake(5, 5, 20, 12);
    
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [attri insertAttributedString:string atIndex:model.Title.length];
    
    cell.titleLab.attributedText = attri;
    
    cell.teacher.text = model.Teacher;
    
    cell.time.text = model.Create_time;
    
    [cell.contetnImage sd_setImageWithURL:[NSURL URLWithString:model.Img_url] placeholderImage:[UIImage imageNamed:@"视频-加载中显示"]];
    
    
    return  cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.videos.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SLYVideoModel * model =  self.videos[indexPath.row];
    
    CGFloat height =   [SLYTools getCellHightWithString:model.Title Size:CGSizeMake(SLYScreenWidth - 24, 500) Fontsize:17 lineSpacing:5];
    
    return height + 15 + 10 + 15 + 10 + (SLYScreenWidth -24) /1.777 + 15;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    SLYVideoDetailViewController *video = [[SLYVideoDetailViewController alloc]init];
    
     SLYVideoModel * model =  self.videos[indexPath.row];
    
    video.videoModel = model;
    
    [self.navigationController pushViewController:video animated:YES];
    
}

@end
