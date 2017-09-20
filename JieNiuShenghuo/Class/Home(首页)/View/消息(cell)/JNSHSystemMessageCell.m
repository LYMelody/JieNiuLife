//
//  JNSHSystemMessageCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/6.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSystemMessageCell.h"
#import "Masonry.h"

@interface JNSHSystemMessageCell()

@property(nonatomic,strong)UIImageView *backImg;


@property(nonatomic,strong)UILabel *messageLab;


@end


@implementation JNSHSystemMessageCell

- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
    
}

- (void)setUpViews{
    
    self.backgroundColor = ColorTableBackColor;
    
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
    self.backImg.layer.cornerRadius = 2;
    self.backImg.layer.masksToBounds = YES;
    [self.contentView addSubview:self.backImg];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textColor = ColorText;
    self.titleLab.text = @"系统升级通知:";
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    [self.backImg addSubview:self.titleLab];
    
    self.messageLab = [[UILabel alloc] init];
    self.messageLab.font = [UIFont systemFontOfSize:13];
    self.messageLab.textAlignment = NSTextAlignmentLeft;
    self.messageLab.textColor = ColorLightText;
    self.messageLab.numberOfLines = 0;
    [self.backImg addSubview:self.messageLab];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:15]);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:140], [JNSHAutoSize height:21]));
    }];
    
    float height = [self heightForString:_message andWidth:(KscreenWidth - [JNSHAutoSize width:50])];
    
    if (height > 76) {
        
        height = height + 24;
        
    }else {
        height = 100;
    }
    
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab.mas_bottom).offset([JNSHAutoSize height:13]);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:height]);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImg).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.backImg).offset([JNSHAutoSize width:9]);
        make.right.equalTo(self.backImg).offset(-[JNSHAutoSize width:9]);
    }];
    
    [self.messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.titleLab);
        make.right.equalTo(self.backImg).offset(-[JNSHAutoSize width:9]);
        make.bottom.equalTo(self.backImg).offset(-[JNSHAutoSize height:14]);
        
    }];
    
}

- (void)setMessage:(NSString *)message {
    
    _message = message;
    
    self.messageLab.text = message;

    [self layoutIfNeeded];
    
}

- (float)heightForString:(NSString *)value andWidth:(float)width {
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    CGSize sietofit = [value boundingRectWithSize:CGSizeMake(width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return sietofit.height + 16 + 40;
    
    
}


@end
