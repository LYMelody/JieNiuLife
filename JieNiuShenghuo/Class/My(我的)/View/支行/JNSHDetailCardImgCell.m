//
//  JNSHDetailCardImgCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHDetailCardImgCell.h"
#import "Masonry.h"
@implementation JNSHDetailCardImgCell


- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
    
}


- (void)setUpViews {
    
    _cardImg = [[UIImageView alloc] init];
    _cardImg.backgroundColor = ColorTableBackColor;
    _cardImg.layer.cornerRadius = 3;
    _cardImg.layer.masksToBounds = YES;
    [self.contentView addSubview:_cardImg];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_cardImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake([JNSHAutoSize height:15], [JNSHAutoSize width:15], [JNSHAutoSize height:15], [JNSHAutoSize width:15]));
    }];
    
    
}


@end
