//
//  JNSHTradeNumCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHTradeNumCell.h"
#import "Masonry.h"

@implementation JNSHTradeNumCell

- (id)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews{
    
    self.topLab = [[UILabel alloc] init];
    self.topLab.font = [UIFont systemFontOfSize:13];
    self.topLab.textColor = ColorText;
    self.topLab.textAlignment = NSTextAlignmentLeft;
    self.topLab.text = @"日交易量";
    [self.contentView addSubview:self.topLab];
    
    self.leftLab = [[UILabel alloc] init];
    self.leftLab.font = [UIFont systemFontOfSize:13];
    self.leftLab.textColor = ColorText;
    self.leftLab.textAlignment = NSTextAlignmentLeft;
    self.leftLab.text = @"累计分润";
    [self.contentView addSubview:self.leftLab];
    
    self.numLab = [[UILabel alloc] init];
    self.numLab.font = [UIFont systemFontOfSize:12];
    self.numLab.textAlignment = NSTextAlignmentRight;
    self.numLab.textColor = ColorLightText;
    self.numLab.text = @"共20笔";
    [self.contentView addSubview:self.numLab];
    
    self.dayNumLab = [[UILabel alloc] init];
    self.dayNumLab.font = [UIFont systemFontOfSize:13];
    self.dayNumLab.textColor = ColorLightText;
    self.dayNumLab.text = @"￥15151.00";
    self.dayNumLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.dayNumLab];
    
    self.totalBenefitLab = [[UILabel alloc] init];
    self.totalBenefitLab.font = [UIFont systemFontOfSize:13];
    self.totalBenefitLab.textAlignment = NSTextAlignmentRight;
    self.totalBenefitLab.textColor = ColorLightText;
    self.totalBenefitLab.text = @"￥123414144.00";
    [self.contentView addSubview:self.totalBenefitLab];

}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:12]);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:15]));
    }];
    
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLab.mas_bottom).offset([JNSHAutoSize height:6]);
        make.left.equalTo(self.topLab);
        make.size.equalTo(self.topLab);
    }];
    
    [self.dayNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topLab);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:120], [JNSHAutoSize height:15]));
    }];
    
    [self.numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dayNumLab.mas_left);
        make.centerY.equalTo(self.dayNumLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:40], [JNSHAutoSize height:15]));
        
    }];
    
    [self.totalBenefitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftLab);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:120], [JNSHAutoSize height:15]));
    }];
    
    
    
    
}


@end
