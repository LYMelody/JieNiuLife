//
//  JNSHImgUploadCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/11.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHImgUploadCell.h"
#import "Masonry.h"
@implementation JNSHImgUploadCell

- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
    
}

- (void)setUpViews{
    
    _leftLab = [[UILabel alloc] init];
    _leftLab.font = [UIFont systemFontOfSize:14];
    _leftLab.textColor = ColorText;
    _leftLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_leftLab];
    
    _rightLab = [[UILabel alloc] init];
    _rightLab.font = [UIFont systemFontOfSize:14];
    _rightLab.textColor = ColorText;
    _rightLab.textAlignment = NSTextAlignmentLeft;
    _rightLab.text = @"示例";
    [self.contentView addSubview:_rightLab];
    
    _leftImg = [[UIImageView alloc] init];
    _leftImg.image = [UIImage imageNamed:@"ID-card_upload"];
    _leftImg.layer.cornerRadius = 3;
    _leftImg.layer.masksToBounds = YES;
    _leftImg.userInteractionEnabled = YES;
    [self.contentView addSubview:_leftImg];
    
    _rightImg = [[UIImageView alloc] init];
    _rightImg.backgroundColor = ColorTableBackColor;
    _rightImg.layer.cornerRadius = 3;
    _rightImg.layer.masksToBounds = YES;
    //_rightImg.userInteractionEnabled = YES;
    [self.contentView addSubview:_rightImg];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.numberOfTapsRequired = 1;
    
    [_leftImg addGestureRecognizer:tap];
    
    
    
}


- (void)layoutSubviews {
    
    
    [super layoutSubviews];
    
    [_leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:15]);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:150], [JNSHAutoSize height:15]));
    }];
    
    [_rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:15]);
        make.left.equalTo(self).offset(KscreenWidth/2.0);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:150], [JNSHAutoSize height:15]));
    }];
    
    [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftLab.mas_bottom).offset([JNSHAutoSize height:7]);
        make.left.equalTo(_leftLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:150], [JNSHAutoSize height:95]));
    }];
    
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImg);
        make.left.equalTo(_rightLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:150], [JNSHAutoSize height:95]));
    }];
}

//点击图片
- (void)tap {
    
    if (self.uploadImgBlock) {
        self.uploadImgBlock();
    }
    
}

@end
