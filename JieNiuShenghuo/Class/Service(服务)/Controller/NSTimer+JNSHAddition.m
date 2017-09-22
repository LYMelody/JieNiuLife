//
//  NSTimer+JNSHAddition.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/21.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "NSTimer+JNSHAddition.h"

@implementation NSTimer (JNSHAddition)

- (void)pause {
    
    if (!self.isValid) return;
    //暂停定时器
    [self setFireDate:[NSDate distantFuture]];
    
}

- (void)resume {
    
    if (!self.isValid) return;
    //继续
    [self setFireDate:[NSDate date]];
    
    
}

- (void)resumeWithTimeInterval:(NSTimeInterval)time {
    
    if(!self.isValid) return;
    
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
    
}


@end
