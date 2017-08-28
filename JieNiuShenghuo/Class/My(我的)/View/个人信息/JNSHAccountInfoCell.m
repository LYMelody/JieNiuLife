//
//  JNSHAccountInfoCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/7.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAccountInfoCell.h"
#import "JNSHCommon.h"
#import "Masonry.h"
@implementation JNSHAccountInfoCell


- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
        
    }
    
    return self;

}



- (void)setUpViews{
    
    _leftLab = [[UILabel alloc] init];
    _leftLab.font = [UIFont systemFontOfSize:15];
    _leftLab.textColor = ColorText;
    _leftLab.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:_leftLab];
    
    _rightLab = [[UILabel alloc] init];
    _rightLab.font = [UIFont systemFontOfSize:14];
    _rightLab.textColor = ColorLightText;
    _rightLab.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_rightLab];
    
    _bottomLineView = [[UIImageView alloc] init];
    _bottomLineView.backgroundColor = ColorLineSeperate;
    [self.contentView addSubview:_bottomLineView];
    
    
}

- (void)layoutSubviews {
    
    
    [super layoutSubviews];
    
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, self.frame.size.height));
    }];
    
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        if ([_leftLab.text isEqualToString:@"出生年月"] || [_leftLab.text isEqualToString:@"当前版本"]) {
            make.right.equalTo(self).offset(-15);
        }else {
            make.right.equalTo(self).offset(-32);
        }
        
        make.size.mas_equalTo(CGSizeMake(100, self.frame.size.height));
    }];
    
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(SeperateLineWidth);
        
        if (_isLast) {
            make.left.equalTo(self);
        }else {
            make.left.equalTo(self).offset(15);
        }
    }];
    
    
}


- (void)setIsLast:(BOOL)isLast {
    
    _isLast = isLast;
    
    [self layoutSubviews];
    
}

@end
