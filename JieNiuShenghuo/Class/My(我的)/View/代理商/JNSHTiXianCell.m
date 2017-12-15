//
//  JNSHTiXianCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/12/13.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHTiXianCell.h"
#import "Masonry.h"

@implementation JNSHTiXianCell

- (instancetype)init {
    
    if (self = [super init]) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    
    self.leftLab = [[UILabel alloc] init];
    self.leftLab.font = [UIFont systemFontOfSize:14];
    self.leftLab.textColor = ColorText;
    self.leftLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.leftLab];
    
    self.rightLab = [[UILabel alloc] init];
    self.rightLab.font = [UIFont systemFontOfSize:14];
    self.rightLab.textAlignment = NSTextAlignmentLeft;
    self.rightLab.textColor = ColorText;
    [self.contentView addSubview:self.rightLab];
    
    self.bottomLine = [[UIImageView alloc] init];
    self.bottomLine.backgroundColor = ColorLineSeperate;
    [self.contentView addSubview:self.bottomLine];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(KscreenWidth/2.0);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth/2, [JNSHAutoSize height:15]));
    }];
    
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.rightLab.mas_left).offset(-[JNSHAutoSize width:10]);
        make.size.equalTo(self.rightLab);
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:100]);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:100]);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    

    
}



@end
