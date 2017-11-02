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
#import "JNSHWebViewController.h"

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
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *navBackImg = [[UIImageView alloc] init];
    navBackImg.userInteractionEnabled = YES;
    navBackImg.frame = CGRectMake(0, 0, KscreenWidth, 64);
    navBackImg.backgroundColor = ColorTabBarBackColor;
    [self.view addSubview:navBackImg];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64)];
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
    
    //BankName = @"中信银行";
    //BankNo = @"4033458695861234";
    
}

//选择银行卡下一步、
- (void)commit {
    
    NSLog(@"下一步");
    
    if ([CardCell.textFiled.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"请输入卡号"];
        return;
    }else if (([BankNo isEqualToString:@""] || BankNo == nil) && ![CardCell.textFiled.text isEqualToString:@""]) {
        BankNo = CardCell.textFiled.text;
    }
    
    //快捷支付绑卡
    NSDictionary *dic = @{
                          @"orderNo":self.orderNo,
                          @"cardNo":BankNo
                          };
    
    
    NSString *action = @"PayOrderNocardBank";

    if (self.typeTag == 2) {
        action = @"PayOrderUnionH5Bank";
    }
    
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
        NSLog(@"%@",resultdic);
        if ([code isEqualToString:@"000000"]) {
            //订单
            self.orderNo = resultdic[@"orderNo"];
            if (self.typeTag == 2) {  //银联支付
                
                NSString *H5Url = resultdic[@"h5Url"];
                
                JNSHWebViewController *WebVc = [[JNSHWebViewController alloc] init];
                WebVc.Navtitle = @"订单支付";
                WebVc.url = H5Url;
                WebVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:WebVc animated:YES];
                
            }else {                   //正常支付
                
                NSString *isBind = [NSString stringWithFormat:@"%@",resultdic[@"isBind"]];
                BankNo = resultdic[@"cardNo"];
                BankName = resultdic[@"cardBank"];
                NSString *cardPhone = resultdic[@"cardPhone"];
                if ([isBind isEqualToString:@"1"]) {  //已绑信用卡
                    JNSHOrderCodeViewController *CodeVc = [[JNSHOrderCodeViewController alloc] init];
                    CodeVc.hidesBottomBarWhenPushed = YES;
                    CodeVc.payMoney = [NSString stringWithFormat:@"%@",_amount];
                    CodeVc.bankNo = BankNo;
                    CodeVc.bankName = BankName;
                    CodeVc.orderNo = self.orderNo;
                    CodeVc.cardPhone =  cardPhone;
                    [self.navigationController pushViewController:CodeVc animated:YES];
                    
                }else {   // 新信用卡首次支付
                    
                    JNSHPayOrderViewController *PayOrderVc = [[JNSHPayOrderViewController alloc] init];
                    PayOrderVc.payMoney = [NSString stringWithFormat:@"%@",_amount];
                    PayOrderVc.bankName = BankName;
                    PayOrderVc.bankNo = BankNo;
                    PayOrderVc.orderNo = self.orderNo;
                    PayOrderVc.cardPhone = cardPhone;
                    PayOrderVc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:PayOrderVc animated:YES];
                    
                }
            }
        }else {
            [JNSHAutoSize showMsg:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//获取用户基本信息 (获取姓名和身份证号)
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
            realChargeCell.rightLab.text = [NSString stringWithFormat:@"-￥%.2f",[self.rateFee integerValue]/100.0];
            cell = realChargeCell;
            cell.backgroundColor = [UIColor whiteColor];
            
        }else if (indexPath.row == 3) {
            JNSHOrderDisCountCell *Cell = [[JNSHOrderDisCountCell alloc] init];
            Cell.leftLab.text = @"原手续费";
            Cell.rightLab.text = [NSString stringWithFormat:@"-￥%.2f【%@】",[self.rateNormalFee integerValue]/100.0,self.rateNormalFeeValue];
            cell = Cell;
        }else if (indexPath.row == 4) {
            JNSHOrderDisCountCell *Cell = [[JNSHOrderDisCountCell alloc] init];
            
            if ([self.vipFlag isEqualToString:@"0"]) {
                Cell.leftLab.text = @"会员可优惠";
                [Cell.rightBtn setTitle:@"立即开通" forState:UIControlStateNormal];
                Cell.rightBtn.hidden = NO;
            }else if ([self.vipFlag isEqualToString:@"1"]) {
                Cell.leftLab.text = @"会员优惠";
                Cell.rightBtn.hidden = YES;
            }else {
                Cell.leftLab.text = @"会员优惠";
                [Cell.rightBtn setTitle:@"立即续费" forState:UIControlStateNormal];
                Cell.rightBtn.hidden = NO;
            }
            
            Cell.rightLab.text = [NSString stringWithFormat:@"￥%.2f",[self.vipDiscount integerValue]/100.0];
            Cell.rightLab.textColor = BlueColor;
            if (self.typeTag == 2) {
                Cell.isShowBottomLine = YES;
            }
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
            if([self.voucheersFlag isEqualToString:@"1"]) {  //有抵扣券
                NSString *str= [NSString stringWithFormat:@"￥%.2f 【已选用】",[self.vouchersPrice integerValue]/100.0];
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:str];
                [attr addAttribute:NSForegroundColorAttributeName value:ColorTabBarBackColor range:NSMakeRange(str.length - 5, 5)];
                Cell.rightLab.attributedText = attr;
                //Cell.rightLab.text = [NSString stringWithFormat:@"￥%.2f",[self.vouchersPrice integerValue]/100.0];
            }else {
                NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"￥0.00 【无可用】"];
                [attr addAttribute:NSForegroundColorAttributeName value:ColorTabBarBackColor range:NSMakeRange(attr.length - 5, 5)];
                Cell.rightLab.attributedText = attr;
            }
            
            Cell.isShowBottomLine = YES;
            cell = Cell;
        }
        else if (indexPath.row == 6) {
            JNSHTitleCell *finalCashCell = [[JNSHTitleCell alloc] init];
            finalCashCell.leftLab.text = @"到账金额";
            finalCashCell.rightLab.text = [NSString stringWithFormat:@"￥%.2f",[self.settleReal integerValue]/100.0];
            finalCashCell.rightLab.textColor = [UIColor redColor];
            cell = finalCashCell;
            cell.backgroundColor = [UIColor whiteColor];
        }else if (indexPath.row == 7) {
            JNSHBrandCell *certCardCell = [[JNSHBrandCell alloc] init];
            certCardCell.leftLab.text = @"选择支付信用卡";
            cell = certCardCell;
            cell.backgroundColor = ColorTableBackColor;
            
        }else if (indexPath.row == 8) {
            CardCell = [[JNSHLabFldCell alloc] init];
            if (self.bindCards.count > 0) {
                
                CardCell.leftLab.text = self.bindCards[0][@"cardBank"];
                CardCell.textFiled.text = [self.bindCards[0][@"cardNo"] stringByReplacingCharactersInRange:NSMakeRange(4, 8) withString:@"********"];
                BankNo = self.bindCards[0][@"cardNo"];
                BankName = self.bindCards[0][@"cardBank"];
                CardCell.textFiled.enabled = NO;
            }else {
                CardCell.leftLab.text = @"新信用卡";
                CardCell.textFiled.text = @"";
                [CardCell.textFiled becomeFirstResponder];
            }
            
            CardCell.textFiled.delegate = self;
            CardCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            
            cell = CardCell;
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
        if ((indexPath.row == 5) && (self.typeTag == 2)) {
            return 0;
        }
        return 30;
    }
    
    return 41;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 8) { //弹出银行卡列表
        
        //先影藏键盘
        JNSHLabFldCell *cell = [_table cellForRowAtIndexPath:indexPath];
        
        [cell.textFiled resignFirstResponder];
        
//        NSDictionary *dic = @{
//                              @"bankName":@"工商银行",
//                              @"bankNum":@"6222021202041714172"
//                              };
//        NSDictionary *dicTwo = @{
//                                 @"bankName":@"广发银行",
//                                 @"bankNum":@"6258091653275896",
//                                 };
//        NSDictionary *dicThree = @{
//                                   @"bankName":@"招商银行",
//                                   @"bankNum":@"6225767400096103"
//                                   };
        //NSArray *bankArray = [[NSArray alloc] initWithObjects:dic,dicTwo,dicThree, nil];
        Popview = [[JNSHPopBankCardView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        Popview.typetag = 1;
        Popview.bankArray = self.bindCards;
       
        Popview.addnewCardBlock = ^{
            cell.leftLab.text = @"新信用卡";
            cell.textFiled.text = @"";
            cell.textFiled.enabled = YES;
            [cell.textFiled becomeFirstResponder];
            
            BankNo = @"";
            BankName = @"新信用卡";
            
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
    
    BankNo = textField.text;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (range.location == 0) {
        CardCell.leftLab.text = @"新信用卡";
    }else {
        
    }
    
    if(range.location > 19) {  //限20位
        return NO;
    }
    
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBar.translucent = YES;
    
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
