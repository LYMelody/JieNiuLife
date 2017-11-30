//
//  JNSHAutoSize.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/9.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAutoSize.h"
#import "JNSHCommon.h"
#import <CommonCrypto/CommonDigest.h>

@implementation JNSHAutoSize

+ (CGFloat)height:(CGFloat)height {
    
    CGFloat h = 0;
   
    if (KscreenHeight == 568) {         //4.0寸
        h = height * 568/667.0;
    }else if (KscreenHeight == 736) {   //5.5寸
        h = height * 736/667.0;
    }else if (KscreenHeight == 480) {   //3.5寸
        h = height * 480/667.0;
    }else {                             //4.7寸
        h = height;
    }

    return h;
}

+ (CGFloat)width:(CGFloat)width {
    
    CGFloat w = 0;
    
    if (KscreenHeight == 568) {        //4.0寸
        w = width * 320/375.0;
    }else if (KscreenHeight == 736) {  //5.5寸
        w = width * 424/375.0;
    }else if (KscreenHeight == 480) {  //3.5寸
        w = width * 320/375.0;
    }else {                            //4.7寸
        w = width;
    }
    
    return w;
    
}

//获取时间戳
+ (NSString *)getTimeNow {
    
    //时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-DD HH:mm:ss"];
    NSTimeZone *timezone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timezone];
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%.0f",[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}

//获取设备“IMEI”
+ (NSString *)getDiviceIMEI {
    
    NSString *imsi = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *UUID = [self md5HexDigest:imsi];
    NSString *UUID16 = [[UUID substringFromIndex:8] substringToIndex:16];
    
    return UUID16;
}

//提示消息
+ (void)showMsg:(NSString *)msg {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alert show];
}


//MD5加密
+ (NSString *)md5HexDigest:(NSString*)password
{
    const char *original_str = [password UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
    {
        [hash appendFormat:@"%02X", result[i]];
    }
    NSString *mdfiveString = [hash lowercaseString];
    return mdfiveString;
}




@end
