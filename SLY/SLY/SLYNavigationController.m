//
//  SLYNavigationController.m
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//


#define SLYNavTitleColor SLYColor(0xffffff,1)
#define SLYNavBarColor SLYColor(0xe93030,1)

#import "SLYNavigationController.h"

@interface SLYNavigationController ()

@end

@implementation SLYNavigationController

- (void)viewDidLoad {
    
    [super viewDidLoad];

}

+(void)load{

    UINavigationBar *bar = [UINavigationBar appearance];
    
    //Bar
    
    [bar setBarTintColor:SLYNavBarColor];
    
    
    //BarTitle
    
    NSMutableDictionary * Attributes = [NSMutableDictionary dictionary];
    
    [Attributes setObject:[UIFont boldSystemFontOfSize:20] forKey:NSFontAttributeName];
    
    [Attributes setObject:SLYNavTitleColor forKey:NSForegroundColorAttributeName];
    
    [bar setTitleTextAttributes:Attributes];

}

@end
