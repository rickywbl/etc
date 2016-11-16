//
//  SLYVHPlayer.h
//  SLY
//
//  Created by 王保霖 on 2016/10/21.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SLYVHPlayerDelegate <NSObject>

@optional

- (void)videoplayViewSwitchOrientation:(BOOL)isFull;

@end

@interface SLYVHPlayer : UIView

@property (strong, nonatomic) NSDictionary * param;

@property (strong, nonatomic) IBOutlet UIImageView *livebgImage;

@property (assign, nonatomic) int style;

@property (weak, nonatomic) id<SLYVHPlayerDelegate> delegate;
-(void)destoryMoivePlayer;
-(void)stopPlay;
-(void)play;

@end


