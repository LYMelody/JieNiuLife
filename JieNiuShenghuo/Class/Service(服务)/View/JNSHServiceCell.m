//
//  JNSHServiceCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/14.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHServiceCell.h"
#import "Masonry.h"

@implementation JNSHServiceCell

- (instancetype)init {
    
    if(self = [super init]) {
        
        [self setUpViews];
        
        
    }
    
    return self;
    
}


- (void)setUpViews{
    
    self.leftImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.leftImg];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textColor = ColorText;
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLab];
    
    self.subTitleLab = [[UILabel alloc] init];
    self.subTitleLab.font = [UIFont systemFontOfSize:12];
    self.subTitleLab.textAlignment = NSTextAlignmentLeft;
    self.subTitleLab.textColor = ColorLightText;
    [self.contentView addSubview:self.subTitleLab];
    
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:35], [JNSHAutoSize width:35]));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImg);
        make.left.equalTo(self.leftImg.mas_right).offset([JNSHAutoSize width:27]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:20]));
    }];
    
    [self.subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset([JNSHAutoSize height:5]);
        make.left.equalTo(self.titleLab);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:15]));
    }];
}


@end
