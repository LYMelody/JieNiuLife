//
//  JNSHOrderStatusCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHOrderStatusCell.h"
#import "Masonry.h"
@implementation JNSHOrderStatusCell

- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
}


- (void)setUpViews{
    
    _centerLab = [[UILabel alloc] init];
    _centerLab.font = [UIFont systemFontOfSize:15];
    _centerLab.textColor = ColorText;
    _centerLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_centerLab];
    
    _rightImg = [[UIImageView alloc] init];
    _rightImg.image = [UIImage imageNamed:@"order_checkmark"];
    _rightImg.hidden = YES;
    [self.contentView addSubview:_rightImg];
    
    
}

- (void)layoutSubviews {
    
    
    [super layoutSubviews];
    
    [_centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(self);
    }];
    
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:14], [JNSHAutoSize height:12]));
    }];
    
}


@end
