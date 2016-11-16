//
//  SLYReMessageTableViewCell.h
//  SLY
//
//  Created by 王保霖 on 2016/10/17.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLYArticleModel;

@interface SLYReMessageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *nifoImage;
@property (strong, nonatomic) IBOutlet UIImageView *readImage;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *subTitle;
@property (strong, nonatomic) IBOutlet UILabel *time;


@property (strong, nonatomic) SLYArticleModel * model;
@end
