//
//  UIView+Extension.m
//  
//
//  Created by 王保霖 on 2016/9/26.
//
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

-(CGFloat)sr_X{

    return self.frame.origin.x;
}


-(void)setSr_X:(CGFloat)sr_X{

    CGRect frame  = self.frame;
    
    frame.origin.x = sr_X;
    
    self.frame = frame;
}


-(CGFloat)sr_Y{
    
    return self.frame.origin.y;
}


-(void)setSr_Y:(CGFloat)sr_Y{
    
    CGRect frame  = self.frame;
    
    frame.origin.y = sr_Y;
    
    self.frame = frame;
}



-(CGFloat)sr_Width{
    
    return self.frame.size.width;
}


-(void)setSr_Width:(CGFloat)sr_Width{
    
    CGRect frame  = self.frame;
    
    frame.size.width = sr_Width;
    
    self.frame = frame;
}


-(CGFloat)sr_Heigth{
    
    return self.frame.size.height;
}


-(void)setSr_Heigth:(CGFloat)sr_Heigth{
    
    CGRect frame  = self.frame;
    
    frame.size.height = sr_Heigth;
    
    self.frame = frame;
}



@end
