//
//  JNSHGetCodeCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^GetCodeBlock)(void);

@interface JNSHGetCodeCell : UITableViewCell


@property(nonatomic,strong)UILabel *leftLab;

@property(nonatomic,strong)UITextField *textFiled;

@property(nonatomic,strong)UIButton *codeBtn;

@property(nonatomic,copy)GetCodeBlock getcodeBlock;

@property(nonatomic,strong)UIImageView *bottomLine;

@property(nonatomic,assign)BOOL showBottom;

@end
