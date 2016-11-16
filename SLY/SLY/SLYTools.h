//
//  SLYTools.h
//  SLY
//
//  Created by 王保霖 on 2016/9/26.
//  Copyright © 2016年 Ricky. All rights reserved.
//

typedef enum : NSUInteger {
    RSDateTypeYMD,  // 2016-10-11
    RSDateTypeYMDH, // 2016-10-11 10
    RSDateTypeYMDHE, // 2016-10-11 10:20
    RSDateTypeYMDHES, //2016-10-11 10:20:5
    RSDateTypeMD  //10.11
} RSDateType;

#import <Foundation/Foundation.h>

@interface SLYTools : NSObject

+(void)drowLineInView:(UIView *)View andColor:(UIColor *)color;

+(NSAttributedString *)AttributedStringWithString:(NSString *)content lineSpacing:(CGFloat)space FontSize:(CGFloat)fontsize Color:(UIColor *)color;

+(CGFloat)getCellHightWithString:(NSString *)content Size:(CGSize)size Fontsize:(NSInteger)fontsize lineSpacing:(CGFloat)space;
+ (NSDictionary*)options:(NSString *)showStr;


+ (NSString *)md5:(NSString *)str;

//通过密匙加密
+(NSString *)getSignValue:(NSDictionary *)pars;

+(NSString *)dateFormatWithDateStr:(NSString *)dateStr type:(RSDateType)dateType;

@end
