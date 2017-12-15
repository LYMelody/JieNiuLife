//
//  JNSHTiXianAlertView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/12/13.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JNSHPreTiXianModel.h"

typedef void(^SureTiXianBlock)(void);

@interface JNSHTiXianAlertView : UIView <UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)JNSHPreTiXianModel *model;

@property(nonatomic,copy)SureTiXianBlock sureTiXianBlock;

- (void)showInView:(UIView *)view;

- (void)dismiss;


@end
