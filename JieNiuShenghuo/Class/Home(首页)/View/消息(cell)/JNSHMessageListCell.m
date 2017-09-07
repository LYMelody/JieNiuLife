//
//  JNSHMessageListCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/6.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHMessageListCell.h"
#import "Masonry.h"

@interface JNSHMessageListCell()

@property(nonatomic,strong)UIView *bottomLineView;

@end


@implementation JNSHMessageListCell

- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews{
    
    self.leftImg = [[UIImageView alloc] init];
    self.leftImg.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:self.leftImg];
    
    self.countLab = [[UILabel alloc] init];
    self.countLab.backgroundColor = [UIColor redColor];
    self.countLab.textAlignment = NSTextAlignmentCenter;
    self.countLab.textColor = [UIColor whiteColor];
    self.countLab.font = [UIFont systemFontOfSize:10];
    self.countLab.layer.cornerRadius = 7.5;
    self.countLab.layer.masksToBounds = YES;
    self.countLab.hidden = YES;
    [self.contentView addSubview:self.countLab];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:14];
    self.titleLab.textColor = ColorText;
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLab];
    
    self.messageLab = [[UILabel alloc] init];
    self.messageLab.textColor = ColorLightText;
    self.messageLab.font = [UIFont systemFontOfSize:11];
    self.messageLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.messageLab];
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = [UIFont systemFontOfSize:10];
    self.timeLab.textAlignment = NSTextAlignmentRight;
    self.timeLab.textColor = ColorLightText;
    [self.contentView addSubview:self.timeLab];
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = ColorLineSeperate;
    [self.contentView addSubview:self.bottomLineView];
    
    
    
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:30], [JNSHAutoSize height:30]));
    }];
    
    [self.countLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftImg.mas_top).offset([JNSHAutoSize height:0]);
        make.centerX.equalTo(self.leftImg.mas_right).offset(-[JNSHAutoSize width:0]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:15], [JNSHAutoSize height:15]));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.leftImg.mas_right).offset([JNSHAutoSize width:12]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:15]));
    }];
    
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset([JNSHAutoSize height:5]);
        make.left.equalTo(self.titleLab);
        make.size.equalTo(self.titleLab);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:10]));
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:SeperateLineWidth]);
    }];
    
    
}

- (void)setIsBottom:(BOOL)isBottom {
    
    _isBottom = isBottom;
    if (isBottom) {
        self.bottomLineView.hidden = YES;
    }else {
        self.bottomLineView.hidden = NO;
    }
    
    
}

- (void)setBadge:(NSInteger)badge {
    
    _badge = badge;
    
    
    if(badge == 0) {
        self.countLab.hidden = YES;
    }else {
        self.countLab.hidden = NO;
         self.countLab.text = [NSString stringWithFormat:@"%ld",badge];
    }
    
}

@end
