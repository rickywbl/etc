//
//  SLYTools.m
//  SLY
//
//  Created by 王保霖 on 2016/9/26.
//  Copyright © 2016年 Ricky. All rights reserved.
//



#import "SLYTools.h"
#import<CommonCrypto/CommonDigest.h>


@implementation SLYTools

+(void)drowLineInView:(UIView *)View andColor:(UIColor *)color{

    CGContextRef contect =  UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(contect);
    
    CGContextMoveToPoint(contect, 0, View.sr_Heigth - 1);
    
    CGContextAddLineToPoint(contect, View.sr_Width,View.sr_Heigth - 1);
    
    CGContextSetLineWidth(contect, 1);
    
    CGContextSetStrokeColorWithColor(contect,color.CGColor);
    
    CGContextStrokePath(contect);
    
}

+(NSAttributedString *)AttributedStringWithString:(NSString *)content lineSpacing:(CGFloat)space FontSize:(CGFloat)fontsize Color:(UIColor *)color{
    
    NSMutableDictionary * attributes = [[NSMutableDictionary alloc]init];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    
    style.lineSpacing = space;
    
    attributes[NSParagraphStyleAttributeName] = style;
    
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:fontsize];
    
    attributes[NSForegroundColorAttributeName] = color;
    
    NSAttributedString *Attr = [[NSAttributedString alloc]initWithString:content attributes:attributes];
    
    return Attr;
}

+(CGFloat)getCellHightWithString:(NSString *)content Size:(CGSize)size Fontsize:(NSInteger)fontsize lineSpacing:(CGFloat)space{
    
    NSMutableDictionary * attributes = [[NSMutableDictionary alloc]init];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    
    style.lineSpacing = space;
    
    attributes[NSParagraphStyleAttributeName] = style;
    
    attributes[NSFontAttributeName] = [UIFont systemFontOfSize:fontsize];
    
    return [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size.height;
    
}



+(NSString *)getSignValue:(NSDictionary *)pars{

    NSArray * keys = pars.allKeys;
    
    NSMutableString * sign = [[NSMutableString alloc]init];
    
    //[NSString stringWithFormat:@"5-index:%d-%@;4-size:%d-%@;4-type:%d-%@;%@",1,@"1",1,@"4",1,@"1",secretCode]
    
    NSArray *newkeys = [keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    
    for (int i = 0; i < newkeys.count; i++) {
        
        NSString * key = newkeys[i];
        NSString *value = pars[key];
        
        NSString * temp = [NSString stringWithFormat:@"%ld-%@:%ld-%@;",key.length,key.lowercaseString,value.length,value.lowercaseString];
        
        [sign appendFormat:@"%@",temp];
                
    }
    
     [sign appendString:secretCode];
    
    
    return  [SLYTools md5:sign];
}


+(NSString *)dateFormatWithDateStr:(NSString *)dateStr type:(RSDateType)dateType{

    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
    
    // 设置日期格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * date = [dateFormatter dateFromString:dateStr];
    
    /*
     typedef enum : NSUInteger {
     RSDateTypeYMD,  // 2016-10-11
     RSDateTypeYMDH, // 2016-10-11 10
     RSDateTypeYMDHE, // 2016-10-11 10:20
     RSDateTypeYMDHES, //2016-10-11 10:20:5
     } RSDateType;

     */
    
    // 设置日期格式
    
    switch (dateType) {
        case RSDateTypeYMD:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case RSDateTypeYMDH:
            [dateFormatter setDateFormat:@"yyyy-MM-dd hh"];
            break;
        case RSDateTypeYMDHE:
            [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
            break;
        case RSDateTypeYMDHES:
            [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            break;
        case RSDateTypeMD:
            [dateFormatter setDateFormat:@"MM.dd"];
            break;
        default:
            [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
            break;
    }
    
    
    NSString *year = [dateFormatter stringFromDate:date];
    
    return year;
}



+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


+ (NSDictionary*)options:(NSString *)showStr{
    
    NSMutableDictionary *options = [@{kCRToastNotificationTypeKey               :  @(CRToastTypeStatusBar),
                                      kCRToastNotificationPresentationTypeKey   :  @(CRToastPresentationTypePush),
                                      kCRToastUnderStatusBarKey                 : @(NO),
                                      kCRToastTextKey                           : showStr,
                                      kCRToastTextAlignmentKey                  : @(NSTextAlignmentCenter),
                                      kCRToastTimeIntervalKey                   : @(1),
                                      kCRToastAnimationInTypeKey                : @(CRToastAnimationTypeLinear),
                                      kCRToastAnimationOutTypeKey               : @(CRToastAnimationTypeLinear),
                                      kCRToastAnimationInDirectionKey           : @(1),
                                      kCRToastAnimationOutDirectionKey          : @(1)} mutableCopy];
    
    
    return [NSDictionary dictionaryWithDictionary:options];
};



@end
