//
//  JNSHOrderCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHOrderCell : UITableViewCell

@property(nonatomic,strong)UILabel *typeLab;

@property(nonatomic,strong)UILabel *timeLab;

@property(nonatomic,strong)UILabel *moneyLab;

@property(nonatomic,strong)UILabel *statusLab;


- (void)settype:(NSString *)type time:(NSString *)time money:(NSString *)money status:(NSString *)status;

@end
