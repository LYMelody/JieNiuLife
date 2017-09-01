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

//ShareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import "WeiboSDK.h"


#define ShareAPPKey @"20a05793b4000"
#define ShareAPPSecet @"a561847dbe57010c896062d0730516a1"


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
    
    UIImageView *lanchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图层-2-拷贝-2"]];
    lanchView.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    [self.window addSubview:lanchView];
    [self.window bringSubviewToFront:lanchView];
    
    //
    UIImageView *logoImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"启动页2-"]];
    logoImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    [self.window addSubview:logoImg];
    [self.window bringSubviewToFront:logoImg];
    
    UIImageView *frontImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"启动页1-"]];
    frontImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    [self.window addSubview:frontImg];
    [self.window bringSubviewToFront:frontImg];
    
    [UIView animateWithDuration:2 animations:^{
        logoImg.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            lanchView.alpha = 0.0;
            logoImg.alpha = 0.0;
            frontImg.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            [lanchView removeFromSuperview];
            [logoImg removeFromSuperview];
            [frontImg removeFromSuperview];
        }];
        
        
    }];
    
    //初始化ShareSDK
    
    [ShareSDK registerActivePlatforms:@[
                                       @(SSDKPlatformTypeWechat),
                                       @(SSDKPlatformTypeSinaWeibo)] onImport:^(SSDKPlatformType platformType) {
                                           switch (platformType) {
                                               case SSDKPlatformTypeSinaWeibo:
                                                   [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                                   break;
                                               case SSDKPlatformTypeWechat:
                                                   [ShareSDKConnector connectWeChat:[WXApi class]];
                                                   break;
                                                   
                                               default:
                                                   break;
                                           }
                                       } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
                                           switch (platformType) {
                                               case SSDKPlatformTypeSinaWeibo:
                                                   [appInfo SSDKSetupSinaWeiboByAppKey:@"4170893334" appSecret:@"cf551ab577ed24a0b1152ec449cb5858" redirectUri:@"http://ktb.4006007909.com/down" authType:SSDKAuthTypeBoth];
                                                   break;
                                               case SSDKPlatformTypeWechat:
                                                   [appInfo SSDKSetupWeChatByAppId:@""
                                                                         appSecret:@""];
                                                   break;
                                               default:
                                                   break;
                                           }
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
