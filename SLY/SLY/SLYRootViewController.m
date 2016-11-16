//
//  SLYRootViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYRootViewController.h"
#import "SLYTabbleBarViewController.h"
#import "SLYLeftMenuView.h"
#import "SLYRiskViewViewController.h"
#import "SLYNoticeViewController.h"
#import "SLYPhoneViewController.h"
#import "SLYTipsViewController.h"
#import "SLYAccountViewController.h"
#import "CPAcountViewController.h"

#define menuViewWidth 200



@interface SLYRootViewController ()

@end

@implementation SLYRootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupChinaViewController];

    
    if(![SLYConfig sharedInstance].agreement){
    
        SLYNoticeViewController *nof= [[SLYNoticeViewController alloc]init];
        [self presentViewController:nof animated:YES completion:nil];
    }

    
    self.menuView.frame = CGRectMake(-menuViewWidth, 0, menuViewWidth, SLYScreenHeight);
    
    [[self.menuView.Risk rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        SLYRiskViewViewController * risk = [[SLYRiskViewViewController alloc]init];
        
        [self.navigationController pushViewController:risk animated:YES];
    }];
    
    [[self.menuView.Tel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        SLYPhoneViewController *phone = [[SLYPhoneViewController alloc]init];
        [self.navigationController pushViewController:phone animated:YES];
    }];
    
    [[self.menuView.Special rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        SLYTipsViewController *tips = [[SLYTipsViewController alloc]init];
        [self.navigationController pushViewController:tips animated:YES];


    }];
    
    [[self.menuView.AcountManage rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        CPAcountViewController *tips = [[CPAcountViewController alloc]init];
        [self.navigationController pushViewController:tips animated:YES];
        
        
    }];
    
    self.menuView.Exit.layer.borderWidth = 0.5;
    self.menuView.Exit.layer.borderColor = [UIColor whiteColor].CGColor;
    self.menuView.Exit.layer.cornerRadius = 5;
    self.menuView.Exit.clipsToBounds = YES;
    
    [[self.menuView.Exit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"确定退出账号" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            SLYLoginViewController * root = [[SLYLoginViewController alloc]init];
            [UIApplication sharedApplication].keyWindow.rootViewController = root;
            
            [[SLYConfig sharedInstance] clearLogin];

        }];
        
        
        [alter addAction:action];
        
        [alter addAction:action1];
        
        [self presentViewController:alter animated:YES completion:nil];
        
        
    }];
    
    

    [self hideMenuView];

    [self.navigationController.navigationBar setHidden:YES];
 
}



-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];

    
}

-(SLYLeftMenuView *)menuView{
    
    if(_menuView == nil){
        
        _menuView = [[[NSBundle mainBundle] loadNibNamed:@"SLYLeftMenuView" owner:nil options:nil] lastObject];
        
        _menuView.frame = CGRectMake(-menuViewWidth, 0, menuViewWidth, SLYScreenHeight);
        
        [self.view addSubview:_menuView];
    }
    
    return _menuView;
}



-(void)showMenuView{
    
    self.show  = [NSNumber numberWithBool:YES];

    [UIView animateWithDuration:0.5 animations:^{
       
        self.menuView.frame = CGRectMake(0, 0,menuViewWidth , SLYScreenHeight);
        
//        self.tabBar.view.frame = CGRectMake(menuViewWidth, 0, SLYScreenWidth, SLYScreenHeight);
    }];

}


-(void)hideMenuView{
    
    
    self.show = [NSNumber numberWithBool:NO];

    [UIView animateWithDuration:0.5 animations:^{
        
        self.menuView.frame = CGRectMake(-menuViewWidth, 0,menuViewWidth , SLYScreenHeight);
        
//        self.tabBar.view.frame = CGRectMake(0, 0, SLYScreenWidth, SLYScreenHeight);
    }];

}

-(void)setupChinaViewController{

    self.tabBar = [[SLYTabbleBarViewController alloc]init];
    
    [self.view addSubview:self.tabBar.view];
    
    self.tabBar.view.frame = self.view.bounds;
    
    [self addChildViewController:self.tabBar];
    
    [self.view bringSubviewToFront:self.menuView];
    


}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    [self hideMenuView];
}


@end
