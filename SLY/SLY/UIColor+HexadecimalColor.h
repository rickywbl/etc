//
//  UIColor+HexadecimalColor.h
//  make
//
//  Created by Ricky on 15-1-23.
//  Copyright (c) 2015年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexadecimalColor)
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;//eg. self.window.backgroundColor = [UIColor colorWithHexValue:0x123456 alpha:0.8];
@end
