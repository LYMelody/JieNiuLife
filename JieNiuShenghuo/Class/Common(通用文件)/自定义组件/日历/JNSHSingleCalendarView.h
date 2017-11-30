//
//  JNSHSingleCalendarView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAYCalendarView.h"

typedef void(^DateSelectBlock)(NSString *date);

@interface JNSHSingleCalendarView : UIView

@property(nonatomic,strong)DAYCalendarView *calendarView;

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,copy)DateSelectBlock dateSelectBlock;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
