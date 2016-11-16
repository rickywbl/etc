//
//  SLYArticleModel.h
//  SLY
//
//  Created by 王保霖 on 2016/10/18.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLYArticleModel : NSObject

@property (strong, nonatomic) NSString * Id;
@property (strong, nonatomic) NSString * Art_ex_id;
@property (strong, nonatomic) NSString * Title;
@property (strong, nonatomic) NSString * Content;
@property (strong, nonatomic) NSString * Inputer;
@property (strong, nonatomic) NSString * Release_date;
@property (strong, nonatomic) NSString * Author;
@property (strong, nonatomic) NSString * Source;
@property (strong, nonatomic) NSString * Intro;
@property (strong, nonatomic) NSString * Product_type;
@property (strong, nonatomic) NSString * Article_type;
@property (strong, nonatomic) NSNumber * IsHot;
@property (strong, nonatomic) NSNumber * Is_Read;
@property (strong, nonatomic) NSNumber * IsDelete;


@property (assign, nonatomic) CGFloat height;



@end
