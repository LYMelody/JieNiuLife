//
//  JNSHInvateHistoryCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/18.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHInvateHistoryCell : UITableViewCell

@property(nonatomic,strong)UIImageView *headerImg;

@property(nonatomic,strong)UILabel *nameLab;

@property(nonatomic,strong)UILabel *phoneLab;

@property(nonatomic,strong)UILabel *statusLab;

@property(nonatomic,assign)BOOL isUsed;

@property(nonatomic,strong)UIImageView *usedImgView;

@end
