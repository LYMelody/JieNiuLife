//
//  JNSYUserInfo.m
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/6/28.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSYUserInfo.h"

@implementation JNSYUserInfo

+ (JNSYUserInfo *)getUserInfo {
    
    static JNSYUserInfo *userInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[JNSYUserInfo alloc] init];
    });
    
    return userInfo;
    
}


@end
