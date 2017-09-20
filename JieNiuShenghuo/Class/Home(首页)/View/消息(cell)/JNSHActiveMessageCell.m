//
//  JNSHActiveMessageCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/20.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHActiveMessageCell.h"
#import "Masonry.h"

@interface JNSHActiveMessageCell()

@property(nonatomic,strong)UIImageView *backImg;

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UIImageView *midLineImg;

@property(nonatomic,strong)UILabel *detailLab;


@end


@implementation JNSHActiveMessageCell

- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
    
}



- (void)setUpViews{
    
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = [UIFont systemFontOfSize:12];
    self.timeLab.textColor = [UIColor whiteColor];
    self.timeLab.textAlignment = NSTextAlignmentCenter;
    self.timeLab.backgroundColor = linebackColor;
    self.timeLab.layer.cornerRadius = 2;
    self.timeLab.layer.masksToBounds = YES;
    [self.contentView addSubview:self.timeLab];
    
    self.backImg = [[UIImageView alloc] init];
    self.backImg.backgroundColor = [UIColor whiteColor];
    self.backImg.layer.cornerRadius = 3;
    self.backImg.layer.masksToBounds = YES;
    self.backImg.userInteractionEnabled = YES;
    [self.contentView addSubview:self.backImg];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.textColor = ColorText;
    [self.backImg addSubview:self.titleLab];
    
    self.titleImg = [[UIImageView alloc] init];
    [self.backImg addSubview:self.titleImg];
    
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = [UIFont systemFontOfSize:13];
    self.contentLab.textAlignment = NSTextAlignmentLeft;
    self.contentLab.textColor = ColorText;
    [self.backImg addSubview:self.contentLab];
    
    self.midLineImg = [[UIImageView alloc] init];
    self.midLineImg.backgroundColor = [UIColor lightGrayColor];
    [self.backImg addSubview:self.midLineImg];
    
    self.detailLab = [[UILabel alloc] init];
    self.detailLab.font = [UIFont systemFontOfSize:14];
    self.detailLab.textAlignment = NSTextAlignmentLeft;
    self.detailLab.textColor = ColorText;
    [self.backImg addSubview:self.detailLab];
    
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:15]);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:140], [JNSHAutoSize height:21]));
    }];
    
    
    
    
    
    
}




@end
