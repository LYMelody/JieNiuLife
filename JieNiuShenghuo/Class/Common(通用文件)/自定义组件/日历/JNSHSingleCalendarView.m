//
//  JNSHSingleCalendarView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSingleCalendarView.h"

@implementation JNSHSingleCalendarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        [self setUpViews];
        
    }
    
    return self;
}

//
- (void)setUpViews {
    
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = CGRectMake(0,64+ [JNSHAutoSize height:46], KscreenWidth, 0);
    
    self.calendarView = [[DAYCalendarView alloc] init];
    self.calendarView.boldPrimaryComponentText = NO;
    [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
    self.calendarView.alpha = 1;
    //[self.contentView addSubview:self.calendarView];
    
}

- (void)calendarViewDidChange:(id)sender {
    //self.datePicker.date = self.calendarView.selectedDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@", [formatter stringFromDate:self.calendarView.selectedDate]);
    
    NSString *time = [formatter stringFromDate:self.calendarView.selectedDate];
    if (self.dateSelectBlock) {
        self.dateSelectBlock(time);
    }
    
    [self dismiss];
    
}

- (void)showInView:(UIView *)view {
    
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:self.contentView];
    [view addSubview:self.calendarView];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
    
    self.contentView.frame = CGRectMake(0,  [JNSHAutoSize height:52], KscreenWidth, [JNSHAutoSize height:0]);
    self.calendarView.frame = CGRectMake(0, [JNSHAutoSize height:52], KscreenWidth, [JNSHAutoSize height:0]);
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.contentView.frame = CGRectMake(0, [JNSHAutoSize height:52], KscreenWidth, [JNSHAutoSize height:300]);
        self.calendarView.frame = CGRectMake(0, [JNSHAutoSize height:52], KscreenWidth, [JNSHAutoSize height:250]);
        self.calendarView.alpha = 1.0;
        
    }];
    
}

- (void)dismiss {
    
    [self.calendarView removeFromSuperview];
   
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.contentView.frame = CGRectMake(0,  [JNSHAutoSize height:49], KscreenWidth, [JNSHAutoSize height:0]);
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
    
}


@end
