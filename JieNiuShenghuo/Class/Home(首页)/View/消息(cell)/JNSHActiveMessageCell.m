//
//  JNSHActiveMessageCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/20.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHActiveMessageCell.h"
#import "Masonry.h"
#import "JNSYHighLightImageView.h"
@interface JNSHActiveMessageCell()

@property(nonatomic,strong)JNSYHighLightImageView *backImg;

@property(nonatomic,strong)UIImageView *midLineImg;

@property(nonatomic,strong)UILabel *detailLab;

@property(nonatomic,strong)UIImageView *rightArrawImg;

@end


@implementation JNSHActiveMessageCell

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
    self.timeLab.text = @"2017-9-21";
    [self.contentView addSubview:self.timeLab];
    
    self.backImg = [[JNSYHighLightImageView alloc] init];
    self.backImg.backgroundColor = [UIColor whiteColor];
    self.backImg.layer.cornerRadius = 3;
    self.backImg.layer.masksToBounds = YES;
    self.backImg.userInteractionEnabled = YES;
    self.backImg.contentMode = UIViewContentModeTop;
    self.backImg.clipsToBounds = YES;
    [self.contentView addSubview:self.backImg];
    
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    tap.numberOfTapsRequired = 1;
    
    [self.backImg addGestureRecognizer:tap];
    
    self.titleLab = [[UILabel alloc] init];
    self.titleLab.font = [UIFont systemFontOfSize:15];
    self.titleLab.textAlignment = NSTextAlignmentLeft;
    self.titleLab.textColor = ColorText;
    self.titleLab.text = @"系统升级通知";
    [self.backImg addSubview:self.titleLab];
    
    self.titleImg = [[UIImageView alloc] init];
    self.titleImg.backgroundColor = ColorTableBackColor;
    self.titleImg.contentMode = UIViewContentModeScaleAspectFill;
    self.titleImg.clipsToBounds = YES;
    
    [self.backImg addSubview:self.titleImg];
    
    self.midLineImg = [[UIImageView alloc] init];
    self.midLineImg.backgroundColor = ColorLineSeperate;
    
    [self.backImg addSubview:self.midLineImg];
    
    self.detailLab = [[UILabel alloc] init];
    self.detailLab.font = [UIFont systemFontOfSize:14];
    self.detailLab.textAlignment = NSTextAlignmentLeft;
    self.detailLab.textColor = ColorText;
    self.detailLab.text = @"查看详情";
    [self.backImg addSubview:self.detailLab];
    
    self.contentLab = [[UILabel alloc] init];
    self.contentLab.font = [UIFont systemFontOfSize:13];
    self.contentLab.textAlignment = NSTextAlignmentLeft;
    self.contentLab.textColor = ColorText;
    self.contentLab.text = @"提供优质服务";
    [self.backImg addSubview:self.contentLab];
    
    self.rightArrawImg = [[UIImageView alloc] init];
    self.rightArrawImg.image = [UIImage imageNamed:@"my_arror_right"];
    [self.backImg addSubview:self.rightArrawImg];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:15]);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:140], [JNSHAutoSize height:21]));
    }];
    
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLab.mas_bottom).offset([JNSHAutoSize height:13]);
        make.left.equalTo(self).offset([JNSHAutoSize width:15]);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:221]);
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backImg).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.backImg).offset([JNSHAutoSize width:9]);
        make.right.equalTo(self.backImg).offset(-[JNSHAutoSize width:9]);
    }];
    
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.backImg).offset([JNSHAutoSize width:9]);
        make.right.equalTo(self.backImg).offset(-[JNSHAutoSize width:9]);
        make.height.mas_equalTo([JNSHAutoSize height:116]);
    }];
    
    [self.midLineImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backImg.mas_bottom).offset(-[JNSHAutoSize height:30]);
        make.left.right.equalTo(self.backImg);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.midLineImg).offset([JNSHAutoSize height:7]);
        make.left.equalTo(self.titleLab);
        make.size.equalTo(self.contentLab);
    }];

    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImg.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.titleLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:KscreenWidth - 50], [JNSHAutoSize height:15]));
    }];
    
    [self.rightArrawImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLab);
        make.right.equalTo(self.titleImg);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:9], [JNSHAutoSize height:15]));
    }];
    
    
}

- (void)tapAction{
    
    if (self.messageTapBlock) {
        self.messageTapBlock();
    }
    
    
}


@end
