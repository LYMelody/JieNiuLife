//
//  JNSHTicketsSuccessView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/7.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHTicketsSuccessView.h"
#import "Masonry.h"
#import "JNSHTicketsController.h"

@interface JNSHTicketsSuccessView()

@property(nonatomic,strong)UIImageView *customView;

@property(nonatomic,strong)UIImageView *midImg;

@property(nonatomic,strong)UIButton *dismissBtn;

@property(nonatomic,strong)UIButton *usageBtn;

@end


@implementation JNSHTicketsSuccessView


- (id)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        [self setUpViews];
    }
    
    return self;
    
}

- (void)setUpViews{
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    self.userInteractionEnabled = YES;
    self.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    self.customView = [[UIImageView alloc] init];
    self.customView.backgroundColor = [UIColor whiteColor];
    self.customView.layer.cornerRadius = 10;
    self.customView.userInteractionEnabled = YES;
    self.customView.hidden = YES;
    [self addSubview:self.customView];

    self.customView.frame = CGRectMake(0, 0, [JNSHAutoSize width:221], [JNSHAutoSize height:226]);
    self.customView.center = self.center;
    
    self.midImg = [[UIImageView alloc] init];
    self.midImg.image = [UIImage imageNamed:@"领取成功"];
    [self.customView addSubview:self.midImg];
    
    [self.midImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customView).offset([JNSHAutoSize height:23]);
        if([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
            make.centerX.equalTo(self.customView);
        }else {
            make.left.equalTo(self.customView).offset([JNSHAutoSize width:30]);
            make.right.equalTo(self.customView).offset(-[JNSHAutoSize width:40]);
        }
        make.bottom.equalTo(self.customView).offset(-[JNSHAutoSize height:84]);
    }];
    
    self.dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.dismissBtn setImage:[UIImage imageNamed:@"_delete"] forState:UIControlStateNormal];
    [self.dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.customView addSubview:self.dismissBtn];
    
    [self.dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customView);
       
        if (IS_IOS11) {
            make.right.equalTo(self.customView);
        }else {
             make.right.equalTo(self.customView).offset(-[JNSHAutoSize width:21]);
        }
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:21], [JNSHAutoSize height:21]));
    }];
    
    self.usageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.usageBtn setTitle:@"查看使用" forState:UIControlStateNormal];
    [self.usageBtn setBackgroundColor:ColorTabBarBackColor];
    self.usageBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.usageBtn.titleLabel.textColor = [UIColor whiteColor];
    self.usageBtn.layer.cornerRadius = 3;
    self.usageBtn.layer.masksToBounds = YES;
    [self.usageBtn addTarget:self action:@selector(usage) forControlEvents:UIControlEventTouchUpInside];
    [self.customView addSubview:self.usageBtn];
    
    [self.usageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IS_IOS11) {
            make.left.equalTo(self.customView).offset([JNSHAutoSize width:48]);
            make.right.equalTo(self.customView).offset(-[JNSHAutoSize width:48]);
        }else {
            make.left.equalTo(self.customView).offset([JNSHAutoSize width:48]);
            make.right.equalTo(self.customView).offset(-[JNSHAutoSize width:68]);
        }
        make.top.equalTo(self.midImg.mas_bottom).offset([JNSHAutoSize height:20]);
        make.height.mas_equalTo([JNSHAutoSize height:26]);
        
    }];
    
}

//查看使用
- (void)usage {
    
    NSLog(@"查看使用");
    
    if (self.watchTicksBlock) {
        
        [self dismiss];
        
        self.watchTicksBlock();
    }
}

- (void)showinView:(UIWindow *)view {
    
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:self.customView];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        self.customView.hidden = NO;
        self.customView.center = self.center;
        self.customView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.customView.transform = CGAffineTransformMakeScale(0.9, 0.9);
        } completion:^(BOOL finished) {
            self.customView.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }];
    
}

- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.customView.hidden = YES;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
        [self.customView removeFromSuperview];
    }];
    
    
}


@end
