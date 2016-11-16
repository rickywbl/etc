//
//  SLYReMessageTableViewCell.m
//  SLY
//
//  Created by 王保霖 on 2016/10/17.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYReMessageTableViewCell.h"
#import "SLYArticleModel.h"
@implementation SLYReMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setModel:(SLYArticleModel *)model{

    _model = model;
    
    self.subTitle.text = model.Title;
    
    self.time.text = [model.Release_date componentsSeparatedByString:@" "][0];

    [self.readImage setHidden:[model.Is_Read boolValue]];

}

@end
