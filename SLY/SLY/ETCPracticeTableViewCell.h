//
//  ETCPracticeTableViewCell.h
//  SLY
//
//  Created by 王保霖 on 2016/11/15.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ETCPracticeModel.h"
@interface ETCPracticeTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *code;
@property (strong, nonatomic) IBOutlet UILabel *count;
@property (strong, nonatomic) IBOutlet UILabel *intPrice;
@property (strong, nonatomic) IBOutlet UILabel *outprice;

@property (strong, nonatomic) ETCPracticeModel * model;

@end
