//
//  SLYMessageTableViewCell.h
//  SLY
//
//  Created by 王保霖 on 2016/9/27.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLYMessageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *Message_isOpen;
@property (strong, nonatomic) IBOutlet UILabel *Message_time;
@property (strong, nonatomic) IBOutlet UILabel *Message_Title;
@property (strong, nonatomic) IBOutlet UILabel *Message_SubTitle;

@end
