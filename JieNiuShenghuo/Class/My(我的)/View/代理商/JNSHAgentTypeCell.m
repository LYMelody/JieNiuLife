//
//  JNSHAgentTypeCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/10/13.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAgentTypeCell.h"
#import "Masonry.h"

@implementation JNSHAgentTypeCell {
    
    UIImageView *ModelOneImg;
    UIImageView *ModelTwoImg;
    UIImageView *ModelThreeImg;
    UILabel *bottomLab;
}


- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
    
    
}

- (void)setUpViews{
    
    ModelOneImg = [[UIImageView alloc] init];
    ModelOneImg.image = [UIImage imageNamed:@"medal"];
    ModelOneImg.hidden = YES;
    [self.contentView addSubview:ModelOneImg];
    
    ModelTwoImg = [[UIImageView alloc] init];
    ModelTwoImg.image = [UIImage imageNamed:@"medal"];
    ModelTwoImg.hidden = YES;
    [self.contentView addSubview:ModelTwoImg];
    
    ModelThreeImg = [[UIImageView alloc] init];
    ModelThreeImg.image = [UIImage imageNamed:@"medal"];
    ModelThreeImg.hidden = YES;
    [self.contentView addSubview:ModelThreeImg];
    
    bottomLab = [[UILabel alloc] init];
    bottomLab.textColor = ColorText;
    bottomLab.font = [UIFont systemFontOfSize:15];
    bottomLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:bottomLab];
    
    [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-[JNSHAutoSize height:17]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:15]));
    }];
    
    
}

- (void)setOrgType:(NSString *)orgType {
    
    _orgType = orgType;
    
    if ([orgType isEqualToString:@"L32"]) { //特约代理
        ModelOneImg.hidden = NO;
        [ModelOneImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset([JNSHAutoSize height:30]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:26]));
        }];
        bottomLab.text = @"代理级别：特约代理";
    }else if ([orgType isEqualToString:@"L31"]) { //一级代理
        ModelTwoImg.hidden = NO;
        ModelOneImg.hidden = NO;
        
        [ModelOneImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset([JNSHAutoSize height:30]);
            make.centerX.equalTo(self).offset(-[JNSHAutoSize width:18]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:26]));
        }];
        
        [ModelTwoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset([JNSHAutoSize height:30]);
            make.centerX.equalTo(self).offset([JNSHAutoSize width:18]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:26]));
        }];
        bottomLab.text = @"代理级别：一级代理";
    }else if ([orgType isEqualToString:@"L30"]) { //办事处
        
        ModelOneImg.hidden = NO;
        ModelTwoImg.hidden = NO;
        ModelThreeImg.hidden = NO;
        [ModelOneImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset([JNSHAutoSize height:30]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:26]));
        }];
        
        [ModelTwoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ModelOneImg);
            make.right.equalTo(ModelOneImg.mas_left).offset(-[JNSHAutoSize width:17]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:26]));
        }];
        
        [ModelThreeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ModelOneImg);
            make.left.equalTo(ModelOneImg.mas_right).offset([JNSHAutoSize width:17]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:26]));
        }];
        bottomLab.text = @"代理级别：办事处";
    }
}


@end
