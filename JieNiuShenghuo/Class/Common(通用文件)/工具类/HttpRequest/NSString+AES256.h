//
//  NSString+AES256.h
//  LifeAssistant
//
//  Created by Kim on 15/7/27.
//  Copyright (c) 2015年 Rongfeng. All rights reserved.
//

#ifndef LifeAssistant_NSString_AES256_h
#define LifeAssistant_NSString_AES256_h

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "NSData+AES256.h"

@interface NSString(AES256)

-(NSString *) aes256_encrypt:(NSString *)key;
-(NSString *) aes256_decrypt:(NSString *)key;

@end
#endif
