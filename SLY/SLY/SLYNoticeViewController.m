//
//  SLYNoticeViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/10/17.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYNoticeViewController.h"

@interface SLYNoticeViewController (){

    BOOL  isSure;
}
@property (strong, nonatomic) IBOutlet UIButton *startUse;
@property (strong, nonatomic) IBOutlet UIButton *read;

@end

@implementation SLYNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isSure = NO;

    self.startUse.layer.borderColor = [UIColor redColor].CGColor;
    
    self.startUse.layer.borderWidth = 1;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];


}
- (IBAction)start:(id)sender {
    
    
    if(isSure == YES){
        
        [SLYConfig sharedInstance].agreement = [NSNumber numberWithBool:YES];
        
        NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
        Parms[@"mid"] = [SLYConfig sharedInstance].Id;
        Parms[@"sign"] = [SLYTools getSignValue:Parms];
        
        [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_AccountProtocol Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
            
            
            if([messageResponse.Message isEqualToString:@"添加成功"] || [messageResponse.Message isEqualToString:@"已添加"]){
            
                [self dismissViewControllerAnimated:YES completion:nil];

            }else{
            
                [SVProgressHUD showErrorWithStatus:@"网络异常! 请重新验证!"];
            }
            
        }];
        
        
    }else{
    
        [SVProgressHUD showInfoWithStatus:@"请阅读相关条款"];
    }
    
}

- (IBAction)readAction:(UIButton *)sender {

    sender.selected = !sender.selected;
    
    isSure = !isSure;
}


@end
