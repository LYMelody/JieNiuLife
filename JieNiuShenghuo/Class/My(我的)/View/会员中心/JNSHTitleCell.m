//
//  JNSHTitleCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHTitleCell.h"
#import "Masonry.h"
@implementation JNSHTitleCell


- (instancetype)init {
    
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
    
}


- (void)setUpViews {
    
    _leftLab = [[UILabel alloc] init];
    _leftLab.font = [UIFont systemFontOfSize:15];
    _leftLab.textColor = ColorText;
    _leftLab.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:_leftLab];
    
    _rightLab = [[UILabel alloc] init];
    _rightLab.textColor = ColorLightText;
    _rightLab.font = [UIFont systemFontOfSize:14];
    _rightLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_rightLab];
    
    
    _bottomLine = [[UIImageView alloc] init];
    _bottomLine.backgroundColor = ColorLineSeperate;
    
    [self.contentView addSubview:_bottomLine];
    
    
}


- (void)layoutSubviews {
    
    
    [super layoutSubviews];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:90], [JNSHAutoSize height:20]));
    }];
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_leftLab.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:180], [JNSHAutoSize height:20]));
    }];
    
    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.height.mas_equalTo([JNSHAutoSize height:SeperateLineWidth]);
    }];
    
}

@end
