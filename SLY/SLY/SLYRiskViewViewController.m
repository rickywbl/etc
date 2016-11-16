//
//  SLYRiskViewViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/10/17.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYRiskViewViewController.h"

@interface SLYRiskViewViewController ()
@property (strong, nonatomic) IBOutlet UILabel *TitleLab;
@property (strong, nonatomic) IBOutlet UILabel *ContentLab;

@end

@implementation SLYRiskViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavItem];
    
}

-(void)setupNavItem{
    
    self.title = @"风险提示";
    
    
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [back setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    
    back.frame = CGRectMake(0, 0, back.currentImage.size.width, back.currentImage.size.height);
    
    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.navigationController popViewControllerAnimated:YES];
       
    }];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    self.navigationItem.leftBarButtonItem = backItem;
    

    
}

-(void)awakeFromNib{
    
    [super awakeFromNib];


}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
    

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
