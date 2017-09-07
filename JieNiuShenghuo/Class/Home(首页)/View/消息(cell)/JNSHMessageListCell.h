//
//  JNSHMessageListCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/6.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHMessageListCell : UITableViewCell

@property(nonatomic,strong)UIImageView *leftImg;

@property(nonatomic,strong)UILabel *countLab;

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UILabel *messageLab;

@property(nonatomic,strong)UILabel *timeLab;

@property(nonatomic,assign)BOOL isBottom;

@property(nonatomic,assign)NSInteger badge;

@end
