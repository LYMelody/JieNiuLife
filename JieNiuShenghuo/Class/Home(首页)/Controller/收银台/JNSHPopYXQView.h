//
//  JNSHPopYXQView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectDateBlock)(NSString *selectDate);

@interface JNSHPopYXQView : UIView

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)NSString *selectDate;

@property(nonatomic,copy)selectDateBlock selectdateblock;

//@property(nonatomic,)

- (void)showInView:(UIView *)view;

- (void)dismiss;


@end
