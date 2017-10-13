//
//  JNSHAgentmsgCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/10/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAgentmsgCell.h"
#import "Masonry.h"

@implementation JNSHAgentmsgCell {
    
    UIImageView *redPointImg;
    
    
}


- (instancetype)init {
    
    if (self = [super init]) {
        
        [self setUpViews];
        
    }
    
    return self;
    
}

- (void)setUpViews{
    
    self.headimg = [[UIImageView alloc] init];
    self.headimg.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.headimg];
    
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textColor = ColorText;
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLab];
    
    self.timeLab = [[UILabel alloc] init];
    self.timeLab.font = [UIFont systemFontOfSize:10];
    self.timeLab.textColor = ColorLightText;
    self.timeLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.timeLab];
    
    redPointImg = [[UIImageView alloc] init];
    redPointImg.backgroundColor = [UIColor redColor];
    redPointImg.layer.cornerRadius = 4;
    redPointImg.layer.masksToBounds = YES;
    [_headimg addSubview:redPointImg];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.headimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:30], [JNSHAutoSize height:30]));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.headimg.mas_right).offset([JNSHAutoSize width:12]);
        make.right.height.equalTo(self);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab).offset([JNSHAutoSize height:5]);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:160], [JNSHAutoSize height:10]));
    }];
    
    [redPointImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headimg.mas_right).offset([JNSHAutoSize width:0]);
        make.centerY.equalTo(self.headimg.mas_top).offset([JNSHAutoSize height:0]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:8], [JNSHAutoSize width:8]));
    }];
    
}

- (void)setIsRead:(BOOL)isRead {
    
    _isRead = isRead;
    
    if (isRead) {
        redPointImg.hidden = YES;
    }else {
        redPointImg.hidden = NO;
    }
    
}


@end
