//
//  JNSHAgentCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAgentCell.h"
#import "Masonry.h"

@interface JNSHAgentCell()

@property(nonatomic,strong)UILabel *OneLab;

@property(nonatomic,strong)UILabel *TwoLab;

@property(nonatomic,strong)UILabel *ThreeLab;

@property(nonatomic,strong)UILabel *FourLab;

@property(nonatomic,strong)UILabel *FiveLab;

@end


@implementation JNSHAgentCell


- (id)init {
    
    if ([super init]) {
        [self setupViews];
    }
    
    return self;
}


- (void)setupViews{
    
    self.addDalyLab = [[UILabel alloc] init];
    //self.addDalyLab.font = [UIFont systemFontOfSize:15];
    self.addDalyLab.font = [UIFont fontWithName:@"ArialMT" size:15];
    self.addDalyLab.textColor = ColorTabBarBackColor;
    self.addDalyLab.textAlignment = NSTextAlignmentCenter;
    self.addDalyLab.text = @"10";
    [self.contentView addSubview:self.addDalyLab];
    
    _OneLab = [[UILabel alloc] init];
    _OneLab.font = [UIFont systemFontOfSize:13];
    _OneLab.textAlignment = NSTextAlignmentCenter;
    _OneLab.textColor = BlueColor;
    _OneLab.text = @"日新增代理商";
    [self.contentView addSubview:_OneLab];
    
    self.totalAgentLab = [[UILabel alloc] init];
    self.totalAgentLab.font = [UIFont fontWithName:@"ArialMT" size:15];
    self.totalAgentLab.textColor = ColorTabBarBackColor;
    self.totalAgentLab.textAlignment = NSTextAlignmentCenter;
    self.totalAgentLab.text = @"100";
    [self.contentView addSubview:self.totalAgentLab];
    
    _TwoLab = [[UILabel alloc] init];
    _TwoLab.font = [UIFont systemFontOfSize:13];
    _TwoLab.textAlignment = NSTextAlignmentCenter;
    _TwoLab.textColor = BlueColor;
    _TwoLab.text = @"下级代理商";
    [self.contentView addSubview:_TwoLab];
    
    self.legalAgentDalyLab = [[UILabel alloc] init];
    self.legalAgentDalyLab.font = [UIFont fontWithName:@"ArialMT" size:15];
    self.legalAgentDalyLab.textColor = ColorTabBarBackColor;
    self.legalAgentDalyLab.textAlignment = NSTextAlignmentCenter;
    self.legalAgentDalyLab.text = @"10";
    [self.contentView addSubview:self.legalAgentDalyLab];
    
    _ThreeLab = [[UILabel alloc] init];
    _ThreeLab.font = [UIFont systemFontOfSize:13];
    _ThreeLab.textAlignment = NSTextAlignmentCenter;
    _ThreeLab.textColor = BlueColor;
    _ThreeLab.text = @"日审核通过商户";
    [self.contentView addSubview:_ThreeLab];
    
    self.resignDalyLab = [[UILabel alloc] init];
    self.resignDalyLab.font = [UIFont fontWithName:@"ArialMT" size:15];
    self.resignDalyLab.textColor = ColorTabBarBackColor;
    self.resignDalyLab.textAlignment = NSTextAlignmentCenter;
    self.resignDalyLab.text = @"30";
    [self.contentView addSubview:self.resignDalyLab];
    
    _FourLab = [[UILabel alloc] init];
    _FourLab.font = [UIFont systemFontOfSize:13];
    _FourLab.textAlignment = NSTextAlignmentCenter;
    _FourLab.textColor = BlueColor;
    _FourLab.text = @"日注册商户";
    [self.contentView addSubview:_FourLab];
    
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
    
    [self.addDalyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset([JNSHAutoSize height:13]);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth/4.0, [JNSHAutoSize height:25]));
    }];
    
    [_OneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addDalyLab.mas_bottom).offset([JNSHAutoSize height:6]);
        make.left.equalTo(self.addDalyLab);
        make.size.mas_equalTo(self.addDalyLab);
    }];
    
    [self.totalAgentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addDalyLab);
        make.left.equalTo(self.addDalyLab.mas_right);
        make.size.mas_equalTo(self.addDalyLab);
    }];
    
    [_TwoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalAgentLab.mas_bottom).offset([JNSHAutoSize height:6]);
        make.left.equalTo(self.totalAgentLab);
        make.size.mas_equalTo(self.totalAgentLab);
    }];
    
    [self.legalAgentDalyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.self.totalAgentLab);
        make.left.equalTo(self.totalAgentLab.mas_right);
        make.size.mas_equalTo(self.totalAgentLab);
    }];
    
    [_ThreeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.legalAgentDalyLab.mas_bottom).offset([JNSHAutoSize height:6]);
        make.left.equalTo(self.legalAgentDalyLab);
        make.size.mas_equalTo(self.legalAgentDalyLab);
    }];
    
    [self.resignDalyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.self.legalAgentDalyLab);
        make.left.equalTo(self.legalAgentDalyLab.mas_right);
        make.size.mas_equalTo(self.legalAgentDalyLab);
    }];

    [_FourLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resignDalyLab.mas_bottom).offset([JNSHAutoSize height:6]);
        make.left.equalTo(self.resignDalyLab);
        make.size.mas_equalTo(self.resignDalyLab);
    }];
    
    
}



@end
