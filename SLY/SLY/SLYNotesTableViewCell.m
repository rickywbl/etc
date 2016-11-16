//
//  SLYNotesTableViewCell.m
//  SLY
//
//  Created by 王保霖 on 2016/11/4.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYNotesTableViewCell.h"
#import "SLYArticleModel.h"

@interface SLYNotesTableViewCell()

@property (strong, nonatomic) IBOutlet UIImageView *headerImage;

@property (strong, nonatomic) IBOutlet UILabel *publisher;
@property (strong, nonatomic) IBOutlet UILabel *message;

@property (strong, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutlet UILabel *title;

@property (strong, nonatomic) IBOutlet UILabel *sunTitle;

@end
@implementation SLYNotesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(SLYArticleModel *)model{

    _model = model;
    
    self.title.attributedText = [SLYTools AttributedStringWithString:_model.Title lineSpacing:5 FontSize:16 Color:SLYColor(0X333333, 1)];
    
    self.title.numberOfLines = 2;
    
    self.sunTitle.attributedText = [SLYTools AttributedStringWithString:_model.Intro lineSpacing:5 FontSize:14 Color:SLYColor(0X666666, 1)];
    
    self.time.text = [SLYTools dateFormatWithDateStr:_model.Release_date type:RSDateTypeYMDHE];
    
    self.sunTitle.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.publisher.text = model.Author.length?model.Author:@"操盘手";

}

@end
