//
//  SLYVideoModel.h
//  SLY
//
//  Created by 王保霖 on 2016/10/19.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLYVideoModel : NSObject

@property (copy, nonatomic) NSString * Id;
@property (copy, nonatomic) NSString * Title;
@property (copy, nonatomic) NSString * Intro;
@property (copy, nonatomic) NSString * Teacher;
@property (copy, nonatomic) NSString * Create_time;
@property (copy, nonatomic) NSString * Video_url;
@property (copy, nonatomic) NSString * Img_url;
@property (strong, nonatomic) NSNumber * Is_delete;
@property (strong, nonatomic) NSNumber * Count;
@property (strong, nonatomic) NSNumber * Is_hot;
@property (copy, nonatomic) NSString * Source;
@end
