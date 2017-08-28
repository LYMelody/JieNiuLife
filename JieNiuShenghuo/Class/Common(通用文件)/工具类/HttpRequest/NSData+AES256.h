//
//  NSData+AES256.h
//  LifeAssistant
//
//  Created by Kim on 15/7/27.
//  Copyright (c) 2015年 Rongfeng. All rights reserved.
//

#ifndef LifeAssistant_NSData_AES256_h
#define LifeAssistant_NSData_AES256_h
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData(AES256)
-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;
@end

#endif
