//
//  JNSHOrderDisCountCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHOrderDisCountCell.h"
#import "Masonry.h"


@implementation JNSHOrderDisCountCell


- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
    
}


- (void)setUpViews{
    
    self.leftLab = [[UILabel alloc] init];
    self.leftLab.font = [UIFont systemFontOfSize:12];
    self.leftLab.textColor = ColorLightText;
    self.leftLab.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:self.leftLab];
    
    self.rightLab = [[UILabel alloc] init];
    self.rightLab.font = [UIFont systemFontOfSize:12];
    self.rightLab.textAlignment = NSTextAlignmentLeft;
    self.rightLab.textColor = ColorLightText;
    
    [self.contentView addSubview:self.rightLab];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setTitle:@"立即续费" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightBtn setBackgroundColor:ColorTabBarBackColor];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    self.rightBtn.layer.cornerRadius = 2;
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.hidden = YES;
    [self.rightBtn addTarget:self action:@selector(charge) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:self.rightBtn];
    
    self.bottomLine = [[UIImageView alloc] init];
    self.bottomLine.backgroundColor = ColorLineSeperate;
    self.bottomLine.hidden = YES;
    [self.contentView addSubview:self.bottomLine];
    
}

//立即续费
- (void)charge {
    
    NSLog(@"续费");
    
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.equalTo(self);
        make.width.mas_equalTo([JNSHAutoSize width:100]);
        make.height.equalTo(self);
    }];
    
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.leftLab.mas_right).offset([JNSHAutoSize width:18]);
        make.height.equalTo(self);
        make.width.mas_equalTo([JNSHAutoSize width:200]);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:66], [JNSHAutoSize height:21]));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    
}

- (void)setIsShowBottomLine:(BOOL)isShowBottomLine {
    
    _isShowBottomLine = isShowBottomLine;
    
    if (isShowBottomLine) {
        self.bottomLine.hidden = NO;
    }else {
        self.bottomLine.hidden = YES;
    }
    
}

@end
