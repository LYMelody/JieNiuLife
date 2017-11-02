//
//  JNSHAdvertiseView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/26.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHAdvertiseView : UIView

@property(nonatomic,copy)NSString *filePath;

@property(nonatomic,copy)NSString *timeduration;

@property(nonatomic,copy)NSString *jumpflag;

- (void)show;

@end
