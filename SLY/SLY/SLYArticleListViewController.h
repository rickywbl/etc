//
//  SLYArticleListViewController.h
//  SLY
//
//  Created by 王保霖 on 2016/10/18.
//  Copyright © 2016年 Ricky. All rights reserved.
//


typedef enum : int {
    
    ArticelListTypeTactics = 4,
    ArticelListTypeNotice,
    ArticelListTypeBuddhist,
    ArticelListTypeOperation
} ArticelListType;



#import "SLYFatherViewController.h"

@interface SLYArticleListViewController : SLYFatherViewController


@property (strong, nonatomic) NSString * ArticleTitle;
@property (strong, nonatomic) NSString * subcontent;
@property (assign, nonatomic) ArticelListType type;


@end
