//
//  JNSHInvateHistoryCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/18.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHInvateHistoryCell.h"
#import "Masonry.h"

@implementation JNSHInvateHistoryCell


- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews {
    
    self.headerImg = [[UIImageView alloc] init];
    self.headerImg.image = [UIImage imageNamed:@"invite_head_portrait"];
    [self.contentView addSubview:self.headerImg];
    
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:30], [JNSHAutoSize height:30]));
    }];
    
    self.nameLab = [[UILabel alloc] init];
    self.nameLab.font = [UIFont systemFontOfSize:14];
    self.nameLab.textColor = ColorLightText;
    self.nameLab.textAlignment = NSTextAlignmentLeft;
    self.nameLab.text = @"捷牛生活";
    [self.contentView addSubview:self.nameLab];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:12]);
        make.left.equalTo(self.headerImg.mas_right).offset([JNSHAutoSize width:14]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:120], [JNSHAutoSize height:12]));
    }];
    
    self.phoneLab = [[UILabel alloc] init];
    self.phoneLab.font = [UIFont systemFontOfSize:11];
    self.phoneLab.textColor = ColorLightText;
    self.phoneLab.textAlignment = NSTextAlignmentLeft;
    self.phoneLab.text = @"188****8888";
    [self.contentView addSubview:self.phoneLab];
    
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-[JNSHAutoSize height:6]);
        make.left.equalTo(self.nameLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:120], [JNSHAutoSize height:12]));
    }];
    
    self.statusLab = [[UILabel alloc] init];
    self.statusLab.text = @"未完成";
    self.statusLab.font = [UIFont systemFontOfSize:14];
    self.statusLab.textColor = BlueColor;
    self.statusLab.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:self.statusLab];
    
    [self.statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    UIImageView *bottomLine = [[UIImageView alloc] init];
    bottomLine.backgroundColor = ColorLineSeperate;
    [self.contentView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    self.usedImgView = [[UIImageView alloc] init];
    self.usedImgView.image = [UIImage imageNamed:@"coupon_converted"];
    self.usedImgView.hidden = YES;
    [self.contentView addSubview:self.usedImgView];
    
    [self.usedImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:56]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:45], [JNSHAutoSize height:24]));
    }];
    
    
}



- (void)layoutSubviews {
    
    
    
    
}


- (void)setIsUsed:(BOOL)isUsed {
    
    _isUsed = isUsed;
    
    if (isUsed) {
        self.usedImgView.hidden = NO;
    }else {
        self.usedImgView.hidden = YES;
    }
    
    
}




@end
