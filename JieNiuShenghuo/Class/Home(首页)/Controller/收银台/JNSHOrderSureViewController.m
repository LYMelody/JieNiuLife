//
//  JNSHOrderSureViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHOrderSureViewController.h"
#import "JNSHTitleCell.h"
#import "JNSHLabFldCell.h"
#import "JNSHBrandCell.h"
#import "JNSHOrderDisCountCell.h"
#import "JNSHCommonButton.h"
#import "JNSHPopBankCardView.h"
#import "JNSHOrderCodeViewController.h"
@interface JNSHOrderSureViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation JNSHOrderSureViewController {
    
    JNSHPopBankCardView *Popview;
    JNSHLabFldCell *CardCell;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"订单确认";
    self.view.backgroundColor = ColorTabBarBackColor;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:table];
    
    
    //tablefootView
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:100])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    JNSHCommonButton *CommitBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:40], (KscreenWidth - [JNSHAutoSize width:30]), [JNSHAutoSize height:41])];
    [CommitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [CommitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [footView addSubview:CommitBtn];
    
    table.tableFooterView = footView;
    
    //禁止滑动延迟
    table.delaysContentTouches = NO;
    for(id view in table.subviews) {
        
        if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewWrapperView"]) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrrowView = (UIScrollView *)view;
                scrrowView.delaysContentTouches = NO;
            }
            break;
        }
    }
    
    
}

- (void)commit {
    
    
    NSLog(@"下一步");
    
    JNSHOrderCodeViewController *CodeVc = [[JNSHOrderCodeViewController alloc] init];
    CodeVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:CodeVc animated:YES];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 9;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            JNSHBrandCell *orderInfoCell = [[JNSHBrandCell alloc] init];
            orderInfoCell.leftLab.text = @"订单信息";
            orderInfoCell.backgroundColor = ColorTableBackColor;
            cell = orderInfoCell;
        }else if (indexPath.row == 1) {
            
            JNSHTitleCell *orderSumCell = [[JNSHTitleCell alloc] init];
            orderSumCell.leftLab.text = @"订单金额";
            orderSumCell.rightLab.text = @"￥10000.00";
            cell = orderSumCell;
            cell.backgroundColor = [UIColor whiteColor];
            
        }else if (indexPath.row == 2) {
            
            JNSHTitleCell *realChargeCell = [[JNSHTitleCell alloc] init];
            realChargeCell.leftLab.text = @"实际手续费";
            realChargeCell.rightLab.text = @"-￥42.00";
            cell = realChargeCell;
            cell.backgroundColor = [UIColor whiteColor];
            
        }else if (indexPath.row == 3) {
            JNSHOrderDisCountCell *Cell = [[JNSHOrderDisCountCell alloc] init];
            Cell.leftLab.text = @"原手续费";
            Cell.rightLab.text = @"-￥56.00【10000*0.53%+3】";
            cell = Cell;
        }else if (indexPath.row == 4) {
            JNSHOrderDisCountCell *Cell = [[JNSHOrderDisCountCell alloc] init];
            Cell.leftLab.text = @"会员优惠";
            Cell.rightLab.text = @"￥14.00";
            Cell.rightLab.textColor = blueColor;
            Cell.rightBtn.hidden = NO;
            cell = Cell;
        }else if (indexPath.row == 5) {
            JNSHOrderDisCountCell *Cell = [[JNSHOrderDisCountCell alloc] init];
            Cell.leftLab.text = @"卡券抵扣";
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"￥0.00 【无可用】"];
            [attr addAttribute:NSForegroundColorAttributeName value:ColorTabBarBackColor range:NSMakeRange(attr.length - 5, 5)];
            Cell.rightLab.attributedText = attr;
            Cell.isShowBottomLine = YES;
            cell = Cell;
        }
        else if (indexPath.row == 6) {
            JNSHTitleCell *finalCashCell = [[JNSHTitleCell alloc] init];
            finalCashCell.leftLab.text = @"到账金额";
            finalCashCell.rightLab.text = @"￥9958.00";
            finalCashCell.rightLab.textColor = [UIColor redColor];
            cell = finalCashCell;
            cell.backgroundColor = [UIColor whiteColor];
        }else if (indexPath.row == 7) {
            JNSHBrandCell *certCardCell = [[JNSHBrandCell alloc] init];
            certCardCell.leftLab.text = @"选择支付信用卡";
            cell = certCardCell;
            cell.backgroundColor = ColorTableBackColor;
            
        }else if (indexPath.row == 8) {
            JNSHLabFldCell *cardCell = [[JNSHLabFldCell alloc] init];
            cardCell.leftLab.text = @"中信银行";
            cardCell.textFiled.text = @"4033********1234";
            cardCell.textFiled.delegate = self;
            cardCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            cell = cardCell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 7) {
        return 45;
    }else if (indexPath.row == 3||indexPath.row == 4||indexPath.row == 5){
        return 30;
    }
    
    return 41;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 8) { //弹出银行卡列表
        
        //先影藏键盘
        [CardCell.textFiled resignFirstResponder];
        
        Popview = [[JNSHPopBankCardView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        Popview.typetag = 1;
        __block JNSHLabFldCell *Card = CardCell;
        
        Popview.addnewCardBlock = ^{
            Card.leftLab.text = @"新信用卡";
            Card.textFiled.text = @"";
            [Card.textFiled becomeFirstResponder];
        };
        
        [Popview showInView:self.view];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (range.location == 0) {
        
        CardCell.leftLab.text = @"新信用卡";
    }else {
        CardCell.leftLab.text = @"中信银行";
    }
    
    if(range.location > 19) {  //限20位
        return NO;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
