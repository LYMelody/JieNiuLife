//
//  JNSHOrderCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHOrderCell.h"
#import "Masonry.h"
@implementation JNSHOrderCell


- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
    }
    
    return self;
    
}

- (void)setUpViews{
    
    _typeLab = [[UILabel alloc] init];
    _typeLab.font = [UIFont systemFontOfSize:13];
    _typeLab.textColor = ColorText;
    _typeLab.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:_typeLab];
    
    _timeLab = [[UILabel alloc] init];
    _timeLab.font = [UIFont systemFontOfSize:12];
    _timeLab.textColor = ColorLightText;
    _timeLab.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:_timeLab];
    
    _moneyLab = [[UILabel alloc] init];
    _moneyLab.font = [UIFont systemFontOfSize:12];
    _moneyLab.textColor = ColorLightText;
    _moneyLab.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:_moneyLab];
    
    _statusLab = [[UILabel alloc] init];
    _statusLab.font = [UIFont systemFontOfSize:12];
    _statusLab.textAlignment = NSTextAlignmentRight;
    _statusLab.textColor = BlueColor;
    
    [self.contentView addSubview:_statusLab];
}

-(void)settype:(NSString *)type time:(NSString *)time money:(NSString *)money status:(NSString *)status {
    
    _typeLab.text = type;
    _timeLab.text = time;
    _moneyLab.text = money;
    _statusLab.text = status;
    
    if ([status isEqualToString:@"初始化"]) {
        _statusLab.textColor = [UIColor orangeColor];
    }else if ([status isEqualToString:@"支付成功"]) {
       _statusLab.textColor = GreenColor;
    }else if ([status isEqualToString:@"支付失败"]) {
        _statusLab.textColor = [UIColor redColor];
    }
    

}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    [_typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.size.mas_offset(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:12]));
    }];
    
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-[JNSHAutoSize height:7]);
        make.left.equalTo(self).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:10]));
    }];
    
    [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_typeLab);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:10]));
    }];
    
    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-[JNSHAutoSize height:7]);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:12]));
    }];
    
}

@end
