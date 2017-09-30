//
//  JNSHMyCommonCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/4.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHMyCommonCell.h"
#import "Masonry.h"
@implementation JNSHMyCommonCell

- (instancetype)init {
    
    
    if ([super init]) {
        
        _showBottomLine = NO;
        _showTopLine = NO;
        
        [self setUpViews];
    }
    
    
    return self;
    
}


- (void)setUpViews {
    
    _titleImage = [[UIImageView alloc] init];
    _titleImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_titleImage];
    
    _titleLab = [[UILabel alloc] init];
    _titleLab.font = [UIFont systemFontOfSize:14];
    _titleLab.textColor = ColorText;
    _titleLab.textAlignment = NSTextAlignmentLeft;
    
    [self addSubview:_titleLab];
    
    _rightLab = [[UILabel alloc] init];
    _rightLab.font = [UIFont systemFontOfSize:12];
    _rightLab.textAlignment = NSTextAlignmentRight;
    _rightLab.textColor = ColorLightText;
    
    [self addSubview:_rightLab];
    
    _topLineView = [[UIImageView alloc] init];
    _topLineView.backgroundColor = ColorLineSeperate;
    _topLineView.hidden = YES;
    [self addSubview:_topLineView];
    
    _bottomLineView = [[UIImageView alloc] init];
    _bottomLineView.backgroundColor = ColorLineSeperate;
    
    [self addSubview:_bottomLineView];
    
    
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-2);
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(0);
        make.left.equalTo(_titleImage.mas_right).offset(13);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        if ([_rightLab.text isEqualToString:@"400-101-8258"]) { //如果是客服电话则向右移400-101-8258
             make.right.equalTo(self).offset(-16);
        }else {
            make.right.equalTo(self).offset(-32);
        }
        
    }];
    
    
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        if (_showBottomLine) {
            make.left.equalTo(self);
            
        }else {
            make.left.equalTo(self).offset(16);
        }
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
}

- (void)setShowTopLine:(BOOL)showTopLine {
    
    _showTopLine = showTopLine;
    
    if (showTopLine) {
        _topLineView.hidden = NO;
    }else {
        _topLineView.hidden = YES;
    }
    
    
}

- (void)setShowBottomLine:(BOOL)showBottomLine {
    
    _showBottomLine = showBottomLine;
    
    [self layoutSubviews];
    
}


@end
