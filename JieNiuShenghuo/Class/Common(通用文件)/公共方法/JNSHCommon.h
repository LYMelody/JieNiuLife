//
//  JNSHCommon.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/3.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#ifndef JNSHCommon_h
#define JNSHCommon_h

/*
 测试环境URL(JNSHTestUrl)：http://api.test.life.hzjieniu.com/app/action
 TOKEN:63b407c3d510bf14851ce46df94662b5
 KEY:UBKKWNA216MXCGVJWG5W69VOORNWKV82
 
 生产环境（JNSHProUrl）：http://api.life.hzjieniu.com/app/action
 TOKEN:IatWXu8DhM3bIsB6MnnHCEHu6CDEnYIu
 KEY : NLMIU6LKM2VE51311F2VPMGXA8HOLAS7
 
 */

#define JNSHTestUrl @"http://api.test.life.hzjieniu.com/app/action"
#define TOKEN @"63b407c3d510bf14851ce46df94662b5"
#define KEY @"UBKKWNA216MXCGVJWG5W69VOORNWKV82"

#define BundleID [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]
#define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define SystemVersion [[UIDevice currentDevice] systemVersion]
#define kUserDefaults [NSUserDefaults standardUserDefaults]


#define KscreenWidth [UIScreen mainScreen].bounds.size.width
#define KscreenHeight [UIScreen mainScreen].bounds.size.height
#define SeperateLineWidth 0.3

#define ColorTableViewCellSeparate  [UIColor colorWithRed:224/255.0 green:223/255.0 blue:226/255.0 alpha:1]
#define ColorText [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
#define ColorTabBarBackColor [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0/255.0 alpha:1]
#define ColorTableBackColor [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]
#define ColorLightText [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
#define ColorLineSeperate [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1]
#define BlueColor [UIColor colorWithRed:0/255.0 green:122/255.0 blue:226/255.0 alpha:1]
#define GrayColor [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]

#define lightOrgeron [UIColor colorWithRed:255/255.0 green:227/255.0 blue:209/255.0 alpha:1]

#define GreenColor [UIColor colorWithRed:32/255.0 green:151/255.0 blue:4/255.0 alpha:1]

#define GrayColor [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]

#define LightGrayColor [UIColor colorWithRed:209/255.0 green:212/255.0 blue:221/255.0 alpha:1]

#define linebackColor [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1]

#define lightYellow [UIColor colorWithRed:255/255.0 green:227/255.0 blue:209/255.0 alpha:1]

#define SmothYellow [UIColor colorWithRed:255/255.0 green:168/255.0 blue:0/255.0 alpha:1]

#define IS_IphoneX [UIScreen mainScreen].bounds.size.height==812.00?YES:NO

#define IS_IOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

#define IS_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] < 10.0)

#define NetInAvaiable @"您好像没有连接网络，请连接网络重试。"



#endif /* JNSHCommon_h */
