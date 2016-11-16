//
//  AppDelegate.m
//  SLY
//
//  Created by 王保霖 on 2016/9/22.
//  Copyright © 2016年 Ricky. All rights reserved.
//

#import "AppDelegate.h"
#import "SLYRootViewController.h"
#import "SLYLoginViewController.h"
#import "VHallApi.h"
#import "GuideView.h"
#import "SFHFKeychainUtils.h"
@interface AppDelegate ()<UIAlertViewDelegate>{

    NSDictionary * VersionDis;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.allowRotate = 0;

        
    if([SLYConfig sharedInstance].loginStatus){
    
        SLYRootViewController * root = [[SLYRootViewController alloc]init];
        self.window.rootViewController = [[SLYNavigationController alloc]initWithRootViewController:root];
        
    }else{
    
        SLYLoginViewController * root = [[SLYLoginViewController alloc]init];
        self.window.rootViewController = root;
    }
    
    
    [self StoreUUID];
    
    [self showVersion];
    
    
    
    if([[SLYConfig sharedInstance].firstLaunch boolValue] == NO){
        
        NSArray* guideImages = @[@"三连阳-引导页-1",@"三连阳-引导页-2",@"三连阳-引导页-3",@"三连阳-引导页-4"];
        
        GuideView* guide = [[GuideView alloc]initWithFrame:CGRectMake(0, 0, SLYScreenWidth, SLYScreenHeight)];
        
        guide.guideImages = guideImages;
        
        [self.window.rootViewController.view addSubview:guide];
        
            
        [UIView animateWithDuration:0.5 animations:^{
            
            guide.frame = CGRectMake(0, 0, SLYScreenWidth, SLYScreenHeight);
        }];
        
        [SLYConfig sharedInstance].firstLaunch = [NSNumber numberWithBool:YES];
        
    }
  
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)showVersion{

    NSString * CurrentVersion =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    
    [[SLYNetRequestManage sharedInstance] SLYGetWithUrl:SLYRequest(@"/edition/Info") Parms:nil completion:^(SLYMessageResponse *messageResponse, NSError *err) {
       
        VersionDis = [messageResponse.context[@"info"] copy];
        
        
        if([CurrentVersion floatValue] < [VersionDis[@"iOS"] floatValue]){
            
            NSArray * lists = [VersionDis[@"Description"] componentsSeparatedByString:@","];
            
            NSString * listStr = [lists componentsJoinedByString:@"\n"];
            
            if([VersionDis[@"IsForce"] boolValue]){
            
                UIAlertView * VersionAl = [[UIAlertView alloc]initWithTitle:@"有新版本更新" message:listStr delegate:self cancelButtonTitle:@"前往更新" otherButtonTitles:nil];
                
                [VersionAl show];
                
            }else{
            
                
                UIAlertView * VersionAl = [[UIAlertView alloc]initWithTitle:@"有新版本更新" message:listStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前往更新", nil];
                
                [VersionAl show];
            }
        

        }
        
        
        
    }];
//
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if([VersionDis[@"IsForce"] boolValue]){
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/si-mu-te-gong-cai-jing-gu/id1023671079"]];
    
    }else{
    
        if(buttonIndex == 1){
        
             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/si-mu-te-gong-cai-jing-gu/id1023671079"]];
        }
    }
    
    
    
}


-(void)StoreUUID{
    
    //保存唯一设备识别
    NSString *SERVICE_NAME = @"com.cjzkw.SPETC";
    NSString * str =  [SFHFKeychainUtils getPasswordForUsername:@"ETC" andServiceName:SERVICE_NAME error:nil];  // 从keychain获取数据
    
    
    if ([str length] <= 0)
    {
        str  = [[[UIDevice currentDevice] identifierForVendor] UUIDString];  // 保存UUID作为手机唯一标识符
        
     [SFHFKeychainUtils storeUsername:@"ETC"
                             andPassword:str
                          forServiceName:SERVICE_NAME
                          updateExisting:1
                                   error:nil];  // 往keychain添加数据
    }
    


}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    
    if (_allowRotate == 1) {
        
        return UIInterfaceOrientationMaskAll;
        
    }else{
        
        return (UIInterfaceOrientationMaskPortrait);
    }
}


// 返回是否支持设备自动旋转
- (BOOL)shouldAutorotate
{
    if (_allowRotate == 1) {
        
        return YES;
    }
    return NO;
}


@end
