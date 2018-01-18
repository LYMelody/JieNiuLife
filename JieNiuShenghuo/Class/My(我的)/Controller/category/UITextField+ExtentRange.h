//
//  UITextField+ExtentRange.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/12/20.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ExtentRange)

- (NSRange) selectedRange;

- (void) setSelectedRange:(NSRange) range;

@end
