//
//  JNSHSaleStatisticCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/23.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSaleStatisticCell.h"
#import "Masonry.h"




@implementation JNSHSaleStatisticCell


- (instancetype)init {
    
    if (self = [super init]) {
        [self setUpViews];
    }
    
    return self;
    
}

- (void)setUpViews {
    
    self.FenRunLab = [[UILabel alloc] init];
    self.FenRunLab.font = [UIFont systemFontOfSize:14];
    self.FenRunLab.textAlignment = NSTextAlignmentLeft;
    self.FenRunLab.textColor = ColorText;
    self.FenRunLab.text = @"分润";
    [self.contentView addSubview:self.FenRunLab];
    
    self.FenRunNumLab = [[UILabel alloc] init];
    self.FenRunNumLab.font = [UIFont systemFontOfSize:14];
    self.FenRunNumLab.textAlignment = NSTextAlignmentRight;
    self.FenRunNumLab.textColor = [UIColor redColor];
    [self.contentView addSubview:self.FenRunNumLab];
    
    self.SaleAmountLab = [[UILabel alloc] init];
    self.SaleAmountLab.textColor = ColorLightText;
    self.SaleAmountLab.text = @"交易量";
    self.SaleAmountLab.font = [UIFont systemFontOfSize:13];
    self.SaleAmountLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.SaleAmountLab];
    
    self.SaleAmountNumLab = [[UILabel alloc] init];
    self.SaleAmountNumLab.textColor = ColorLightText;
    self.SaleAmountNumLab.font = [UIFont systemFontOfSize:13];
    self.SaleAmountNumLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.SaleAmountNumLab];
    
    self.TotalFenRunLab = [[UILabel alloc] init];
    self.TotalFenRunLab.font = [UIFont systemFontOfSize:13];
    self.TotalFenRunLab.textColor =ColorLightText;
    self.TotalFenRunLab.text = @"累计分润";
    self.TotalFenRunLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.TotalFenRunLab];
    
    self.TotalFenRunNumLab = [[UILabel alloc] init];
    self.TotalFenRunNumLab.font = [UIFont systemFontOfSize:13];
    self.TotalFenRunNumLab.textColor = ColorLightText;
    self.TotalFenRunNumLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.TotalFenRunNumLab];
    
    self.BottomLine = [[UIImageView alloc] init];
    self.BottomLine.backgroundColor = ColorLineSeperate;
    [self.contentView addSubview:self.BottomLine];
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.FenRunLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    [self.FenRunNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.FenRunLab);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:15]));
        
    }];
    
    [self.SaleAmountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.FenRunLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    [self.SaleAmountNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.SaleAmountLab);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:15]));
    }];
    
    [self.TotalFenRunLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-[JNSHAutoSize height:10]);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    [self.TotalFenRunNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.TotalFenRunLab);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:15]));
    }];
    
    [self.BottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
}


@end
