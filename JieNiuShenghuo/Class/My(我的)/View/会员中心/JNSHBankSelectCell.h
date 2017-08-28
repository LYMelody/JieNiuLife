//
//  JNSHBankSelectCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^bankCardSelectBlock)(void);

@interface JNSHBankSelectCell : UITableViewCell

@property(nonatomic,strong)UIImageView *bankLogoImg;

@property(nonatomic,strong)UILabel *bankNameLab;

@property(nonatomic,strong)UILabel *bankCardLab;

@property(nonatomic,strong)UIButton *selectBtn;

@property(nonatomic,copy)bankCardSelectBlock cardSelectBlock;

@property(nonatomic,assign)NSInteger tag;

@end
