//
//  JNSHBrandCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/11.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHBrandCell.h"
#import "Masonry.h"

@implementation JNSHBrandCell

- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
    
}

- (void)setUpViews{
    
    self.backgroundColor = ColorTableBackColor;
    
    _leftLab = [[UILabel alloc] init];
    _leftLab.font = [UIFont systemFontOfSize:15];
    _leftLab.textColor = ColorText;
    _leftLab.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:_leftLab];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake((KscreenWidth - [JNSHAutoSize width:20]), [JNSHAutoSize height:20]));
    }];
    
}


@end
