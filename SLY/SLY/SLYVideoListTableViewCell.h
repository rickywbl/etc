//
//  SLYVideoListTableViewCell.h
//  SLY
//
//  Created by 王保霖 on 2016/10/19.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLYVideoModel;
@interface SLYVideoListTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLab;

@property (strong, nonatomic) IBOutlet UILabel *teacher;
@property (strong, nonatomic) IBOutlet UILabel *time;
@property (strong, nonatomic) IBOutlet UIImageView *contetnImage;

@property (strong, nonatomic) SLYVideoModel * model;


@end
