//
//  ETCTacticsViewController.h
//  SLY
//
//  Created by 王保霖 on 2016/11/9.
//  Copyright © 2016年 Ricky. All rights reserved.
//

typedef enum : int {
    TacticsTypeRobustness = 0,
    TacticsTypeProgressive
} TacticsType;

#import "SLYFatherViewController.h"

@interface ETCTacticsViewController : SLYFatherViewController

@property (assign, nonatomic) TacticsType  tacticsType;

@end
