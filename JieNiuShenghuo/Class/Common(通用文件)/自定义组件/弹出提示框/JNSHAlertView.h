//
//  JNSHAlertView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/11.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SureAlertBlock)(void);

@interface JNSHAlertView : UIView

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)UILabel *messageLab;

@property(nonatomic,copy)UIColor *color;

@property(nonatomic,strong)UIButton *sureBtn;

@property(nonatomic,strong)UIButton *cancleBtn;

@property(nonatomic,copy)SureAlertBlock sureAlertBlock;


- (id)initWithFrame:(CGRect)frame cancle:(NSString *)cancletext sure:(NSString *)suretext;

- (void)show:(NSString *)message inView:(UIView *)view;

- (void)dismiss;
    



@end
