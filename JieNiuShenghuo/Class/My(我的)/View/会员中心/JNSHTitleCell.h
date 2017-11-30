//
//  JNSHTitleCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeCardBlock)(void);

@interface JNSHTitleCell : UITableViewCell

@property(nonatomic,strong)UILabel *leftLab;

@property(nonatomic,strong)UILabel *rightLab;

@property(nonatomic,strong)UIImageView *bottomLine;

@property(nonatomic,strong)UIButton *changeBtn;

@property(nonatomic,assign)BOOL ShowBottomLine;

@property(nonatomic,copy)ChangeCardBlock changeCardBlock;

@end
