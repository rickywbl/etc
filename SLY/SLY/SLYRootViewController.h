//
//  SLYRootViewController.h
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SLYLeftMenuView;
@class SLYTabbleBarViewController;

@interface SLYRootViewController : UIViewController

@property (strong, nonatomic) SLYTabbleBarViewController * tabBar;

@property(strong,nonatomic)SLYLeftMenuView * menuView;

@property(strong,nonatomic)NSNumber * show;


-(void)showMenuView;
-(void)hideMenuView;

@end
