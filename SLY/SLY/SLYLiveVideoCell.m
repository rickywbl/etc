//
//  SLYLiveVideoCell.m
//  SLY
//
//  Created by 王保霖 on 2016/9/27.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYLiveVideoCell.h"

@implementation SLYLiveVideoCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        [self setup];
    }
    
    return self;

}



- (void)setup {
    
    [[NSBundle mainBundle] loadNibNamed:@"SLYLiveVideoCell" owner:self options:nil];
    
    [self addSubview:self.bgView];
    

}

-(void)layoutSubviews{

    self.bgView.frame = self.bounds;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if([self.delegate respondsToSelector:@selector(selectItemLiveVideo:)]){
    
        [self.delegate selectItemLiveVideo:self];
    }

}


@end
