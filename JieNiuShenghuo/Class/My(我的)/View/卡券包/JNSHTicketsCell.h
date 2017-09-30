//
//  JNSHTicketsCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/17.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UseBlock)(void);

@interface JNSHTicketsCell : UITableViewCell

@property(nonatomic,assign)BOOL isUsed;

@property(nonatomic,assign)BOOL isUpDate;

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UILabel *timeLab;

@property(nonatomic,copy)UseBlock useBlock;

@end
