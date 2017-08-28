//
//  JNSHMyHeaderCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/4.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHMyHeaderCell : UITableViewCell


@property(nonatomic,strong)UIImageView *headerView;

@property(nonatomic,strong)UILabel *nickNameLab;

@property(nonatomic,strong)UILabel *phoneLab;

@property(nonatomic,assign)BOOL showVip;

@property(nonatomic,strong)UIImageView *vipImgView;

@property(nonatomic,strong)UIImageView *rightIndicatorView;

@property(nonatomic,strong)UILabel *logoInLab;

@property(nonatomic,assign)BOOL isLogoedIn;

@end
