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
#import "JNSHGuidViewController.h"
#import "JNSHAdvertiseView.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSHUpdateView.h"

//ShareSDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import "WeiboSDK.h"
//JPush
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>
//蒲公英
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
//友盟
#import "UMMobClick/MobClick.h"

/*********************************第三方宏定义*********************************/

//JPushSDK DEFINE
#define JPushAPPKey @"29eb4671de05f1476e7f499d"
#define JPushAppSecert @"d954da47ac64ee8819c89b20"
//shareSDK DEFINE
#define ShareAPPKey @"20a05793b4000"
#define ShareAPPSecet @"a561847dbe57010c896062d0730516a1"
//蒲公英
#define PgyAPPID @"f496f2435afee567bd3a11bd633b19de"
//Umeng
#define UmengAPPkey @"59daea31b27b0a2f6f00000c"

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //[NSThread sleepForTimeInterval:1];
    //蒲公英
    [[PgyManager sharedPgyManager] startManagerWithAppId:PgyAPPID];
    [[PgyManager sharedPgyManager] setEnableFeedback:NO];
    //检测更新
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:PgyAPPID];
    [[PgyUpdateManager sharedPgyManager] checkUpdate];
   // [[PgyUpdateManager sharedPgyManager] checkUpdate];
    
    //友盟
    UMConfigInstance.appKey = UmengAPPkey;
    UMConfigInstance.channelId = @"Exterprise";
    [MobClick startWithConfigure:UMConfigInstance];
    
    //适配tableView ios11
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    } else {
        // Fallback on earlier versions
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = ColorTabBarBackColor;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if (![user boolForKey:@"FirstLaunch"]) {
        
        JNSHGuidViewController *guidVc = [[JNSHGuidViewController alloc] init];
        
        self.window.rootViewController = guidVc;
        
        [user setBool:YES forKey:@"FirstLaunch"];
        
    }else {
        
        JNSHMainBarController *barVc = [[JNSHMainBarController alloc] init];
        self.window.rootViewController = barVc;
    }
    [self.window makeKeyAndVisible];
    
    //设置状态栏
    [application setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [application setStatusBarHidden:NO];
    
    [JNSYUserInfo getUserInfo].userKey = KEY;
    [JNSYUserInfo getUserInfo].userToken = TOKEN;
    
    //启动动画、背景图
    UIImageView *lanchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图层-2-拷贝-2"]];
    lanchView.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    [self.window addSubview:lanchView];
    [self.window bringSubviewToFront:lanchView];
    
    //缩小的星星视图
    UIImageView *logoImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"启动页2-"]];
    logoImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    [self.window addSubview:logoImg];
    [self.window bringSubviewToFront:logoImg];
    //固定的钱包、文字视图
    UIImageView *frontImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"启动页1-"]];
    frontImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    [self.window addSubview:frontImg];
    [self.window bringSubviewToFront:frontImg];
    
    if (IS_IphoneX) {
        lanchView.image = [UIImage imageNamed:@"launchback"];
        logoImg.image = [UIImage imageNamed:@"launchAni"];
        frontImg.image = [UIImage imageNamed:@"launchtitle"];
    }
    
    [UIView animateWithDuration:2 animations:^{
        logoImg.transform = CGAffineTransformMakeScale(0.9, 0.9);
    } completion:^(BOOL finished) {
        
        [self showAdvertiseView];
        
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
                                                   [appInfo SSDKSetupWeChatByAppId:@"wxf10a747a553b4625"
                                                                         appSecret:@"3ced17b896a1831032df0a68354b7829"];
                                                   break;
                                               default:
                                                   break;
                                           }
                                       }];
    
    /*************************  JPush ******************************/
    //注册APNS
    JPUSHRegisterEntity *entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    //初始化JPush
    [JPUSHService setupWithOption:launchOptions appKey:JPushAPPKey channel:@"APP Store" apsForProduction:NO];
    //设置APP角标
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    return YES;
}

- (void)showAdvertiseView{
    
    //启动广告
    /*     广告展示    */
    //判断沙河中是否存在图片，如果存在直接显示图片
    
    NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
    
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    
    JNSHAdvertiseView *advertiseView = [[JNSHAdvertiseView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    if (isExist) { //图片存在展示图片
        
        advertiseView.filePath = filePath;
        advertiseView.timeduration = [kUserDefaults objectForKey:@"ADDuration"];
        //NSLog(@"%@",);
        [advertiseView show];
        
    }else {
        
        //下载默认广告图片
        
        NSString *defaultFilePath = [self getFilePathWithImageName:@"20122220201612322865.png"];
        
        BOOL exist = [self isFileExistWithFilePath:defaultFilePath];
        
        if (exist) {
            
            advertiseView.filePath = defaultFilePath;
            [advertiseView show];
            
        }else {
            
            //显示状态栏
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png"]];
            UIImage *image = [UIImage imageWithData:data];
            
            if ([UIImagePNGRepresentation(image) writeToFile:defaultFilePath atomically:YES]) {
                
                
            }else {
                
            };
            //版本更新
            //[self VersionUpdate];
            
        }
    }
    
    //下载广告图片并缓存
    [self getAdvertisingImage];
    
}
#define mark 广告文件管理
/*      根据图片名拼接文件路径  */
- (NSString *)getFilePathWithImageName:(NSString *)imageName{
    
    if (imageName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
    
}

/*     判断文件是否存在 */
-(BOOL)isFileExistWithFilePath:(NSString *)filePath {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
    
}

//获取广告图片
- (void)getAdvertisingImage {
    

    NSDictionary *dic = @{
                          @"adArea":@"A1001",
                          @"adSize":@"1"
                          };
    NSString *action = @"AdInfoState";
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":TOKEN,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        //NSLog(@"%@",resultDic);
        
        if ([resultDic[@"adInfoList"] isKindOfClass:[NSArray class]]) {
            NSArray *imageList = resultDic[@"adInfoList"] ;
            if (imageList.count == 0) {
                return ;
            }
            NSString *imageURL = resultDic[@"adInfoList"][0][@"areaPic"];
            NSString *linkURL = resultDic[@"adInfoList"][0][@"areaHref"];
            NSArray *imageNamearr = [imageURL componentsSeparatedByString:@"/"];
            NSString *imageName = [imageNamearr lastObject];
            NSString *duration = [NSString stringWithFormat:@"%@",resultDic[@"adInfoList"][0][@"duration"]];
            // 拼接沙盒路径
            NSString *filePath = [self getFilePathWithImageName:imageName];
            BOOL isExist = [self isFileExistWithFilePath:filePath];
            if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
                [self downloadAdImageWithUrl:imageURL imageName:imageName];
                
            }
            //存储广告链接
            [kUserDefaults setObject:linkURL forKey:@"ADURL"];
            //存储展示时间
            [kUserDefaults setObject:duration forKey:@"ADDuration"];
            [kUserDefaults synchronize];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
//    // 这里原本采用美团的广告接口，现在了一些固定的图片url代替
//    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
//    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
//    imageUrl = @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png";
//    // 获取图片名:43-130P5122Z60-50.jpg
//    //NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
//    NSString *imageName = @"20122220201612322865.png";
//
//    // 拼接沙盒路径
//    NSString *filePath = [self getFilePathWithImageName:imageName];
//    BOOL isExist = [self isFileExistWithFilePath:filePath];
//    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
//
//        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
//
//    }
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
            
            
            
        }else{
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}


//版本检测
- (void)VersionUpdate {
    
    NSDictionary *dic = @{
                          @"os":@"IOS"
                          };
    NSString *action = @"AppVersionState";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":TOKEN,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [params JSONValue];
        NSLog(@"%@",resultDic);
        
        JNSHUpdateView *updateView = [[JNSHUpdateView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        [updateView show:@"" message:@"" inView:[UIApplication sharedApplication].keyWindow];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


//#define mark - apns

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [JPUSHService registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
    
}

#define  JPUSHRegisterDelegate

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary *userInfo = notification.request.content.userInfo;
    completionHandler(UNNotificationPresentationOptionAlert);
    
    NSLog(@"content:%@userinfo:%@",notification.request.content,userInfo);
    
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    completionHandler(UNNotificationPresentationOptionAlert);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [JPUSHService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    [JPUSHService handleRemoteNotification:userInfo];
    
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
