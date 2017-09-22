//
//  JNSHAlertView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/11.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAlertView.h"
#import "Masonry.h"

@implementation JNSHAlertView


- (id)initWithFrame:(CGRect)frame cancle:(NSString *)cancletext sure:(NSString *)suretext {
    
     self =  [super initWithFrame:frame];
    
    if (self ) {
        
        
        [self setUpViews:cancletext suretext:suretext];
        
        
    }
    
    return self;
    
}


- (id)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        _color = BlueColor;
        
        [self setUpViews:nil suretext:@"确定"];
    }
    
    return self;
    
}


- (void)setUpViews:(NSString *)cancel suretext:(NSString *)suretext{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    self.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentView.layer.cornerRadius = 10;
    _contentView.layer.masksToBounds = YES;
    _contentView.frame = CGRectMake((KscreenWidth - 210)/2.0, KscreenHeight, [JNSHAutoSize width:210], [JNSHAutoSize height:125]);
    if (cancel != nil) {
        _contentView.frame = CGRectMake((KscreenWidth - 251)/2.0, KscreenHeight, [JNSHAutoSize width:251], [JNSHAutoSize height:151]);
    }
    _contentView.center = self.center;
    _contentView.hidden = YES;
    [self addSubview:_contentView];
    
    _messageLab = [[UILabel alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:25], [JNSHAutoSize width:211], [JNSHAutoSize height:40])];
    
    if (cancel != nil) {
        _messageLab = [[UILabel alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:25], [JNSHAutoSize width:251], [JNSHAutoSize height:60])];
    }
    
    _messageLab.font = [UIFont systemFontOfSize:15];
    _messageLab.textColor = ColorText;
    _messageLab.textAlignment = NSTextAlignmentCenter;
    _messageLab.numberOfLines = 0;
    [_contentView addSubview:_messageLab];
    
    self.cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancleBtn setTitle:cancel forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancleBtn.layer.cornerRadius = 3;
    self.cancleBtn.layer.masksToBounds = YES;
    self.cancleBtn.backgroundColor = BlueColor;
    self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    self.cancleBtn.hidden = YES;
    [self.cancleBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:self.cancleBtn];
    
    NSLog(@"手机系统：%@",SystemVersion);
    
    
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_contentView).offset(-[JNSHAutoSize height:([SystemVersion floatValue] >= 11.0)?30:60]);
        make.left.equalTo(_contentView).offset([JNSHAutoSize width:40]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:30]));
    }];
    
    if (cancel != nil) {
        self.cancleBtn.hidden = NO;
    }
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:suretext forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn.layer.cornerRadius = 3;
    _sureBtn.layer.masksToBounds = YES;
    _sureBtn.backgroundColor = BlueColor;
    _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    //_sureBtn.frame = CGRectMake([JNSHAutoSize width:(111)]/2.0, [JNSHAutoSize height:82], [JNSHAutoSize width:110], [JNSHAutoSize height:30]);
    [_sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_sureBtn];
    
    if (cancel != nil) {
        
        [_sureBtn setBackgroundColor:ColorTabBarBackColor];
        
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cancleBtn);
            make.right.equalTo(_contentView).offset(-[JNSHAutoSize width:([SystemVersion floatValue] >= 11.0)?40:80]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:30]));
        }];
        
    }else {
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_messageLab);
            make.top.equalTo(_contentView).offset([JNSHAutoSize height:82]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:110], [JNSHAutoSize height:30]));
        }];
    }
}

- (void)sure {

    if (self.sureAlertBlock) {
        self.sureAlertBlock();
    }
    
    
}

- (void)cancle {
    
    [self dismiss];
    
}


- (void)show:(NSString *)message inView:(UIView *)view {
    
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    _messageLab.text = message;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        _contentView.hidden = NO;
        _contentView.center = self.center;
        _contentView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            _contentView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            _contentView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
    
    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
//        _contentView.frame = CGRectMake((KscreenWidth - 211)/2.0, KscreenHeight,  [JNSHAutoSize width:211], [JNSHAutoSize height:106]);
        _contentView.hidden = YES;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        [_contentView removeFromSuperview];
    }];
    
}

- (void)setColor:(UIColor *)color {
    
    _color = color;
    
    [_sureBtn setBackgroundColor:color];
    
    
    
}

@end
