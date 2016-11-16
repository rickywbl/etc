//
//  SLYArticleListTableViewCell.h
//  SLY
//
//  Created by 王保霖 on 2016/10/18.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLYArticleModel;
@interface SLYArticleListTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *subTitle;
@property (strong, nonatomic) IBOutlet UILabel *source;
@property (strong, nonatomic) IBOutlet UILabel *time;


@property (strong, nonatomic) SLYArticleModel * model;

@end
