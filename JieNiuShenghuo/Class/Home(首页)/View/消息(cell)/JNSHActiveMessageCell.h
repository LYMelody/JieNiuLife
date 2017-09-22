//
//  JNSHActiveMessageCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/20.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MessageTapBlock)(void);

@interface JNSHActiveMessageCell : UITableViewCell

@property(nonatomic,strong)UILabel *timeLab;

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UIImageView *titleImg;

@property(nonatomic,strong)UILabel *contentLab;



@property(nonatomic,copy)MessageTapBlock messageTapBlock;

@end
