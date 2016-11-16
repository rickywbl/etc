//
//  SLYLoginViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/10/20.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYLoginViewController.h"
#import "SLYRootViewController.h"
#import "GuideView.h"


@interface SLYLoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *UserName;
@property (strong, nonatomic) IBOutlet UITextField *Password;
@property (strong, nonatomic) IBOutlet UIButton *login;
@property (strong, nonatomic) IBOutlet UIButton *Rememb;

@end

@implementation SLYLoginViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupInterfance];



}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    

    self.Rememb.selected = [[SLYConfig sharedInstance].remember boolValue];
    
    if(self.Rememb.selected){
    
        self.UserName.text = [SLYConfig sharedInstance].userName;
        self.Password.text = [SLYConfig sharedInstance].password;
    }
    
    
}

-(void)setupInterfance{

    UIImageView *usernameLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    usernameLeft.contentMode = UIViewContentModeCenter;
    
    [usernameLeft setImage:[UIImage imageNamed:@"icon-用户名"]];
    
    self.UserName.leftView = usernameLeft;
    
    self.UserName.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIImageView *passwordLeft = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    passwordLeft.contentMode = UIViewContentModeCenter;
    
    [passwordLeft setImage:[UIImage imageNamed:@"icon-密码"]];
    
    self.Password.leftView = passwordLeft;
    
    self.Password.leftViewMode = UITextFieldViewModeAlways;
    
    
    [[self.Rememb rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton * x) {
        
        [SLYConfig sharedInstance].remember = [NSNumber numberWithBool:!x.selected];
        
        x.selected = !x.selected;
        

    }];
    
    
    [[self.login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [self loginAction];
    }];
    
    

}


-(void)loginAction{
    
    NSString * name = [self.UserName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.Password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
    
    Parms[@"name"] = name;
    Parms[@"password"] = password;
    Parms[@"popedom"] = [SLYConfig sharedInstance].UUID;
    
    
    NSString *path = [NSString stringWithFormat:@"%@?name=%@&password=%@&popedom=%@&sign=%@",SLYNet_Login,name,password,[SLYConfig sharedInstance].UUID, [SLYTools getSignValue:Parms]];
    
    
    
    
    [SVProgressHUD showWithStatus:@"登录中..."];
    
    [[SLYNetRequestManage sharedInstance] SLYPostWithUrl:path Parms:nil
                                              completion:^(SLYMessageResponse *messageResponse, NSError *err) {
        
        
        if(messageResponse.Succeed){
        
            [SVProgressHUD dismiss];
    
            [SLYConfig sharedInstance].Id = [NSString stringWithFormat:@"%@",messageResponse.context[@"memberInfo"][@"Id"]];
            [SLYConfig sharedInstance].userName = messageResponse.context[@"memberInfo"][@"Real_name"];
            [SLYConfig sharedInstance].password = self.Password.text;
            [SLYConfig sharedInstance].expiration = messageResponse.context[@"memberInfo"][@"End_date"];
            
            SLYRootViewController * root = [[SLYRootViewController alloc]init];
            
            [UIApplication sharedApplication].keyWindow.rootViewController = [[SLYNavigationController alloc]initWithRootViewController:root];
        }else{
        
            [SVProgressHUD showErrorWithStatus:messageResponse.Message];
        
        }
        
    }];

}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    if(textField == self.UserName){
    
        [self.Password becomeFirstResponder];
    
    }
    
    if(textField == self.Password){
        
        [self.Password resignFirstResponder];
    
        [self loginAction];
    }
    

    return YES;

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [SVProgressHUD dismiss];
    [self.view endEditing:YES];

}





@end
