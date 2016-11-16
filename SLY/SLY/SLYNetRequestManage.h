//
//  SLYNetRequestManage.h
//  SLY
//
//  Created by 王保霖 on 2016/10/18.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class SLYMessageResponse;

@interface SLYNetRequestManage : NSObject

@property (nonatomic, assign) AFNetworkReachabilityStatus networkStatus;


+ (instancetype)sharedInstance;
- (void)startMonitoringNetworkStatus;
- (void)stopMonitoringNetworkStatus;
- (void)checkNetworkStatus;



-(void)SLYGetWithUrl:(NSString *)path Parms:(NSDictionary *)parms completion:(void (^)(SLYMessageResponse * messageResponse, NSError *err))completion;

-(void)SLYPostWithUrl:(NSString *)path Parms:(NSDictionary *)parms completion:(void (^)(SLYMessageResponse * messageResponse, NSError *err))completion;


@end
