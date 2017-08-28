//
//  HttpRequest.h
//  JingXuan
//
//  Created by wj on 16/5/19.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <SystemConfiguration/SystemConfiguration.h>

//static NSString * const HOST = @"http://192.168.100.84:3251/api/action";

@interface HttpRequest : NSObject

@property (nonatomic, copy) void(^dataBlcok)(id *data);



//无卡收款
//+ (void)noCardRequestOrderType:(NSString *)orderType amount:(NSString *)amount;
//订单信息确认
+ (void)shortcutRequestOrderNo:(NSString *)orderNo orderType:(NSString *)orderType amount:(NSString *)amount orderTime:(NSString *)orderTime goodsId:(NSString *)goodsId cardNo:(NSString *)cardNo;
+ (NSString *)md5:(NSString *)str;
@end
