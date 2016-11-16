//
//  SLYArticleListTableViewCell.m
//  SLY
//
//  Created by 王保霖 on 2016/10/18.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYArticleListTableViewCell.h"
#import "SLYArticleModel.h"
@implementation SLYArticleListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(SLYArticleModel *)model{

    _model = model;
    
    self.title.attributedText = [SLYTools AttributedStringWithString:_model.Title lineSpacing:5 FontSize:16 Color:SLYColor(0X333333, 1)];
    
    self.subTitle.attributedText = [SLYTools AttributedStringWithString:_model.Intro lineSpacing:5 FontSize:14 Color:SLYColor(0X666666, 1)];
    
    self.time.text = [SLYTools dateFormatWithDateStr:_model.Release_date type:RSDateTypeYMDHE];
    
    
    self.subTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.source.text = _model.Source;

}

@end
