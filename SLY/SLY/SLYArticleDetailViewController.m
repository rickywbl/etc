//
//  SLYArticleDetailViewController.m
//  SLY
//
//  Created by 王保霖 on 2016/10/20.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "SLYArticleDetailViewController.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
@interface SLYArticleDetailViewController ()<UIGestureRecognizerDelegate>{

    UITapGestureRecognizer* singleTap;

}


@property (strong, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation SLYArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.webView.userInteractionEnabled = YES;
    
    
    [self loadData];
    
    [self setupNavItem];
    
    [self addTapOnWebView];

}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];

}


-(void)setupNavItem{
    
    self.title = @"资讯详情";
    
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [back setImage:[UIImage imageNamed:@"navbar_back"] forState:UIControlStateNormal];
    
    back.frame = CGRectMake(0, 0, back.currentImage.size.width, back.currentImage.size.height);
    
    [[back rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithCustomView:back];
    
    self.navigationItem.leftBarButtonItem = backItem;
    
    
    
}

-(void)loadData{
    
    
    NSMutableDictionary *Parms = [[NSMutableDictionary alloc]init];
    Parms[@"mid"] = [SLYConfig sharedInstance].Id;
    Parms[@"aid"] = self.articelId;
    Parms[@"sign"] = [SLYTools getSignValue:Parms];


    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYNet_articleInfo Parms:Parms completion:^(SLYMessageResponse *messageResponse, NSError *err) {
        
   
            NSString * mobileartice = messageResponse.context[@"mobileartice"];
            
            [self.webView loadHTMLString:mobileartice baseURL:nil];

        
    }];

}


-(void)addTapOnWebView
{
    
    singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
    [self.webView addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    
    CGPoint pt = [sender locationInView:self.webView];
    NSString *imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", pt.x, pt.y];
    
    
    NSString *urlToSave = [self.webView stringByEvaluatingJavaScriptFromString:imgURL];
    
    if([urlToSave hasPrefix:@"http"])
    {
        
        NSMutableArray *photos = [[NSMutableArray alloc]init];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:urlToSave] ; // 图片路径
        [photos addObject:photo];
        
        
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.currentPhotoIndex = 0; // 弹出相册时显示的第一张图片是？
        browser.photos = photos; // 设置所有的图片
        [browser show];
    }
}



@end
