//
//  ETCPracticeTableViewCell.m
//  SLY
//
//  Created by 王保霖 on 2016/11/15.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "ETCPracticeTableViewCell.h"

@implementation ETCPracticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(ETCPracticeModel *)model{

    _model = model;
    
    self.name.text = model.Stk_name;
    self.code.text = model.Stk_code;
    self.count.text =[NSString stringWithFormat:@"%@",model.B_number];
    self.intPrice.text = [NSString stringWithFormat:@"%@",model.B_price];
    
    
    self.outprice.text = [SLYTools dateFormatWithDateStr:model.B_time type:RSDateTypeMD];


}
@end
