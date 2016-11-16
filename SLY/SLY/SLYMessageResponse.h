//
//  SLYMessageResponse.h
//  SLY
//
//  Created by 王保霖 on 2016/10/18.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLYMessage.h"
@interface SLYMessageResponse : SLYMessage

@property (nonatomic, copy, readonly) NSString *responseString;


+(id)responseWithReponseObjc:(id)responseObjc;

+(id)responseWithReponseDic:(NSDictionary *)responseDic;
-(instancetype)initWithReponseDic:(NSDictionary *)responseDic;

@end
