//
//  SLYAccountViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/10/19.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYAccountViewController.h"

@interface SLYAccountViewController ()


@property (strong, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (strong, nonatomic) IBOutlet UIButton *back;
@property (strong, nonatomic) IBOutlet UIButton *sure;
@property (strong, nonatomic) IBOutlet UIImageView *headerIcon;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIButton *showChangeView;

@property (strong, nonatomic) IBOutlet UITextField *oldPwTF;

@property (strong, nonatomic) IBOutlet UITextField *rePwTF;

@property (strong, nonatomic) IBOutlet UITextField *setPwTF;

@property (strong, nonatomic) IBOutlet UIView *changPasswordView;


@end

@implementation SLYAccountViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [[self.back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}

- (void)keyboardWillShow:(NSNotification*)notification{
    
    CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
 
    [self.ScrollView setContentOffset:CGPointMake(0, keyboardRect.size.height)];
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];

}

- (void)keyboardWillHide:(NSNotification*)notification{
    
    
    [self.ScrollView setContentOffset:CGPointMake(0,0)];

}


@end
