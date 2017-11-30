//
//  JNSHDalyFenRunCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHDalyFenRunCell.h"
#import "Masonry.h"

@implementation JNSHDalyFenRunCell

- (instancetype)init {
    
    if (self = [super init]) {
        [self setUpViews];
    }

    return self;
    
}


- (void)setUpViews{
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.text = @"分润日期";
    self.timeLab.textColor = ColorText;
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    self.timeLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.timeLab];
    
    self.fenRunTimeLab = [[UILabel alloc] init];
    self.fenRunTimeLab.textColor =ColorLightText;
    self.fenRunTimeLab.textAlignment = NSTextAlignmentLeft;
    self.fenRunTimeLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.fenRunTimeLab];
    
    self.statusLab = [[UILabel alloc] init];
    self.statusLab.text = @"出款状态";
    self.statusLab.textColor = ColorLightText;
    self.statusLab.textAlignment = NSTextAlignmentRight;
    self.statusLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.statusLab];
    
    self.cashStatusLab = [[UILabel alloc] init];
    self.cashStatusLab.textColor = GreenColor;
    self.cashStatusLab.textAlignment = NSTextAlignmentRight;
    self.cashStatusLab.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.cashStatusLab];
    
    self.moneyLab = [[UILabel alloc] init];
    self.moneyLab.text = @"汇总金额";
    self.moneyLab.textColor = ColorText;
    self.moneyLab.textAlignment = NSTextAlignmentLeft;
    self.moneyLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.moneyLab];
    
    self.amountLab = [[UILabel alloc] init];
    self.amountLab.textAlignment = NSTextAlignmentLeft;
    self.amountLab.textColor = [UIColor redColor];
    self.amountLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.amountLab];
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize height:15]));
    }];
    
    [self.fenRunTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab);
        make.left.equalTo(self.timeLab.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:120], [JNSHAutoSize height:15]));
    }];
    
    [self.cashStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize height:15]));
    }];
    
    
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cashStatusLab);
        make.right.equalTo(self.cashStatusLab.mas_left).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:120], [JNSHAutoSize height:15]));
    }];
    
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab.mas_bottom).offset([JNSHAutoSize height:20]);
        make.left.equalTo(self.timeLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize height:15]));
    }];
    
    [self.amountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLab);
        make.left.equalTo(self.fenRunTimeLab);
        make.size.equalTo(self.fenRunTimeLab);
    }];
    
}


@end
