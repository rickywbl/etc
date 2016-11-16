//
//  SLYStrategyTableViewCell.m
//  SLY
//
//  Created by 王保霖 on 2016/11/4.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYStrategyTableViewCell.h"


@interface SLYStrategyTableViewCell()

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *catagory;

@property (strong, nonatomic) IBOutlet UILabel *publisher;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIView *Wbg;

@end

@implementation SLYStrategyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.Wbg.clipsToBounds = YES;
    
    self.Wbg.layer.cornerRadius = 5.0;
    
    self.catagory.clipsToBounds = YES;
    
    self.catagory.layer.cornerRadius = 5.0;
    
    self.Wbg.layer.borderWidth = 0.5;
    
    self.Wbg.layer.borderColor = SLYColor(0xe6e6e6, 1).CGColor;
}

-(void)setIndexPath:(NSIndexPath *)indexPath{

    _indexPath = indexPath;
    
    if(indexPath.row == 0){
    
        self.title.text = @"中线稳健投资实盘策略二期";
        self.catagory.text = @"稳健型" ;
        self.publisher.text = @"操盘手:价值操盘君";
        
        self.catagory.backgroundColor = SLYColor(0x567cd0, 1);
        
        return;
    }
    
    
    self.title.text = @"短线超频交易实盘策略";
    self.catagory.text = @"进取型";
    self.publisher.text = @"操盘手:黑马狙击君";
    
    self.catagory.backgroundColor = SLYColor(0xe95258, 1);

    
}

@end
