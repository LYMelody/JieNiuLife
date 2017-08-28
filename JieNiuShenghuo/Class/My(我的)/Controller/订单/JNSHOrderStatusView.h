//
//  JNSHOrderStatusView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectBlock)(NSIndexPath *index);

typedef void(^dimissBlock)(void);

@interface JNSHOrderStatusView : UIView<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,copy)selectBlock selectblock;

@property(nonatomic,copy)dimissBlock dismissBlock;

- (void)showinView:(UIView *)view;

- (void)dismiss;

@end
