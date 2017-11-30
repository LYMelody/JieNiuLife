//
//  JNSHAgentOrderCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/28.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAgentOrderCell.h"
#import "Masonry.h"

@implementation JNSHAgentOrderCell

- (instancetype)init {
    
    if (self = [super init]) {
        [self setUpViews];
    }
    
    return self;
    
}

- (void)setUpViews {
    
    self.moneyLab = [[UILabel alloc] init];
    self.moneyLab.text = @"交易金额";
    self.moneyLab.textColor = ColorText;
    self.moneyLab.font = [UIFont systemFontOfSize:15];
    self.moneyLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.moneyLab];
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.textColor = [UIColor redColor];
    self.numLab.textAlignment = NSTextAlignmentLeft;
    self.numLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.numLab];
    
    self.userLab = [[UILabel alloc] init];
    self.userLab.font = [UIFont systemFontOfSize:15];
    self.userLab.text = @"商户名称";
    self.userLab.textAlignment = NSTextAlignmentRight;
    self.userLab.textColor = ColorText;
    [self.contentView addSubview:self.userLab];
    
    self.userNameLab = [[UILabel alloc] init];
    self.userNameLab.font = [UIFont systemFontOfSize:13];
    self.userNameLab.textAlignment = NSTextAlignmentRight;
    self.userNameLab.textColor = ColorLightText;
    [self.contentView addSubview:self.userNameLab];
    
    self.orderLab = [[UILabel alloc] init];
    self.orderLab.text = @"订单编号";
    self.orderLab.font = [UIFont systemFontOfSize:15];
    self.orderLab.textAlignment = NSTextAlignmentLeft;
    self.orderLab.textColor = ColorText;
    [self.contentView addSubview:self.orderLab];
    
    self.orderNoLab = [[UILabel alloc] init];
    self.orderNoLab.font = [UIFont systemFontOfSize:12];
    self.orderNoLab.textColor = ColorLightText;
    self.orderNoLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.orderNoLab];
    
    self.statusLab = [[UILabel alloc] init];
    self.statusLab.font = [UIFont systemFontOfSize:15];
    self.statusLab.textColor = ColorText;
    self.statusLab.textAlignment = NSTextAlignmentRight;
    self.statusLab.text = @"交易状态";
    [self.contentView addSubview:self.statusLab];
    
    self.SaleStatusLab = [[UILabel alloc] init];
    self.SaleStatusLab.font = [UIFont  systemFontOfSize:13];
    self.SaleStatusLab.textColor = ColorText;
    self.SaleStatusLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.SaleStatusLab];
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = [UIFont systemFontOfSize:15];
    self.timeLab.textColor = ColorText;
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    self.timeLab.text = @"交易时间";
    [self.contentView addSubview:self.timeLab];
    
    self.saleTimeLab = [[UILabel alloc] init];
    self.saleTimeLab.font = [UIFont systemFontOfSize:12];
    self.saleTimeLab.textAlignment = NSTextAlignmentLeft;
    self.saleTimeLab.textColor =ColorLightText;
    [self.contentView addSubview:self.saleTimeLab];
    
    self.typeLab = [[UILabel alloc] init];
    self.typeLab.font = [UIFont systemFontOfSize:15];
    self.typeLab.textAlignment = NSTextAlignmentRight;
    self.typeLab.textColor = ColorText;
    self.typeLab.text = @"订单类型";
    [self.contentView addSubview:self.typeLab];
    
    self.orderTypeLab = [[UILabel alloc] init];
    self.orderTypeLab.font = [UIFont systemFontOfSize:13];
    self.orderTypeLab.textAlignment = NSTextAlignmentRight;
    self.orderTypeLab.textColor =ColorLightText;
    [self.contentView addSubview:self.orderTypeLab];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize height:15]));
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLab);
        make.left.equalTo(self.moneyLab.mas_right).offset([JNSHAutoSize width:6]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:15]));
    }];
    
    [self.userNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLab);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize height:15]));
    }];
    
    [self.userLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLab);
        make.right.equalTo(self.userNameLab.mas_left).offset(-[JNSHAutoSize width:8]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
    [self.orderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moneyLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.moneyLab);
        make.size.equalTo(self.moneyLab);
    }];
    
    [self.orderNoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderLab);
        make.left.equalTo(self.moneyLab.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:120], [JNSHAutoSize height:15]));
    }];
    
    [self.SaleStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userNameLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.right.equalTo(self.userNameLab);
        make.size.equalTo(self.userNameLab);
    }];
    
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SaleStatusLab);
        make.right.equalTo(self.SaleStatusLab.mas_left).offset(-[JNSHAutoSize width:10]);
        make.size.equalTo(self.userLab);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.orderLab);
        make.size.equalTo(self.orderLab);
    }];
    
    [self.saleTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab);
        make.left.equalTo(self.timeLab.mas_right).offset([JNSHAutoSize width:10]);
        make.size.equalTo(self.orderNoLab);
    }];
    
    [self.orderTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SaleStatusLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.right.equalTo(self.SaleStatusLab);
        make.size.equalTo(self.SaleStatusLab);
    }];
    
    [self.typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderTypeLab);
        make.right.equalTo(self.orderTypeLab.mas_left).offset(-[JNSHAutoSize width:10]);
        make.size.equalTo(self.statusLab);
    }];
    
    
}


@end
