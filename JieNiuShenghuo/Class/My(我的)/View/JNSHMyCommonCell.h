//
//  JNSHMyCommonCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/4.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHMyCommonCell : UITableViewCell


@property(nonatomic,strong)UIImageView *titleImage;

@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)UILabel *rightLab;

@property(nonatomic,strong)UIImageView *bottomLineView;

@property(nonatomic,strong)UIImageView *topLineView;

@property(nonatomic,assign)BOOL showTopLine;

@property(nonatomic,assign)BOOL showBottomLine;


@end
