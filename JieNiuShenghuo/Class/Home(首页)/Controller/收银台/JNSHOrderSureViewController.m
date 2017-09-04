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
#import "JNSHVipViewController.h"
#import "JNSHPayOrderViewController.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"

@interface JNSHOrderSureViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property(nonatomic,strong)UITableView *table;

@end

@implementation JNSHOrderSureViewController {
    
    JNSHPopBankCardView *Popview;
    JNSHLabFldCell *CardCell;
    BOOL isVip;
    float finalAmount;
    NSString *BankName;
    NSString *BankNo;
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
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    _table.delegate = self;
    _table.dataSource = self;
    _table.backgroundColor = ColorTableBackColor;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_table];
    
    //tablefootView
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:100])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    JNSHCommonButton *CommitBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:40], (KscreenWidth - [JNSHAutoSize width:30]), [JNSHAutoSize height:41])];
    [CommitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [CommitBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [footView addSubview:CommitBtn];
    
    _table.tableFooterView = footView;
    
    //禁止滑动延迟
    _table.delaysContentTouches = NO;
    for(id view in _table.subviews) {
        
        if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewWrapperView"]) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrrowView = (UIScrollView *)view;
                scrrowView.delaysContentTouches = NO;
            }
            break;
        }
    }
    
    isVip = NO;
    
    //获取基本信息
    [self getBaseInfo];
    
}

//选择银行卡下一步、
- (void)commit {
    
    
    NSLog(@"下一步");
    
//    JNSHOrderCodeViewController *CodeVc = [[JNSHOrderCodeViewController alloc] init];
//    CodeVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:CodeVc animated:YES];
    
    JNSHPayOrderViewController *PayOrderVc = [[JNSHPayOrderViewController alloc] init];
    PayOrderVc.payMoney = [NSString stringWithFormat:@"%@",_amount];
    PayOrderVc.bankName = BankName;
    PayOrderVc.bankNo = BankNo;
    PayOrderVc.orderNo = self.orderNo;
    PayOrderVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:PayOrderVc animated:YES];
    
    
}


//获取用户基本信息
- (void)getBaseInfo {
    
    NSString *timestamp = [JNSHAutoSize getTimeNow];
    
    NSDictionary *dic = @{
                          @"timestamp":timestamp
                          };
    
    NSString *action = @"UserBaseInfoState";
    
    NSLog(@"%@",[JNSYUserInfo getUserInfo].userToken);
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        //NSLog(@"%@",result);
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        if([code isEqualToString:@"000000"]) {
            
            [JNSYUserInfo getUserInfo].userCode = resultdic[@"userCode"];
            [JNSYUserInfo getUserInfo].userPhone = resultdic[@"userPhone"];
            //[JNSYUserInfo getUserInfo].userName = resultdic[@"userName"];
            [JNSYUserInfo getUserInfo].userAccount = resultdic[@"userAccount"];
            [JNSYUserInfo getUserInfo].userCert = resultdic[@"userCert"];
            [JNSYUserInfo getUserInfo].userPoints = resultdic[@"userPoints"];
            [JNSYUserInfo getUserInfo].branderCardFlg = resultdic[@"branderCardFlg"];
            [JNSYUserInfo getUserInfo].branderCardNo = resultdic[@"branderCardNo"];
            [JNSYUserInfo getUserInfo].picHeader = resultdic[@"picHeader"];
            [JNSYUserInfo getUserInfo].userVipFlag = [NSString stringWithFormat:@"%@",resultdic[@"vipFlg"]];
            //[JNSYUserInfo getUserInfo].userVipFlag = @"1";
            [JNSYUserInfo getUserInfo].SettleCard = resultdic[@"userBank"];
            
            //实名认证状态
            NSString *userStatus = resultdic[@"userStatus"];
            if ([userStatus isEqualToString:@"11"]) {
                [JNSYUserInfo getUserInfo].userStatus = @"待审核";
            }else if ([userStatus isEqualToString:@"12"]){
                [JNSYUserInfo getUserInfo].userStatus = @"审核驳回";
            }else if ([userStatus isEqualToString:@"20"]) {
                [JNSYUserInfo getUserInfo].userStatus = @"审核通过";
            }else if([userStatus isEqualToString:@"10"]){
                [JNSYUserInfo getUserInfo].userStatus = @"初始化";
            }else if ([userStatus isEqualToString:@"19"]) {
                [JNSYUserInfo getUserInfo].userStatus = @"初审通过";
            }else if ([userStatus isEqualToString:@"30"]) {
                [JNSYUserInfo getUserInfo].userStatus = @"系统风控";
            }else {
                [JNSYUserInfo getUserInfo].userStatus = @"停用删除";
            }
            
//            //判断是否是Vip
//            if ([[JNSYUserInfo getUserInfo].userVipFlag isEqualToString:@"1"]) {
//                
//                isVip = YES;
//                
//            }
            
            
        }else {
            NSString *msg = resultdic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
    } failure:^(NSError *error) {
        
        //[JNSYAutoSize showMsg:error];
        
    }];
    
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
            orderSumCell.rightLab.text = [NSString stringWithFormat:@"￥%@",self.amount];
            cell = orderSumCell;
            cell.backgroundColor = [UIColor whiteColor];
            
        }else if (indexPath.row == 2) {
            
            JNSHTitleCell *realChargeCell = [[JNSHTitleCell alloc] init];
            realChargeCell.leftLab.text = @"实际手续费";
            float rate = 0;
            if (isVip) {   //根据是否是会员确定费率
                rate = 0.0039;
            }else {
                rate = 0.0053;
            }
            float fate = [self.amount integerValue]*rate + 3;
            realChargeCell.rightLab.text = [NSString stringWithFormat:@"-￥%.2f",fate];
            cell = realChargeCell;
            cell.backgroundColor = [UIColor whiteColor];
            
        }else if (indexPath.row == 3) {
            JNSHOrderDisCountCell *Cell = [[JNSHOrderDisCountCell alloc] init];
            Cell.leftLab.text = @"原手续费";
            float rate = [self.amount integerValue]*0.0053+3;
            Cell.rightLab.text = [NSString stringWithFormat:@"-￥%.2f【10000*0.53%%+3】",rate];
            cell = Cell;
        }else if (indexPath.row == 4) {
            JNSHOrderDisCountCell *Cell = [[JNSHOrderDisCountCell alloc] init];
            Cell.leftLab.text = @"会员优惠";
            float discont;
            if(isVip) {
                 discont = [self.amount integerValue] *(0.0053-0.0039);
            }else {
                discont = 0;
            }
            Cell.rightLab.text = [NSString stringWithFormat:@"￥%.2f",discont];
            Cell.rightLab.textColor = blueColor;
            Cell.rightBtn.hidden = NO;
            __weak typeof(self) weakSelf = self;
            Cell.continueVipBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                JNSHVipViewController *VipVc = [[JNSHVipViewController alloc] init];
                VipVc.hidesBottomBarWhenPushed = YES;
                [strongSelf.navigationController pushViewController:VipVc animated:YES];
            };
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
            float rate = 0;
            if (isVip) {   //根据是否是会员确定费率
                rate = 0.0039;
            }else {
                rate = 0.0053;
            }
            float fate = [self.amount integerValue]*rate + 3;
            finalAmount = [self.amount floatValue] - fate;
            finalCashCell.rightLab.text = [NSString stringWithFormat:@"￥%.2f",finalAmount];
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
            cardCell.textFiled.enabled = NO;
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
        JNSHLabFldCell *cell = [_table cellForRowAtIndexPath:indexPath];
        
        [cell.textFiled resignFirstResponder];
        
        NSDictionary *dic = @{
                              @"bankName":@"工商银行",
                              @"bankNum":@"6222021202041714172"
                              };
        NSDictionary *dicTwo = @{
                                 @"bankName":@"广发银行",
                                 @"bankNum":@"6258091653275896",
                                 };
        NSDictionary *dicThree = @{
                                   @"bankName":@"招商银行",
                                   @"bankNum":@"6225767400096103"
                                   };
        NSArray *bankArray = [[NSArray alloc] initWithObjects:dic,dicTwo,dicThree, nil];
        
        Popview = [[JNSHPopBankCardView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        Popview.typetag = 1;
        Popview.bankArray = bankArray;
       
        Popview.addnewCardBlock = ^{
            cell.leftLab.text = @"新信用卡";
            cell.textFiled.text = @"";
            cell.textFiled.enabled = YES;
            [cell.textFiled becomeFirstResponder];
        };
        
        Popview.bankselectBlock = ^(NSString *bankName, NSString *bankCode) {
            cell.leftLab.text = bankName;
            cell.textFiled.text = [bankCode stringByReplacingCharactersInRange:NSMakeRange(bankCode.length -8 - 4, 8) withString:@"********"];
            BankNo = bankCode;
            BankName = bankName;
            cell.textFiled.enabled = NO;
        };
        
        [Popview showInView:self.view];
    }
}

#define mark textFiledDeleage

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSDictionary *dic = @{
                          @"orderNo":self.orderNo,
                          @"cardNo":textField.text
                          };
    NSString *action = @"PayOrderNocardBank";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"data":dic,
                                 @"token":[JNSYUserInfo getUserInfo].userToken
                                 };
    NSString *paras = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:paras success:^(id result) {
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        NSString *msg = resultdic[@"msg"];
        if ([code isEqualToString:@"000000"]) {
            
            
        }else {
            [JNSHAutoSize showMsg:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
