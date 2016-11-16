//
//  SLYView.m
//  SLY
//
//  Created by 王保霖 on 2016/9/26.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYView.h"

@implementation SLYView



- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];

    CGContextRef contect =  UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(contect, kCGLineCapRound);

    CGContextSetLineWidth(contect, 1);
    
    CGContextSetStrokeColorWithColor(contect,SLYColor(0xe6e6e6, 1).CGColor);

    CGContextMoveToPoint(contect, 0, rect.size.height);
    
    CGContextAddLineToPoint(contect, rect.size.width,rect.size.height);
    
    CGContextStrokePath(contect);
    
    
//    CGContextRef contect1 =  UIGraphicsGetCurrentContext();
//    
//    CGContextSetLineCap(contect1, kCGLineCapRound);
//    
//    CGContextSetLineWidth(contect1, 1);
//    
//    CGContextSetStrokeColorWithColor(contect1,SLYColor(0xe6e6e6, 1).CGColor);
//    
//    CGContextMoveToPoint(contect1, 0, 0);
//    
//    CGContextAddLineToPoint(contect1, rect.size.width,0);
//    
//    CGContextStrokePath(contect1);
    
}

@end
