//
//  JNSHOrderDisCountCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHOrderDisCountCell : UITableViewCell

@property(nonatomic,strong)UILabel *leftLab;

@property(nonatomic,strong)UILabel *rightLab;

@property(nonatomic,strong)UIButton *rightBtn;

@property(nonatomic,strong)UIImageView *bottomLine;

@property(nonatomic,assign)BOOL isShowBottomLine;

@end
