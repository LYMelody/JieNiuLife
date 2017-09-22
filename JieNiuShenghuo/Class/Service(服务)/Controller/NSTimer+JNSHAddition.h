//
//  NSTimer+JNSHAddition.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/21.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (JNSHAddition)

- (void)pause;

- (void)resume;

- (void)resumeWithTimeInterval:(NSTimeInterval)time;


@end
