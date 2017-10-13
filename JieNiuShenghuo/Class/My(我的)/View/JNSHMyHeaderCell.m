//
//  JNSHMyHeaderCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/4.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHMyHeaderCell.h"
#import "Masonry.h"
@implementation JNSHMyHeaderCell


- (instancetype)init {
    
    if ([super init]) {
        
        self.showVip = NO;
        self.isLogoedIn = NO;
        [self setUpViews];
    }
    
    return self;
}


- (void)setUpViews{
    
    self.backgroundColor = ColorTabBarBackColor;
    
    _headerView = [[UIImageView alloc] init];
    _headerView.layer.cornerRadius = 3;
    _headerView.layer.masksToBounds = YES;
    _headerView.backgroundColor = [UIColor whiteColor];
    _headerView.contentMode = UIViewContentModeScaleAspectFill;
    _headerView.clipsToBounds = YES;
    [self addSubview:_headerView];
    
    _nickNameLab = [[UILabel alloc] init];
    _nickNameLab.font = [UIFont systemFontOfSize:15];
    _nickNameLab.textColor = [UIColor whiteColor];
    _nickNameLab.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:_nickNameLab];
    
    
    _phoneLab = [[UILabel alloc] init];
    _phoneLab.font = [UIFont systemFontOfSize:15];
    _phoneLab.textAlignment = NSTextAlignmentLeft;
    _phoneLab.textColor = [UIColor whiteColor];
    
    [self addSubview:_phoneLab];
    
    _vipImgView = [[UIImageView alloc] init];
    _vipImgView.image = [UIImage imageNamed:@"my_head_vip"];
    _vipImgView.layer.masksToBounds = YES;
    _vipImgView.layer.cornerRadius = 5;
    [self addSubview:_vipImgView];
    
    _rightIndicatorView = [[UIImageView alloc] init];
    _rightIndicatorView.image = [UIImage imageNamed:@"my_arror_right_white"];
    
    [self addSubview:_rightIndicatorView];
    
    _logoInLab = [[UILabel alloc] init];
    _logoInLab.font = [UIFont systemFontOfSize:15];
    _logoInLab.textColor = [UIColor whiteColor];
    _logoInLab.textAlignment = NSTextAlignmentLeft;
    _logoInLab.text = @"登录/注册";
    _logoInLab.hidden = YES;
    [self addSubview:_logoInLab];
    
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.size.mas_offset(CGSizeMake(46, 46));
    }];
    
    [_nickNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView).offset(2);
        make.left.equalTo(_headerView.mas_right).offset(12);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_nickNameLab.mas_bottom).offset(5);
        make.left.equalTo(_nickNameLab);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [_vipImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerView.mas_right).offset(-3);
        make.centerY.equalTo(_headerView.mas_bottom).offset(-3);
    }];
    
    [_rightIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15);
        make.size.mas_equalTo(CGSizeMake(8, 12));
    }];
    
    [_logoInLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headerView);
        make.left.equalTo(_headerView.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:20]));
    }];
    
    
}

- (void)setShowVip:(BOOL)showVip {
    
    _showVip = showVip;
    
    if (showVip) {
        _vipImgView.image = [UIImage imageNamed:@"my_head_vip"];
    }else {
        _vipImgView.image = [UIImage imageNamed:@"vip_head_vip_grey"];
    }
}

- (void)setIsLogoedIn:(BOOL)isLogoedIn {
    
    _isLogoedIn = isLogoedIn;
    
    if (isLogoedIn) {
        _logoInLab.hidden = YES;
        _nickNameLab.hidden = NO;
        _phoneLab.hidden = NO;
        _vipImgView.hidden = NO;
    }else {
        
        _nickNameLab.hidden = YES;
        _phoneLab.hidden = YES;
        _vipImgView.hidden = YES;
        _logoInLab.hidden = NO;
        _headerView.image = [UIImage imageNamed:@"my_head_portrait_grey"];
    }
    
    
    
    
}


@end
