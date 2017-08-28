//
//  JNSHSexCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/7.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSexCell.h"
#import "Masonry.h"
@implementation JNSHSexCell

- (instancetype)init {
    
    if ([super init]) {
        
        _showTopLine = NO;
        _isLast = NO;
        
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews{
    
    _leftLab = [[UILabel alloc] init];
    _leftLab.font = [UIFont systemFontOfSize:15];
    _leftLab.textColor = [UIColor blackColor];
    _leftLab.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView  addSubview:_leftLab];
    
    _topLineView = [[UIImageView alloc] init];
    _topLineView.backgroundColor = ColorLineSeperate;
    _topLineView.hidden = YES;
    [self.contentView addSubview:_topLineView];
    
    _bottomLineView = [[UIImageView alloc] init];
    _bottomLineView.backgroundColor = ColorLineSeperate;
    
    [self.contentView addSubview:_bottomLineView];
    
}



- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.width.mas_equalTo(120);
        make.height.equalTo(self);
    }];
    
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
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

- (void)setShowTopLine:(BOOL)showTopLine {
    
    _showTopLine = showTopLine;
    
    if (showTopLine) {
        
        _topLineView.hidden = NO;
    }else {
        _topLineView.hidden = YES;
    }
    
    
}

@end
