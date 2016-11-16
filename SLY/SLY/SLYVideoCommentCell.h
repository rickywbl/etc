//
//  SLYVideoCommentCell.h
//  SLY
//
//  Created by 王保霖 on 2016/10/21.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLYVideoCommentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UILabel *time;

@end
