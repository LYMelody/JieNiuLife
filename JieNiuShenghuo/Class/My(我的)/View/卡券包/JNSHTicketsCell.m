//
//  JNSHTicketsCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/17.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHTicketsCell.h"
#import "Masonry.h"

@interface JNSHTicketsCell()

@property(nonatomic,strong)UIImageView *backImg;

@property(nonatomic,strong)UIImageView *leftImg;



@property(nonatomic,strong)UIButton *useBtn;

@property(nonatomic,strong)UIImageView *usedImg;


@end

@implementation JNSHTicketsCell


- (instancetype)init {
    
    if ([super init]) {
        
        _isUsed = NO;
        
        [self setUpViews];
    }
    
    return self;
    
}



- (void)setUpViews{
    
    
    self.backgroundColor = ColorTableBackColor;
    
    self.backImg = [[UIImageView alloc] init];
    self.backImg.backgroundColor = [UIColor whiteColor];
    self.backImg.userInteractionEnabled = YES;
    [self.contentView addSubview:self.backImg];
    
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.bottom.equalTo(self);
    }];
    
    self.leftImg = [[UIImageView alloc] init];
    self.leftImg.image = [UIImage imageNamed:@"coupon"];
    [self.backImg addSubview:self.leftImg];
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(self.backImg);
        make.width.mas_equalTo([JNSHAutoSize width:96]);
        
    }];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textColor = ColorText;
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.text = @"刷卡抵用券";
    [self.backImg addSubview:self.titleLab];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImg).offset([JNSHAutoSize height:15]);
        make.left.equalTo(self.leftImg.mas_right).offset([JNSHAutoSize width:20]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:120], [JNSHAutoSize height:15]));
    }];
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = [UIFont systemFontOfSize:12];
    self.timeLab.textColor = ColorLightText;
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    self.timeLab.text = @"有效期至 2017-09-31";
    [self.backImg addSubview:self.timeLab];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.bottom.equalTo(self.backImg).offset(-[JNSHAutoSize height:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:160], [JNSHAutoSize height:15]));
    }];
    
    self.useBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.useBtn setTitle:@"立即使用" forState:UIControlStateNormal];
    [self.useBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.useBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.useBtn.backgroundColor = BlueColor;
    self.useBtn.layer.cornerRadius = 2;
    self.useBtn.layer.masksToBounds = YES;
    [self.useBtn addTarget:self action:@selector(use) forControlEvents:UIControlEventTouchUpInside];
    [self.backImg addSubview:self.useBtn];
    
    [self.useBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab);
        make.right.equalTo(self.backImg).offset(-[JNSHAutoSize width:20]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:68], [JNSHAutoSize height:25]));
    }];
    
    self.usedImg = [[UIImageView alloc] init];
    self.usedImg.image = [UIImage imageNamed:@"coupon_used"];
    self.usedImg.hidden = YES;
    [self.backImg addSubview:self.usedImg];
    
    [self.usedImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backImg);
        make.right.equalTo(self.backImg).offset(-[JNSHAutoSize height:77]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:45], [JNSHAutoSize height:45]));
    }];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];

}

- (void)setIsUsed:(BOOL)isUsed {
    
    _isUsed = isUsed;
    
    if (isUsed) {
        self.leftImg.image = [UIImage imageNamed:@"coupon_grey"];
        self.usedImg.hidden = NO;
        
        self.useBtn.backgroundColor = [UIColor grayColor];
        
        self.useBtn.alpha = 0.5;
        
        self.useBtn.enabled = NO;
    }
}

- (void)setIsUpDate:(BOOL)isUpDate {
    
    _isUpDate = isUpDate;
    
    if (isUpDate) {
        self.leftImg.image = [UIImage imageNamed:@"coupon_grey"];
        self.usedImg.image = [UIImage imageNamed:@"coupon_expired"];
        self.usedImg.hidden = NO;
        
        self.useBtn.backgroundColor = [UIColor grayColor];
        
        self.useBtn.alpha = 0.5;
        
        self.useBtn.enabled = NO;
    }
    
}
//点击使用
- (void)use {
    
    if (self.useBlock) {
        self.useBlock();
    }
    
    
}



@end
