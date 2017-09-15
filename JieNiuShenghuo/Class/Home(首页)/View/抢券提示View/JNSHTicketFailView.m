//
//  JNSHTicketFailView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/14.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHTicketFailView.h"
#import "Masonry.h"

@interface JNSHTicketFailView()

@property(nonatomic,strong)UIImageView *customView;

@property(nonatomic,strong)UIImageView *midImg;

@end


@implementation JNSHTicketFailView

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
    
    self.customView.frame = CGRectMake(0, 0, [JNSHAutoSize width:221], [JNSHAutoSize height:126]);
    self.customView.center = self.center;
    
    self.midImg = [[UIImageView alloc] init];
    self.midImg.image = [UIImage imageNamed:@"failed"];
    [self.customView addSubview:self.midImg];
    
    [self.midImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customView).offset([JNSHAutoSize height:29]);
        make.centerX.equalTo(self.customView).offset(-[JNSHAutoSize width:6]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:35], [JNSHAutoSize width:35]));
    }];
    
    UILabel *textLab = [[UILabel alloc] init];
    textLab.text = @"下次就会成功哦!";
    textLab.font = [UIFont systemFontOfSize:15];
    textLab.textColor = ColorText;
    textLab.textAlignment = NSTextAlignmentCenter;
    
    [self.customView addSubview:textLab];
    
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.customView).offset(-[JNSHAutoSize width:6]);
        make.top.equalTo(self.midImg.mas_bottom).offset([JNSHAutoSize height:19]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:221], [JNSHAutoSize height:20]));
    }];
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
