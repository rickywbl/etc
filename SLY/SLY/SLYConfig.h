//
//  SLYConfig.h
//  SLY
//
//  Created by 王保霖 on 2016/10/20.
//  Copyright © 2016年 Ricky. All rights reserved.
//


#define CG_UserName @"userName"
#define CG_Sign @"sign"
#define CG_password @"password"
#define CG_token @"token"
#define CG_Id @"Id"
#define CG_FirstLaunch @"firstLaunch"
#define CG_Agreement @"agreement"
#define CG_expiration @"expiration"
#define CG_Remember @"remember"

#import <Foundation/Foundation.h>

@interface SLYConfig : NSObject

//用户名
@property (strong, nonatomic) NSString * userName;
//密码
@property (strong, nonatomic) NSString * password;
//Token
@property (strong, nonatomic) NSString * token;
//过期时间
@property (strong, nonatomic) NSString * expiration;

@property (strong, nonatomic) NSNumber * firstLaunch;

@property (strong, nonatomic) NSNumber * agreement;

@property (strong, nonatomic) NSNumber * remember;

@property (strong, nonatomic) NSString * UUID;

@property (strong, nonatomic) NSString * sign;

@property (strong, nonatomic) NSString * Id;

//sign




+ (instancetype)sharedInstance;

-(void)clearLogin;

-(BOOL)loginStatus;

@end
