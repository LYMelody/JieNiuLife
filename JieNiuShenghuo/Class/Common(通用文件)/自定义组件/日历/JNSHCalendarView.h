//
//  JNSHCalendarView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/16.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAYCalendarView.h"

typedef void(^dismissBlock)(void);

typedef void(^dateChoseBlock)(void);

@interface JNSHCalendarView : UIView

@property(nonatomic,strong)DAYCalendarView *calendarView;

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,copy)dismissBlock dismissblock;

@property(nonatomic,copy)dateChoseBlock datechoseblock;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
