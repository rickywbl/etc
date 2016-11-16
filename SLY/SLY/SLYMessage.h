//
//  SLYMessage.h
//  SLY
//
//  Created by 王保霖 on 2016/10/18.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLYMessage : NSObject

@property(nonatomic, strong) NSMutableDictionary *context;
@property(nonatomic, strong) NSString * Message;
@property(nonatomic, assign) int  TotalCount;
@property(nonatomic, assign) BOOL  Succeed;

- (void) fromString:(NSString*)message;
- (NSString*) toString;
-(void)fromDic:(NSDictionary *)messageDic;

@end
