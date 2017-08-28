//
//  JNSHSexCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/7.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHSexCell : UITableViewCell


@property(nonatomic,strong)UILabel *leftLab;

@property(nonatomic,strong)UIImageView *topLineView;

@property(nonatomic,strong)UIImageView *bottomLineView;

@property(nonatomic,assign)BOOL showTopLine;

@property(nonatomic,assign)BOOL isLast;


@end
