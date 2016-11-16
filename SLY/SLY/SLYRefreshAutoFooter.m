//
//  SLYRefreshAutoFooter.m
//  SLY
//
//  Created by 王保霖 on 2016/10/17.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYRefreshAutoFooter.h"

@interface SLYRefreshAutoFooter()

@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UIActivityIndicatorView *loading;

@end

@implementation SLYRefreshAutoFooter


- (void)prepare
{
    [super prepare];
    
    // 设置控件的高度
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    // loading
    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:loading];
    self.loading = loading;
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.label.frame = self.bounds;
    
    self.loading.center = CGPointMake(30, self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉加载更多...";
            [self.loading stopAnimating];
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"加载数据中..";
            [self.loading startAnimating];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = self.noMoreText.length > 0 ? self.noMoreText : @"没有更多内容!";
            [self.loading stopAnimating];
            break;
        default:
            break;
    }
}

@end
