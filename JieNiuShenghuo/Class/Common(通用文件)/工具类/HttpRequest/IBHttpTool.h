//
//  AWHttpTool.h
//  MyWeibo
//
//  Created by All on 14-10-3.
//  Copyright (c) 2014年 All. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IBHttpTool : NSObject

// 请求成功的回调
typedef void (^IBHttpSuccess)(id result);

// 请求失败的回调
typedef void (^IBHttpFailure)(NSError *error);

/**
 *  发送一条POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSString *)params success:(IBHttpSuccess)success failure:(IBHttpFailure)failure;

+ (NSString *)md5HexDigest:(NSString*)password;

@end
