//
//  JNSHUserManagerCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/27.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHUserManagerCell.h"
#import "Masonry.h"

@implementation JNSHUserManagerCell

- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
    
}

- (void)setUpViews {
    
    self.UserLab = [[UILabel alloc] init];
    self.UserLab.text = @"商户姓名";
    self.UserLab.textColor = ColorText;
    self.UserLab.font = [UIFont systemFontOfSize:14];
    self.UserLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.UserLab];
    
    self.UserNameLab = [[UILabel alloc] init];
    self.UserNameLab.text = @"张三丰";
    self.UserNameLab.textColor = ColorLightText;
    self.UserNameLab.font = [UIFont systemFontOfSize:12];
    self.UserNameLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.UserNameLab];
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.text = @"注册时间";
    self.timeLab.textColor = ColorText;
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    self.timeLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.timeLab];
    
    self.ResignTimeLab = [[UILabel alloc] init];
    self.ResignTimeLab.text = @"2017-12-12";
    self.ResignTimeLab.textColor = ColorLightText;
    self.ResignTimeLab.textAlignment = NSTextAlignmentLeft;
    self.ResignTimeLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.ResignTimeLab];
    
    self.phoneLab = [[UILabel alloc] init];
    self.phoneLab.text = @"手机号码";
    self.phoneLab.textColor = ColorText;
    self.phoneLab.textAlignment = NSTextAlignmentLeft;
    self.phoneLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.phoneLab];
    
    self.NumPhoneLab = [[UILabel alloc] init];
    self.NumPhoneLab.textColor = ColorLightText;
    self.NumPhoneLab.font = [UIFont systemFontOfSize:12];
    self.NumPhoneLab.textAlignment = NSTextAlignmentLeft;
    self.NumPhoneLab.text = @"135****5142";
    [self.contentView addSubview:self.NumPhoneLab];
    
    self.statusLab = [[UILabel alloc] init];
    self.statusLab.font = [UIFont systemFontOfSize:14];
    self.statusLab.textColor = ColorText;
    self.statusLab.textAlignment = NSTextAlignmentLeft;
    self.statusLab.text = @"注册状态";
    [self.contentView addSubview:self.statusLab];
    
    self.ResignStatusLab = [[UILabel alloc] init];
    self.ResignStatusLab.font = [UIFont systemFontOfSize:13];
    self.ResignStatusLab.text = @"审核通过";
    self.ResignStatusLab.textAlignment = NSTextAlignmentLeft;
    self.ResignStatusLab.textColor = GreenColor;
    [self.contentView addSubview:self.ResignStatusLab];
    
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.UserLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    [self.UserNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.UserLab);
        make.left.equalTo(self.UserLab.mas_right).offset([JNSHAutoSize width:20]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.UserLab);
        make.left.equalTo(self.UserNameLab.mas_right).offset([JNSHAutoSize width:20]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    [self.ResignTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab);
        make.left.equalTo(self.timeLab.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.UserLab);
        make.top.equalTo(self.UserLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    [self.NumPhoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.UserNameLab);
        make.top.equalTo(self.phoneLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLab);
        make.top.equalTo(self.NumPhoneLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    [self.ResignStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusLab);
        make.left.equalTo(self.ResignTimeLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
}

@end
