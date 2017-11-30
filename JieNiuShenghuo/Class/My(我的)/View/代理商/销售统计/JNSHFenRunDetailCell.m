//
//  JNSHFenRunDetailCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHFenRunDetailCell.h"
#import "Masonry.h"

@implementation JNSHFenRunDetailCell


- (instancetype)init {
    
    if (self = [super init]) {
        [self setUpViews];
    }
    
    return self;
    
}


- (void)setUpViews {
    
    self.orderCashLab = [[UILabel alloc] init];
    self.orderCashLab.text = @"订单金额";
    self.orderCashLab.textColor = ColorText;
    self.orderCashLab.textAlignment = NSTextAlignmentLeft;
    self.orderCashLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.orderCashLab];
    
    self.orderNumLab = [[UILabel alloc] init];
    self.orderNumLab.textColor = [UIColor redColor];
    self.orderNumLab.textAlignment = NSTextAlignmentLeft;
    self.orderNumLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.orderNumLab];
    
    self.fenRunNumLab = [[UILabel alloc] init];
    self.fenRunNumLab.text = @"分润金额";
    self.fenRunNumLab.textAlignment = NSTextAlignmentRight;
    self.fenRunNumLab.textColor = ColorText;
    self.fenRunNumLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.fenRunNumLab];
    
    self.fenRunCashLab = [[UILabel alloc] init];
    self.fenRunCashLab.textColor = [UIColor redColor];
    self.fenRunCashLab.textAlignment = NSTextAlignmentRight;
    self.fenRunCashLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.fenRunCashLab];
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.text = @"交易时间";
    self.timeLab.font = [UIFont systemFontOfSize:14];
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    self.timeLab.textColor = ColorText;
    [self.contentView addSubview:self.timeLab];
    
    self.saleTimeLab = [[UILabel alloc] init];
    self.saleTimeLab.font = [UIFont systemFontOfSize:12];
    self.saleTimeLab.textColor = ColorLightText;
    self.saleTimeLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.saleTimeLab];
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.font = [UIFont systemFontOfSize:14];
    self.typeLab.textAlignment =NSTextAlignmentRight;
    self.typeLab.textColor = ColorText;
    self.typeLab.text = @"订单类型";
    [self.contentView addSubview:self.typeLab];
    
    self.orderTypeLab = [[UILabel alloc] init];
    self.orderTypeLab.font = [UIFont systemFontOfSize:13];
    self.orderTypeLab.textColor = ColorLightText;
    self.orderTypeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.orderTypeLab];
    
    self.orderLab = [[UILabel alloc] init];
    self.orderLab.font = [UIFont systemFontOfSize:14];
    self.orderLab.textColor = ColorText;
    self.orderLab.textAlignment = NSTextAlignmentLeft;
    self.orderLab.text = @"订单编号";
    [self.contentView addSubview:self.orderLab];
    
    self.orderNoLab = [[UILabel alloc] init];
    self.orderNoLab.font = [UIFont systemFontOfSize:12];
    self.orderNoLab.textAlignment = NSTextAlignmentLeft;
    self.orderNoLab.textColor = ColorLightText;
    [self.contentView addSubview:self.orderNoLab];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.orderCashLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize height:15]));
    }];
    
    [self.orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderCashLab);
        make.left.equalTo(self.orderCashLab.mas_right).offset([JNSHAutoSize width:6]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:15]));
    }];
    
    [self.fenRunCashLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderCashLab);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize height:15]));
    }];
    
    [self.fenRunNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderCashLab);
        make.right.equalTo(self.fenRunCashLab.mas_left).offset(-[JNSHAutoSize width:8]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderCashLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.orderCashLab);
        make.size.equalTo(self.orderCashLab);
    }];
    
    [self.saleTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab);
        make.left.equalTo(self.orderCashLab.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:120], [JNSHAutoSize height:15]));
    }];
    
    [self.orderTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fenRunCashLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.right.equalTo(self.fenRunCashLab);
        make.size.equalTo(self.fenRunCashLab);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderTypeLab);
        make.right.equalTo(self.orderTypeLab.mas_left).offset(-[JNSHAutoSize width:10]);
        make.size.equalTo(self.fenRunNumLab);
    }];
    
    [self.orderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.timeLab);
        make.size.equalTo(self.timeLab);
    }];
    
    [self.orderNoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderLab);
        make.left.equalTo(self.orderLab.mas_right).offset([JNSHAutoSize width:10]);
        make.right.equalTo(self);
        make.height.mas_equalTo([JNSHAutoSize height:15]);
    }];
    
    
}



@end
