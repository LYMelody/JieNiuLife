//
//  JNSHBankSelectCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHBankSelectCell.h"
#import "Masonry.h"

@implementation JNSHBankSelectCell

- (instancetype)init {
    
    if ([super init]) {
        [self setUpViews];
        
    }
    
    return self;
    
}


- (void)setUpViews{
    
    
    _bankLogoImg = [[UIImageView alloc] init];
    _bankLogoImg.image = [UIImage imageNamed:@"payment_bank_logo"];
    [self.contentView addSubview:_bankLogoImg];
    
    _bankNameLab = [[UILabel alloc] init];
    _bankNameLab.text = @"中信银行";
    _bankNameLab.font = [UIFont systemFontOfSize:15];
    _bankNameLab.textColor = ColorText;
    _bankNameLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_bankNameLab];
    
    _bankCardLab = [[UILabel alloc] init];
    _bankCardLab.text = @"信用卡   4033********1234";
    _bankCardLab.font = [UIFont systemFontOfSize:11];
    _bankCardLab.textColor = ColorLightText;
    _bankCardLab.textAlignment = NSTextAlignmentLeft;
   
    
    if (self.tag == 2) {   //银行卡不需要卡号
        
        
    }else {                //付款方式需要卡号
         [self.contentView addSubview:_bankCardLab];
    }
    
    
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectBtn setImage:[UIImage imageNamed:@"payment_btn_nor"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"payment_btn_sel"] forState:UIControlStateSelected];
    
    [_selectBtn addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_selectBtn];
    
}


- (void)selectAction {
    
    if (self.cardSelectBlock) {
        self.cardSelectBlock();
    }
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_bankLogoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset([JNSHAutoSize width:14]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:26], [JNSHAutoSize height:26]));
    }];
    
    if (self.tag == 2) {
        
        [_bankNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_bankLogoImg.mas_right).offset([JNSHAutoSize width:13]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:180], [JNSHAutoSize height:20]));
        }];
        
        
    }else {
        
        [_bankNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset([JNSHAutoSize height:10]);
            make.left.equalTo(_bankLogoImg.mas_right).offset([JNSHAutoSize width:13]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:180], [JNSHAutoSize height:20]));
        }];
        
        [_bankCardLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bankNameLab.mas_bottom).offset([JNSHAutoSize height:1]);
            make.left.equalTo(_bankNameLab);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:220], [JNSHAutoSize height:15]));
        }];
    }
    
    
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-[JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:18], [JNSHAutoSize height:18]));
    }];
    
}

@end
