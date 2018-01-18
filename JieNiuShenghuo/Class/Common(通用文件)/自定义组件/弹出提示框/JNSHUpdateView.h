//
//  JNSHUpdateView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/10/9.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SureBlock)(void);

@interface JNSHUpdateView : UIView

@property(nonatomic,strong)UIView *coustView;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *contentLab;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,copy)SureBlock sureBlock;

- (void)show:(NSString *)title message:(NSString *)message inView:(UIWindow *)view;

- (void)dismiss;


@end
