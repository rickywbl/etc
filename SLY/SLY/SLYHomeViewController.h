//
//  SLYHomeViewController.h
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYFatherViewController.h"

@interface SLYHomeViewController : SLYFatherViewController
@property (strong, nonatomic) IBOutlet UIView *AllItemView;
@property (strong, nonatomic) IBOutlet UIView *HomeImage;
@property (strong, nonatomic) IBOutlet UIView *HomeBottomView;


@property (strong, nonatomic) IBOutlet UIView *MiddleView;

@property (strong, nonatomic) IBOutlet UIButton *MoreInformation;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)home_moreInformartion:(UIButton *)sender;

@end
