//
//  SLYVideoDetailViewController.h
//  SLY
//
//  Created by 王保霖 on 2016/10/20.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLYVideoModel;
@interface SLYVideoDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *VideoView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) SLYVideoModel * videoModel;
@end
