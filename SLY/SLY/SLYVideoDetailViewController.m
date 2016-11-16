//
//  SLYVideoDetailViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/10/20.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYVideoDetailViewController.h"
#import "SLYVideoHeaderView.h"
#import "SLYVideoModel.h"
#import "VideoPlayView.h"
#import "FullViewController.h"
#import "AppDelegate.h"
#import "SLYVideoCommentCell.h"
#import "SLYCommentModel.h"
#import "NewCommentView.h"

static NSString * Identifier = @"comment";

@interface SLYVideoDetailViewController ()<VideoPlayViewDelegate,UITextViewDelegate>
@property (strong, nonatomic) SLYVideoHeaderView * headerView;
@property (nonatomic, weak) VideoPlayView *playView;

@property (nonatomic, strong) FullViewController *fullView;
@property (strong, nonatomic) NSMutableArray * Commets;
@property (assign, nonatomic) int currentpage;
@property (strong, nonatomic) IBOutlet UIButton *commentButton;
@property(nonatomic,strong)NewCommentView *commentView;

@end

@implementation SLYVideoDetailViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[self.commentButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [self BecomeTextfield];
    }];
    
    [self setupNavItem];
    
    [self setupHeaderView];
    
    [self setupTableView];
    
    
    [self setupVideoPlayView];

    [self.tableView.mj_header beginRefreshing];
    
}

-(NSMutableArray *)Commets{
    
    if(_Commets == nil){
        
        _Commets = [[NSMutableArray alloc]init];
    }
    
    return _Commets;
}

-(NewCommentView *)commentView{
    
    if(_commentView == nil){
        
        _commentView =[[[NSBundle mainBundle]loadNibNamed:@"NewCommentView" owner:self options:nil] lastObject];
        
        _commentView.frame = CGRectMake(0,SLYScreenWidth-160,SLYScreenWidth,160);
        
        _commentView.ContentTextView.delegate = self;
        
        [self.commentView.Cancle addTarget:self action:@selector(cancleAction) forControlEvents:UIControlEventTouchUpInside];
        [self.commentView.Send addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:self.commentView];
    }
    
    return _commentView;
}

- (FullViewController *)fullView
{
    if (_fullView == nil) {
        
        _fullView = [[FullViewController alloc] init];
    }
    return _fullView;
}



-(void)sendAction{
    
    if(self.commentView.ContentTextView.text.length ==0 )
    {
        [CRToastManager showNotificationWithOptions:[SLYTools options:@"请输入评论内容!"]
                                     apperanceBlock:^(void) {
                                         NSLog(@"Appeared");
                                     }
                                    completionBlock:^(void) {
                                        NSLog(@"Completed");
                                    }];
        
    }
    else
    {
                NSString *encoded = [self.commentView.ContentTextView.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
        Parms[@"mid"] = [SLYConfig sharedInstance].Id;
        Parms[@"recId"] = self.videoModel.Id;
        Parms[@"content"] = encoded;
        Parms[@"sign"] = [SLYTools getSignValue:Parms];
        

        NSString *path = [NSString stringWithFormat:@"%@?mid=%@&recId=%@&content=%@&sign=%@",SLYNet_submitcomment,Parms[@"mid"],Parms[@"recId"],Parms[@"content"],Parms[@"sign"]];
        
        
        [[SLYNetRequestManage sharedInstance] SLYPostWithUrl:path Parms:nil completion:^(SLYMessageResponse *messageResponse, NSError *err) {
            
            
            [CRToastManager showNotificationWithOptions:[SLYTools options:messageResponse.Message]
                                         apperanceBlock:^(void) {
                                             NSLog(@"Appeared");
                                         }
                                        completionBlock:^(void) {
                                            
                                            [self cancleAction];
                                        }];

        }];
        
        
        
    }
}


-(void)setupTableView{

    [self.tableView registerNib:[UINib nibWithNibName:@"SLYVideoCommentCell" bundle:nil] forCellReuseIdentifier:Identifier];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        self.currentpage = 1;
        
        [self.Commets removeAllObjects];
        
        [self getCommets];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
       
        self.currentpage ++;
        [self getCommets];
        
        
    }];
}


-(void)ResignTextfield{
    
    [self.commentView.ContentTextView resignFirstResponder];
}

-(void)BecomeTextfield{
    
    [self.commentView.ContentTextView becomeFirstResponder];
}

-(void)cancleAction{
    
    [self.commentView.ContentTextView resignFirstResponder];
}


-(void)MakeDown{
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.commentView.frame =CGRectMake(0, SLYScreenHeight, SLYScreenWidth,0);
        
    } completion:^(BOOL finished) {
        
        [self.commentView.ContentTextView becomeFirstResponder];
        self.commentView.ContentTextView.text = @"";
    }];
}

- (void)keyboardWillShow:(NSNotification*)notification{
    
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:1 animations:^{
        
        self.commentView.frame =CGRectMake(0, SLYScreenHeight-keyboardRect.size.height-160, SLYScreenWidth, 160);
        
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)keyboardWillHide:(NSNotification*)notification{
    
    
    [UIView animateWithDuration:1 animations:^{
        
        self.commentView.frame =CGRectMake(0,SLYScreenHeight, SLYScreenWidth,0);

        
    } completion:^(BOOL finished) {
        
        [self.commentView.ContentTextView resignFirstResponder];
    }];
}





-(void)setupNavItem{
    
    self.title = @"视频正文";
    
    
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [back setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    
    back.frame = CGRectMake(0, 0, back.currentImage.size.width, back.currentImage.size.height);
    
    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.playView playDeloc];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    
}


- (void)setupVideoPlayView
{
    
    VideoPlayView *viewPlayView = [VideoPlayView videoPlayView];
    
    viewPlayView.frame = CGRectMake(0,0,SLYScreenWidth,SLYScreenWidth/1.78);
    
    [self.VideoView addSubview:viewPlayView];
    
    viewPlayView.delegate = self;
    
    self.playView = viewPlayView;
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:self.videoModel.Video_url]];
    
    [self.playView setPlayerItem:item];
    
}


-(void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    
    if (isFull) {
        
        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.allowRotate = 1;
        [self presentViewController:self.fullView animated:YES completion:^{
            
            self.playView.frame = self.fullView.view.bounds;
            
            [self.fullView.view addSubview:self.playView];
            
        }];
    } else {
        

        [self.fullView dismissViewControllerAnimated:YES completion:^{
            
            [self.view addSubview:self.playView];
            
            AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            delegate.allowRotate = 0;
            
            self.playView.frame = CGRectMake(0,64,self.view.bounds.size.width, self.view.bounds.size.width*9/16);
  
            
        }];
    }
}


-(void)getCommets{

    
    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
    Parms[@"index"] = [NSString stringWithFormat:@"%d",self.currentpage];
    Parms[@"size"] = @"10";
    Parms[@"recId"] = self.videoModel.Id;
    Parms[@"sign"] = [SLYTools getSignValue:Parms];

    
    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_commentList Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
        
        NSArray *commArr = messageResponse.context[@"articles"][@"Result"];
        
        for (NSDictionary * comDIc in commArr) {
        
            SLYCommentModel *model = [SLYCommentModel yy_modelWithDictionary:comDIc];
            
            [self.Commets addObject:model];
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];

        
        
    }];
    
}

-(void)setupHeaderView{

    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"SLYVideoHeaderView" owner:nil options:nil] lastObject];
    self.headerView.videoContent.attributedText = [SLYTools AttributedStringWithString:self.videoModel.Intro lineSpacing:5 FontSize:15 Color:SLYColor(0x333333, 1)];
    self.headerView.videoTitle.text = self.videoModel.Title;
    self.headerView.videoSource.text = self.videoModel.Source;
    self.headerView.time.text = self.videoModel.Create_time;
    self.tableView.tableHeaderView = self.headerView;
    
    CGFloat hight = [SLYTools getCellHightWithString:self.videoModel.Intro Size:CGSizeMake(SLYScreenWidth - 24, 500) Fontsize:15 lineSpacing:5];
    
    self.headerView.frame = CGRectMake(0, 0, SLYScreenWidth, hight + 110);
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SLYVideoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    SLYCommentModel *model = self.Commets[indexPath.row];
    
    cell.name.text = model.Account_name;
    cell.content.text = model.Content;
    cell.time.text = [model.Sub_time componentsSeparatedByString:@" "][0];
    
    return  cell;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.Commets.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 70;
}


-(void)dealloc{
    
    [self.playView playDeloc];
    
    NSLog(@"delloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

@end
