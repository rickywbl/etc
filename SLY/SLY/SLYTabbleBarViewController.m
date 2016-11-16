//
//  SLYTabbleBarViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYTabbleBarViewController.h"
#import "SLYHomeViewController.h"
#import "SLYLiveViewController.h"
#import "SLYMessageViewController.h"
#import "SLYServiceViewController.h"

@interface SLYTabbleBarViewController ()

@property (strong, nonatomic) NSMutableArray * tabbarViewControllers;

@end

@implementation SLYTabbleBarViewController



+(void)load{
    
//    UITabBar *bar = [UITabBar appearance];
//    
//    [bar setBarTintColor:CPTABBAR_COLOR];
    
    
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *SelectedAttributes = [[NSMutableDictionary alloc]init];
    SelectedAttributes[NSForegroundColorAttributeName] = SLYColor(0xe93030, 1) ;
    [item setTitleTextAttributes:SelectedAttributes forState:UIControlStateSelected];
    
    
    NSMutableDictionary *NormalAttributes = [[NSMutableDictionary alloc]init];
    NormalAttributes[NSForegroundColorAttributeName] = SLYColor(0x999999, 1);
    [item setTitleTextAttributes:NormalAttributes forState:UIControlStateNormal];
    
    
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    
    
    
    [self initChinaViewControllerWithViewController:[[SLYHomeViewController alloc]init] Title:@"首页" image:@"tabbar_home" SelectImage:@"tabbar_home_select"];
    
    [self initChinaViewControllerWithViewController:[[SLYLiveViewController alloc]init] Title:@"直播" image:@"tabbar_live" SelectImage:@"tabbar_live_select"];
    
    [self initChinaViewControllerWithViewController:[[SLYMessageViewController alloc]init] Title:@"消息" image:@"tabbar_message" SelectImage:@"tabbar_message_select"];
    
    [self initChinaViewControllerWithViewController:[[SLYServiceViewController alloc]init] Title:@"服务" image:@"tabbar_service" SelectImage:@"tabbar_service_select"];
    
    self.viewControllers = self.tabbarViewControllers;

}

#pragma mark --- Layer

-(NSMutableArray *)tabbarViewControllers{
    
    if(_tabbarViewControllers == nil){
        
        _tabbarViewControllers = [[NSMutableArray alloc]init];
    }
    
    return _tabbarViewControllers;
}



-(void)initChinaViewControllerWithViewController:(UIViewController *)viewController  Title:(NSString *)title image:(NSString *)imageName SelectImage:(NSString *)selectImageName{

    
    SLYNavigationController *navc = [[SLYNavigationController alloc]initWithRootViewController:viewController];
    
    viewController.title = title;
    
    viewController.tabBarItem.image = [UIImage imageNamed:imageName];
    
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    
    [self.tabbarViewControllers addObject:navc];
}

@end
