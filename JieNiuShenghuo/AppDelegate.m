//
//  AppDelegate.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/2.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "AppDelegate.h"
#import "JNSHMainBarController.h"
#import "JNSYUserInfo.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //[NSThread sleepForTimeInterval:1];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = ColorTabBarBackColor;
    
    JNSHMainBarController *barVc = [[JNSHMainBarController alloc] init];
    
    self.window.rootViewController = barVc;
    
    [self.window makeKeyAndVisible];
    
    //设置状态栏
    [application setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
   
    [application setStatusBarHidden:NO];
    
    [JNSYUserInfo getUserInfo].userKey = KEY;
    [JNSYUserInfo getUserInfo].userToken = TOKEN;
    
    UIImageView *lanchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tubiao-1"]];
    lanchView.frame = CGRectMake(-KscreenWidth*0.1/2.0, -KscreenHeight*0.1/2.0, KscreenWidth*1.1, KscreenHeight*1.1);
   // lanchView.center = self.window.center;
    NSLog(@"%@",NSStringFromCGSize(lanchView.frame.size));
    
    lanchView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    NSLog(@"%@",NSStringFromCGSize(lanchView.frame.size));
    
    [self.window addSubview:lanchView];
    
    [self.window bringSubviewToFront:lanchView];
    
    UIImageView *frontImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"启动页-"]];
    frontImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    [self.window addSubview:frontImg];
    [self.window bringSubviewToFront:frontImg];
    
    [UIView animateWithDuration:2 animations:^{
        lanchView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        [lanchView removeFromSuperview];
        [frontImg removeFromSuperview];
    }];
    
    return YES;
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
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
