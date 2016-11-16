//
//  SLYLiveViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYLiveViewController.h"
#import "SLYLiveVideoCell.h"
#import "SLYLiveListViewController.h"
#import "SLYVHPlayer.h"
#import "AppDelegate.h"
#import "FullViewController.h"
#import "VHallApi.h"


@interface SLYLiveViewController ()<SLYLiveVideoDelegate,SLYVHPlayerDelegate>

@property (strong, nonatomic) IBOutlet SLYLiveVideoCell *videoItem1;

@property (strong, nonatomic) IBOutlet SLYLiveVideoCell *videlItem2;

@property (strong, nonatomic) IBOutlet SLYLiveVideoCell *videlItem3;

@property (strong, nonatomic) IBOutlet SLYLiveVideoCell *videlItem4;

@property (strong, nonatomic) IBOutlet UIView *VideoView;

@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *teacherName;
@property (strong, nonatomic) IBOutlet UILabel *contentLab;




@property (nonatomic, strong) FullViewController *fullView;

@property (strong, nonatomic) SLYVHPlayer * slyVHPlayer;

@property (strong, nonatomic) NSMutableDictionary * VideoInfo;

@property (strong, nonatomic) UILabel * status;

@end

@implementation SLYLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = SLYColor(0xf4f4f4, 1);
    
    [self setupItems];
    
    [self setupWHVideo];
    
    [self setupLab];
    
    
}

-(NSMutableDictionary *)VideoInfo{
    
    if(_VideoInfo == nil){
        
        _VideoInfo = [[NSMutableDictionary alloc]init];;
    }
    
    return _VideoInfo;
}

-(void)setupLab{

    self.status = [UILabel new];
    
    [self.VideoView addSubview:self.status];
    
    [self.VideoView bringSubviewToFront:self.status];
    
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.left.equalTo(self.VideoView).offset(12);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    self.status.textAlignment = NSTextAlignmentCenter;
    
    self.status.clipsToBounds = YES;
    
    self.status.layer.cornerRadius = 5;
    self.status.text = @"直播中";
    
    self.status.font = [UIFont systemFontOfSize:15];
    
    self.status.textColor = [UIColor whiteColor];
    
    self.status.backgroundColor = SLYColor(0xf55723, 1);

    
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    self.slyVHPlayer.style = 1;
 
    
    [self getVideoinfo];

}


-(void)getVideoinfo{
    
    NSMutableDictionary * param = [[NSMutableDictionary alloc]init];

    param[@"id"] = [SLYConfig sharedInstance].Id;
    
    param[@"sign"] = [SLYTools getSignValue:param];


    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_VideoLiveInfo Parms:param completion:^(SLYMessageResponse *messageResponse, NSError *err) {
       
        
        self.VideoInfo = [messageResponse.context[@"video"] mutableCopy];
        
        
        NSString *AppKey =  messageResponse.context[@"appkey"][@"AppKey"];
        NSString *AppSecretKey =  messageResponse.context[@"appkey"][@"AppSecretKey"];
        
        [VHallApi registerApp:AppKey SecretKey:AppSecretKey];

        if([self.VideoInfo[@"Item2"] intValue] == 1){
        
            self.status.text = @"直播中";
            
            NSMutableDictionary * param = [[NSMutableDictionary alloc]init];
            
            param[@"name"] = [SLYConfig sharedInstance].userName;
            
            param[@"id"] = [NSString stringWithFormat:@"%@",self.VideoInfo[@"Item1"][@"Room_id"]];
            
            param[@"email"] = [NSString stringWithFormat:@"%@@cjzkw.com",[SLYConfig sharedInstance].userName];
            
            
//            NSMutableDictionary * signparam = [[NSMutableDictionary alloc]init];
//            
//            signparam[@"username"] = param[@"email"];
//            
//            signparam[@"roomid"] = param[@"id"];
//
//            param[@"pass"] =  [SLYTools getSignValue:signparam];

            
            self.slyVHPlayer.param = param;
            
            [self.slyVHPlayer play];
            
            
        }else{
        
            self.status.text = @"预告";
        
        }
     
        self.titleLab.text = self.VideoInfo[@"Item1"][@"Title"];
        self.contentLab.text = self.VideoInfo[@"Item1"][@"B_time"];
        self.teacherName.text = self.VideoInfo[@"Item1"][@"Teacher"];
        
        [self.slyVHPlayer.livebgImage  sd_setImageWithURL:[NSURL URLWithString:self.VideoInfo[@"Item1"][@"Img_url"]] placeholderImage:[UIImage imageNamed:@"视频-加载中显示"]];
        

    }];
}

-(void)setupWHVideo{

    self.slyVHPlayer = [[[NSBundle mainBundle] loadNibNamed:@"SLYVHPlayer" owner:nil options:nil] lastObject];
    
    self.slyVHPlayer.frame = CGRectMake(0, 0, SLYScreenWidth, SLYScreenWidth / 1.78);
    
    self.slyVHPlayer.delegate = self;
    
    [self.VideoView addSubview:self.slyVHPlayer];
    
}


- (FullViewController *)fullView
{
    if (_fullView == nil) {
        
        _fullView = [[FullViewController alloc] init];
    }
    return _fullView;
}

-(void)videoplayViewSwitchOrientation:(BOOL)isFull
{
    
    if (isFull) {
        
        AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        delegate.allowRotate = 1;
        [self presentViewController:self.fullView animated:YES completion:^{
            self.slyVHPlayer.frame = self.fullView.view.bounds;
            [self.fullView.view addSubview:self.slyVHPlayer];
            
            if([self.VideoInfo[@"State"] intValue] == 1){
            
                self.slyVHPlayer.style = 1;
                [self.slyVHPlayer  play];
            }
    
           
        }];
    } else {
        
        [self.fullView dismissViewControllerAnimated:YES completion:^{
            
            [self.VideoView addSubview:self.slyVHPlayer];
            
            [self.VideoView bringSubviewToFront:self.status];

            self.slyVHPlayer.frame = CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.width*9/16);
            AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            delegate.allowRotate = 0;
            
        }];
    }
}




-(void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
    self.slyVHPlayer.style = 0;

    [self.slyVHPlayer stopPlay];
}

-(void)setupItems{
    
    NSArray *items = @[@"基础课程",@"头条情报",@"今日解盘",@"黑马精选"];

    self.videoItem1.delegate = self;
    self.videoItem1.title.text = items[0];
    self.videoItem1.bgimage.image = [UIImage imageNamed:items[0]];
    
    
    self.videlItem2.delegate = self;
    self.videlItem2.title.text = items[1];
     self.videlItem2.bgimage.image = [UIImage imageNamed:items[1]];

    self.videlItem3.delegate = self;
    self.videlItem3.title.text = items[2];
     self.videlItem3.bgimage.image = [UIImage imageNamed:items[2]];

    self.videlItem4.delegate = self;
    self.videlItem4.title.text = items[3];
     self.videlItem4.bgimage.image = [UIImage imageNamed:items[3]];

    
}

-(void)selectItemLiveVideo:(SLYLiveVideoCell *)LiveVideo{

    SLYLiveListViewController *list = [[SLYLiveListViewController alloc]init];
    
    list.type = [NSString stringWithFormat:@"%d",(int)LiveVideo.tag - 200 +1];
    
    [list setHidesBottomBarWhenPushed:YES];
    
    [self.navigationController pushViewController:list animated:YES];
}





@end
