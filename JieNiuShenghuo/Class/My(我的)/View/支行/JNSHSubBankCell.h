//
//  JNSHSubBankCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/14.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNSYHighLightImageView.h"


typedef void(^CityselectBlock)(NSString *city);

@interface JNSHSubBankCell : UITableViewCell

@property(nonatomic,strong)JNSYHighLightImageView *locationImg;

@property(nonatomic,strong)NSMutableArray *titleArray;

@property(nonatomic,strong)UILabel *locationLab;

@property(nonatomic,copy)CityselectBlock citySelectBlock;

@end
