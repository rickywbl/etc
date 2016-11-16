//
//  SLYMessageResponse.m
//  SLY
//
//  Created by 王保霖 on 2016/10/18.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYMessageResponse.h"
#import "SLYMessage.h"

@interface SLYMessageResponse()

@property (nonatomic, copy, readwrite) NSString *responseString;

@end

@implementation SLYMessageResponse




+(id)responseWithReponseObjc:(id)responseObjc{
    
    SLYMessageResponse *response = [[self class]alloc];
    
    if([responseObjc isKindOfClass:[NSData class]]){
    
        response = [response initWithReponseData:responseObjc];
    }
    
    if([responseObjc isKindOfClass:[NSDictionary class]]){
    
        response = [response initWithReponseDic:responseObjc];

    }
    
    return response;
}


- (id)initWithReponseData:(NSData*)responseData {
    
    if ((self = [super init])) {
        
        self.responseString = [[NSString alloc]initWithData:responseData
                                                   encoding:NSUTF8StringEncoding];
        NSLog(@"响应报文:\n%@", self.responseString);
        

        [self fromString: self.responseString];
    }
    return self;
}

-(instancetype)initWithReponseDic:(NSDictionary *)responseDic{
    
    if(self = [super init]){
        
        
        [self fromDic:responseDic];
        
    }
    
    return self;
}


@end
