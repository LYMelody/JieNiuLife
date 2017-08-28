//
//  JNSHPopBankCardView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddNewCardBlock)(void);

@interface JNSHPopBankCardView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)NSInteger currentIndex;

@property(nonatomic,copy)AddNewCardBlock addnewCardBlock;

@property(nonatomic,assign)NSInteger typetag;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
