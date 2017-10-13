//
//  JNSHUpdateView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/10/9.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHUpdateView.h"
#import "Masonry.h"





@implementation JNSHUpdateView

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    
    return self;
    
}

- (void)setupViews {
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    self.userInteractionEnabled = YES;
    self.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    self.coustView = [[UIView alloc] init];
    self.coustView.backgroundColor = [UIColor whiteColor];
    self.coustView.layer.cornerRadius = 10;
    self.coustView.hidden = YES;
    self.coustView.frame = CGRectMake(0, 0, [JNSHAutoSize width:210], [JNSHAutoSize height:240]);
    self.coustView.center = self.center;
    [self addSubview:self.coustView];
   
    UIImageView *HeaderImg = [[UIImageView alloc] init];
    HeaderImg.image = [UIImage imageNamed:@"形状-6-拷贝-3"];
    [self.coustView addSubview:HeaderImg];
    
    [HeaderImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coustView);
        make.top.equalTo(self.coustView).offset(-[JNSHAutoSize height:9]);
        make.height.mas_equalTo([JNSHAutoSize height:63]);
        make.width.mas_equalTo([JNSHAutoSize width:210]);
    }];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.textColor = [UIColor colorWithRed:255/255.0 green:102/255.0 blue:0 alpha:1];
    self.titleLab.text = @"全新2.0正式来袭";
    [self.coustView addSubview:self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(HeaderImg.mas_bottom).offset([JNSHAutoSize height:5]);
        make.left.equalTo(self.coustView);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:210], [JNSHAutoSize height:15]));
    }];
    
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.textAlignment = NSTextAlignmentLeft;
    self.contentLab.numberOfLines = 0;
    self.contentLab.textColor = ColorText;
    self.contentLab.text = @"1.界面更新优化;\n2.修复了一些使用中的bug；\n3.新增多种玩法，等你来发现。";
    self.contentLab.font = [UIFont systemFontOfSize:13];
    [self.coustView addSubview:self.contentLab];
    
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.coustView).offset([JNSHAutoSize width:15]);
        make.right.equalTo(self.coustView).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:100]);
    }];
    
    self.sureBtn = [[UIButton alloc] init];
    [self.sureBtn setTitle:@"下次再说" forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 2;
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundColor:LightGrayColor];
    [self.sureBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [self.coustView addSubview:self.sureBtn];
    CGFloat height = 20;
    if(!IS_IOS11) {
        height = 60;
    }
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coustView).offset([JNSHAutoSize width:15]);
        make.bottom.equalTo(self.coustView).offset(-[JNSHAutoSize height:height]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:86], [JNSHAutoSize height:26]));
    }];
    self.sureBtn = [[UIButton alloc] init];
    [self.sureBtn setTitle:@"立即更新" forState:UIControlStateNormal];
    self.sureBtn.layer.cornerRadius = 2;
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sureBtn setBackgroundColor:ColorTabBarBackColor];
    [self.sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.coustView addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(HeaderImg).offset(-[JNSHAutoSize width:15]);
        make.bottom.equalTo(self.coustView).offset(-[JNSHAutoSize height:height]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:86], [JNSHAutoSize height:26]));
    }];
}

//下次再说
- (void)cancle {
    
    
    [self dismiss];
    
}
//立即更新
- (void)sure{
    
    
    
}

- (void)show:(NSString *)title message:(NSString *)message inView:(UIView *)view {
    
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:self.coustView];
    
    //_messageLab.text = message;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        self.coustView.hidden = NO;
        self.coustView.center = self.center;
        self.coustView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.coustView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            self.coustView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.coustView.hidden = YES;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        [self.coustView removeFromSuperview];
    }];
}


@end
