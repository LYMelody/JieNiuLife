//
//  JNSHSystemMessageCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/6.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHSystemMessageCell : UITableViewCell

@property(nonatomic,strong)UILabel *timeLab;

@property(nonatomic,copy)NSString *message;

@property(nonatomic,strong)UILabel *titleLab;

@end
