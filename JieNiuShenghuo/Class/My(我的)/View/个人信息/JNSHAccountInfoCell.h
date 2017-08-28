//
//  JNSHAccountInfoCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/7.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHAccountInfoCell : UITableViewCell

@property(nonatomic,strong)UILabel *leftLab;

@property(nonatomic,strong)UILabel *rightLab;

@property(nonatomic,strong)UIImageView *bottomLineView;

@property(nonatomic,assign)BOOL isLast;

@end
