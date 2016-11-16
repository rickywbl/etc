//
//  SLYMessage.m
//  SLY
//
//  Created by 王保霖 on 2016/10/18.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYMessage.h"

@implementation SLYMessage

-(id)init {
    self = [super init];
    if ( self ) {
        
        self.context = [NSMutableDictionary new];
    }
    return self;
}

-(void)fromString:(NSString*)message {
    
    NSData *data = [message dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonObj = [NSJSONSerialization JSONObjectWithData:data
                                                 options:NSJSONReadingMutableContainers
                                                   error:nil];
    if ([jsonObj isKindOfClass:[NSMutableDictionary class]]) {
        
        [self fromDic:(NSDictionary *)jsonObj];
        
    } else {

    }
}

-(NSString*)toString {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.context
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}


-(void)fromDic:(NSDictionary *)messageDic{
    
    self.context = [messageDic mutableCopy];
    
    self.Succeed = [messageDic[@"result"][@"Succeed"] boolValue];
    self.Message = messageDic[@"result"][@"Message"];
}
@end
