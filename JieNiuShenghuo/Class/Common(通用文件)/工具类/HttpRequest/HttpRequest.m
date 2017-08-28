//
//  HttpRequest.m
//  JingXuan
//
//  Created by wj on 16/5/19.
//  Copyright © 2016年 rongFeng. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"
#import "NSObject+SBJSON.h"
#import "IBHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "macro.h"
#import "NoCardModel.h"
@implementation HttpRequest

//无卡收款
//+ (void)noCardRequestOrderType:(NSString *)orderType amount:(NSString *)amount {
//    
//    //获取版本号
////    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
////    NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
//    
//    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@",orderType,amount,@"2702546835",token(@"key")];
//    NSString *SIGN = [self md5:sign];
//    
//    NSDictionary *dic1 = @{@"orderType":orderType,
//                           @"amount":amount,
//                           @"version":@"2702546835",
//                           @"token":token(@"auth"),
//                           @"sign":SIGN,
//                           };
//    NSDictionary *dicc = @{@"action":@"OrderCreate",
//                           @"data":dic1};
//    NSString *params = [dicc JSONFragment];
//    [IBHttpTool postWithURL:HOST params:params success:^(id result) {
//        NSDictionary *dic = [result JSONValue];
////        NoCardModel *noCard = [[NoCardModel alloc] init];
////        [noCard initWithDic:dic];
//        
//        
//        
//        NSLog(@"%@",dic);
//    } failure:^(NSError *error) {
//        NSLog(@"网络请求失败:%@",error);
//    }];
//    
//}
//订单信息确认
+ (void)shortcutRequestOrderNo:(NSString *)orderNo orderType:(NSString *)orderType amount:(NSString *)amount orderTime:(NSString *)orderTime goodsId:(NSString *)goodsId cardNo:(NSString *)cardNo {
    
    NSString *sign = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",orderNo,orderType,amount,orderTime,goodsId,cardNo,token(@"key")];
    NSLog(@"%@",sign);
    NSString *SIGN = [self md5:sign];
    //转换成16位
    //    NSString *SIGN = [[UUID substringFromIndex:8] substringToIndex:16];
    NSDictionary *dic1 = @{@"orderNo":orderNo,
                           @"orderType":orderType,
                           @"amount":amount,
                           @"orderTime":orderTime,
                           @"goodsId":goodsId,
                           @"cardNo":cardNo,
                           @"token":token(@"auth"),
                           @"sign":SIGN,
                           };
    NSDictionary *dicc = @{@"action":@"OrderCreate",
                           @"data":dic1};
    NSString *params = [dicc JSONFragment];
    [IBHttpTool postWithURL:HOST params:params success:^(id result) {
        NSLog(@"数据:%@",result);
        //        NSDictionary *dic = [result JSONValue];
        
        
    } failure:^(NSError *error) {
        NSLog(@"网络请求失败:%@",error);
    }];
}

+ (NSString *)md5:(NSString *)str

{
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ];
    
}

@end
