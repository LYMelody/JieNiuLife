//
//  JNSHGetCodeCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHGetCodeCell.h"
#import "Masonry.h"

@implementation JNSHGetCodeCell

- (instancetype)init {
    
    
    if ([super init]) {
        
        _showBottom = NO;
        
        [self setUpViews];
    }
    
    return self;
}


- (void)setUpViews{
    
    self.leftLab = [[UILabel alloc] init];
    self.leftLab.font = [UIFont systemFontOfSize:14];
    self.leftLab.textColor = ColorText;
    self.leftLab.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:self.leftLab];
    
    self.textFiled = [[UITextField alloc] init];
    self.textFiled.placeholder = @"请输入验证码";
    self.textFiled.font = [UIFont systemFontOfSize:14];
    self.textFiled.textAlignment = NSTextAlignmentLeft;
    self.textFiled.textColor = ColorLightText;
    
    [self.contentView addSubview:self.textFiled];
    
    self.codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.codeBtn setBackgroundColor:ColorTabBarBackColor];
    [self.codeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    self.codeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.codeBtn.layer.cornerRadius = 2;
    self.codeBtn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.codeBtn];
    
    self.bottomLine = [[UIImageView alloc] init];
    self.bottomLine.backgroundColor = ColorLineSeperate;
    self.bottomLine.hidden = YES;
    
    [self.contentView addSubview:self.bottomLine];
    
    
    
    
    
}

//获取验证码
- (void)getCode {
    
    NSLog(@"获取验证码");
    
    if (self.getcodeBlock) {
        self.getcodeBlock();
    }
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:90], [JNSHAutoSize height:20]));
    }];
    
    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.leftLab.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:140], [JNSHAutoSize height:20]));
    }];
    
    [self.codeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:18]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:85], [JNSHAutoSize height:26]));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
}

- (void)setShowBottom:(BOOL)showBottom {
    
    _showBottom = showBottom;
    
    if (showBottom) {
        self.bottomLine.hidden = NO;
    }else {
        self.bottomLine.hidden = YES;
    }
    
}

@end
