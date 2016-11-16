//
//  SLYVHPlayer.m
//  SLY
//
//  Created by 王保霖 on 2016/10/21.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYVHPlayer.h"
#import "VHallMoviePlayer.h"

@interface SLYVHPlayer()<VHallMoviePlayerDelegate>
@property (strong, nonatomic) VHallMoviePlayer * moviePlayer;

@property (strong, nonatomic) IBOutlet UIView *TooleView;

@property (assign, nonatomic) BOOL isShow;

@property (assign, nonatomic) BOOL isplay;

@property (strong, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation SLYVHPlayer

-(void)awakeFromNib{

    [super awakeFromNib];
    
    [self setupWHVideo];
}


- (IBAction)playAction:(UIButton *)sender {
    
    
    if(self.isplay){
        

        [self stopPlay];
        
    }else{
    
        [self play];
    }
    
    sender.selected = !sender.selected;
    
    
}


-(void)stopPlay{

    self.isplay = NO;
    
    [self.playButton setSelected:YES];

    [self.moviePlayer stopPlay];
}

- (void)destoryMoivePlayer
{
    [self.moviePlayer destroyMoivePlayer];
}

-(void)setupWHVideo{
    
    self.isShow = NO;
    
    self.moviePlayer = [[VHallMoviePlayer alloc]initWithDelegate:self];
    
    self.moviePlayer.movieScalingMode = kRTMPMovieScalingModeAspectFit;
    
    [self addSubview:self.moviePlayer.moviePlayerView];
    
    [self.moviePlayer setDefinition:VHallMovieDefinitionOrigin];
    
    [self.moviePlayer setPlayMode:VHallMovieVideoPlayModeMedia];
        
    [self.TooleView removeFromSuperview];
    
    [self.moviePlayer.moviePlayerView addSubview:self.TooleView];
    
    [self.TooleView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.left.right.equalTo(self.moviePlayer.moviePlayerView);
        make.height.equalTo(@50);
    }];
    
    [self.TooleView setHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [self.moviePlayer.moviePlayerView addGestureRecognizer:tap];

}

-(void)play{
    
    self.isplay = YES;
    
    [self.playButton setSelected:NO];
    
    
    [self.moviePlayer startPlay:self.param];
            
}


- (IBAction)switchOrientation:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(videoplayViewSwitchOrientation:)]) {
        [self.delegate videoplayViewSwitchOrientation:sender.selected];
    }
}


-(void)tapAction:(UITapGestureRecognizer *)tap{

    self.TooleView.hidden = !self.isShow;
    
    self.isShow = !self.isShow;
}

-(void)layoutSubviews{

    self.moviePlayer.moviePlayerView.frame = CGRectMake(0, 0, SLYScreenWidth, SLYScreenWidth / 1.78);
}


#pragma mark - VHMoviePlayerDelegate

-(void)connectSucceed:(VHMoviePlayer *)moviePlayer info:(NSDictionary *)info
{
    
    if(self.style == 0){
    
        [moviePlayer stopPlay];
    }
    
    switch (_moviePlayer.curDefinition) {
        case VHallMovieDefinitionOrigin:
            break;
        case VHallMovieDefinitionUHD:
            break;
        case VHallMovieDefinitionHD:
            break;
        case VHallMovieDefinitionSD:
            break;
        default:
            break;
    }
}




-(void)downloadSpeed:(VHMoviePlayer *)moviePlayer info:(NSDictionary *)info
{
    
    NSLog(@"downloadSpeed:%@",[info description]);
}



- (void)playError:(LivePlayErrorType)livePlayErrorType info:(NSDictionary *)info;
{
    
    NSString *msg;
    
    switch (livePlayErrorType) {
        case kLivePlayParamError:
        {
            msg = @"参数错误";
        }
            break;
        case kLivePlayRecvError:
        {
            msg = @"对方已经停止直播";
        }
            break;
        case kLivePlayCDNConnectError:
        {
            msg = @"服务器任性...连接失败";
        }
            break;
        case kLivePlayGetUrlError:
        {
            msg = @"获取服务器地址报错";
            
        }
            break;
        default:
            break;
    }
    
    NSLog(@"%@",msg);
}

- (void)netWorkStatus:(VHMoviePlayer*)moviePlayer info:(NSDictionary*)info
{
    NSLog(@"netWorkStatus:%f",[info[@"content"]floatValue]);
}



@end
