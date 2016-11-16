//
//  UIColor+HexadecimalColor.m
//  make
//
//  Created by Ricky on 15-1-23.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import "UIColor+HexadecimalColor.h"

@implementation UIColor (HexadecimalColor)

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:((hexValue >> 16) & 0x000000FF)/255.0f
                           green:((hexValue >> 8) & 0x000000FF)/255.0f
                            blue:((hexValue) & 0x000000FF)/255.0
                           alpha:alpha];
}
@end
