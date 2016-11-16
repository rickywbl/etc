//
//  SLYHomeButton.m
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYHomeButton.h"

@implementation SLYHomeButton


-(void)awakeFromNib{
    
    [super awakeFromNib];



}

-(instancetype)init{

    if (self = [super init]) {

        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.titleLabel.textColor = SLYColor(0x545454, 1);
        
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.contentMode =  UIViewContentModeCenter;
    }

    return self;
}


-(CGRect)imageRectForContentRect:(CGRect)contentRect{

    CGFloat x = 0;

    CGFloat y = 0;
    
    CGFloat w = contentRect.size.width;
    
    CGFloat h = contentRect.size.height * 0.7;
    
    return CGRectMake(x, y, w, h);
}


-(CGRect)titleRectForContentRect:(CGRect)contentRect{

    CGFloat x = 0;
    
    CGFloat y = contentRect.size.height * 0.7;
    
    CGFloat w = contentRect.size.width;
    
    CGFloat h = contentRect.size.height * 0.3;
    
    return CGRectMake(x, y, w, h);
    
}

@end
