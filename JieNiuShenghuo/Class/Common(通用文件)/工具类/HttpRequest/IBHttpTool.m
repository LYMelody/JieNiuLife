//
//  AWHttpTool.m
//  MyWeibo
//
//  Created by All on 14-10-3.
//  Copyright (c) 2014年 All. All rights reserved.
//

#import "IBHttpTool.h"
#import "NSData+AES256.h"
#import "AFNetworking.h"
#import "NSString+AES256.h"
#import "SBJSON.h"
#import "Base64.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonDigest.h>
#import "JNSHCommon.h"
#import "JNSYUserInfo.h"
#define AESKEY @"duew&^%5d54nc'KH"
#define NewAesKey @"UBKKWNA216MXCGVJ"

@implementation IBHttpTool

+ (void)postWithURL:(NSString *)url params:(NSString *)params success:(IBHttpSuccess)success failure:(IBHttpFailure)failure
{
    [self requestWithMethod:@"POST" url:url params:params success:success failure:failure];
}

+ (void)requestWithMethod:(NSString *)method url:(NSString *)url params:(NSString *)params success:(IBHttpSuccess)success failure:(IBHttpFailure)failure
{
    
    NSDictionary *dic = [params JSONValue];
    //NSLog(@"传过来的参数:%@",dic);
    NSDictionary *dicc = dic[@"data"];
    NSString *action = dic[@"action"];
   
    NSString *token = dic[@"token"];
    
    NSString *Params = [dicc JSONFragment];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSSet *set = [NSSet setWithObjects:@"text/html", @"application/json",@"text/plain", nil];
    manager.responseSerializer.acceptableContentTypes = set;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"text/xml"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //create the body
    //加密
    
    //base64编码
    NSData *base64Data = [Params dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    base64Data = [GTMBase64 encodeData:base64Data];
    NSString *base64String = [[NSString alloc] initWithData:base64Data encoding:NSUTF8StringEncoding];
    if ([action isEqualToString:@"fileUploadState"]) { //如果是上传照片则不需base64编码
        base64String = Params;
    }
    //NSLog(@"base64:%@",base64String);
    
    NSString *aesstr = [base64String aes256_encrypt:[[JNSYUserInfo getUserInfo].userKey substringWithRange:NSMakeRange(0, 16)]];
    
    //NSString *otherstr = [aesstr aes256_decrypt:NewAesKey];
    //NSLog(@"key:%@",[[JNSYUserInfo getUserInfo].userKey substringToIndex:16]);
    NSString *md5 = [NSString stringWithFormat:@"%@%@%@%@",action,token,aesstr,[JNSYUserInfo getUserInfo].userKey];
    NSString *sign = [self md5HexDigest:md5];
    NSString *Aesstr = [NSString stringWithFormat:@"action=%@&token=%@&data=%@&sign=%@",action,token,aesstr,sign];
    //NSLog(@"md5前:%@,md5后:%@",md5,sign);
    //NSLog(@"加密后的数据:%@",aesstr);
    //NSLog(@"%@",Aesstr);
    //NSLog(@"key:%@,token:%@",[JNSYUserInfo getUserInfo].userKey,token);
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[Aesstr dataUsingEncoding:NSUTF8StringEncoding]];
    //NSLog(@"data:%@",[Aesstr dataUsingEncoding:NSUTF8StringEncoding]);
    //post
    [request setHTTPBody:postBody];
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *aesstr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [aesstr JSONValue];
        //如果返回正常，取“data”里面数据解密
        if(dic[@"data"]) {
            NSString *data = dic[@"data"];
            data = [data aes256_decrypt:[[JNSYUserInfo getUserInfo].userKey substringWithRange:NSMakeRange(0, 16)]];
            NSData *Datadata = [data dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
            Datadata = [GTMBase64 decodeData:Datadata];
            data = [[NSString alloc] initWithData:Datadata encoding:NSUTF8StringEncoding];
            success(data);
        }else {
             success(aesstr);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
         NSLog(@"error:%@",error);
        failure(error);
    }];
    
    [operation start];
    
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
