//
//  JNSHPopBankCardView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddNewCardBlock)(void);

typedef void(^bankSelectBlock)(NSString *bankName, NSString *bankCode);

@interface JNSHPopBankCardView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,assign)NSInteger currentIndex;

@property(nonatomic,copy)AddNewCardBlock addnewCardBlock;

@property(nonatomic,copy)bankSelectBlock bankselectBlock;

@property(nonatomic,assign)NSInteger typetag;     //1：付款方式银行卡  2：选择银行

@property(nonatomic,strong)NSArray *bankArray;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
