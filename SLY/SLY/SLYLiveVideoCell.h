//
//  SLYLiveVideoCell.h
//  SLY
//
//  Created by 王保霖 on 2016/9/27.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SLYLiveVideoCell;
@protocol SLYLiveVideoDelegate <NSObject>

-(void)selectItemLiveVideo:(SLYLiveVideoCell *)LiveVideo;

@end

@interface SLYLiveVideoCell : UIView
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIImageView *bgimage;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *time;


@property (weak, nonatomic) id delegate;

@end
