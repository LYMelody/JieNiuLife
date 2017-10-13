//
//  JNSHAutoSize.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/9.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNSHAutoSize : NSObject

+ (CGFloat)height:(CGFloat)height;

+ (CGFloat)width:(CGFloat)width;

+ (void)showMsg:(NSString *)msg;

+ (NSString *)md5HexDigest:(NSString*)password;

+ (NSString *)getDiviceIMEI;

//+ (NSString*)rePlaceString:(NSString*)string;

+ (NSString *)getTimeNow;

@end
