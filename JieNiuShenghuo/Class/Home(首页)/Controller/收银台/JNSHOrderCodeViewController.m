//
//  JNSHOrderCodeViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHOrderCodeViewController.h"
#import "JNSHTitleCell.h"
#import "JNSHLabFldCell.h"
#import "JNSHBrandCell.h"
#import "JNSHCommonButton.h"
#import "JNSHGetCodeCell.h"
#import "JNSHPayOrderViewController.h"
#import "JNSHPayResultViewController.h"
#import "JNSHOrderSureViewController.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "MBProgressHUD.h"

@interface JNSHOrderCodeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHOrderCodeViewController {
    
    NSTimer *timer;
    NSTimer *anthorTimer;
    NSInteger index;
    NSInteger anthorIndex;
    JNSHGetCodeCell *CodeCell;
    JNSHLabFldCell *PhoneCell;
    JNSHCommonButton *CommitBtn;
    MBProgressHUD *HUD;
    
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
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    //headerView
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:15])];
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor = ColorTableBackColor;
    
    table.tableHeaderView = headerView;
    
    //tablefootView
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:100])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    CommitBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:40], (KscreenWidth - [JNSHAutoSize width:30]), [JNSHAutoSize height:41])];
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

//下一步
- (void)commit {
    
    CommitBtn.enabled = NO;
    
     if ([CodeCell.textFiled.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"验证码为空"];
        CommitBtn.enabled = YES;
        return;
    }else if ((CodeCell.textFiled.text.length < 4) || (CodeCell.textFiled.text.length > 6)) {
        [JNSHAutoSize showMsg:@"验证码格式错误"];
        CommitBtn.enabled = YES;
        return;
    }
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"支付中...";
    
    NSDictionary *dic = @{
                          @"orderNo":self.orderNo,
                          @"smsCode":CodeCell.textFiled.text
                          };
    
    NSString *action = @"PayOrderNocardConfirm";
    NSDictionary *requuestDic = @{
                                  @"action":action,
                                  @"data":dic,
                                  @"token":[JNSYUserInfo getUserInfo].userToken
                                  };
    NSString *params = [requuestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        NSString *msg = resultdic[@"msg"];
        NSLog(@"%@",resultdic);
        if([code isEqualToString:@"000000"]) {
            
            //订单查询
            anthorIndex = anthorIndex + 9;
            anthorTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(quaryOrder) userInfo:nil repeats:YES];
            
        }else {
            [JNSHAutoSize showMsg:msg];
            [HUD hide:YES];
        }
        
        CommitBtn.enabled = YES;
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        CommitBtn.enabled = YES;
        [HUD hide:YES];
    }];
}

//订单查询
- (void)quaryOrder {
    
    anthorIndex = anthorIndex - 3;
    
    NSDictionary *dic = @{
                          @"linkId":[JNSHAutoSize getTimeNow],
                          @"orderNo":self.orderNo
                          };
    NSString *action = @"PayOrderStatus";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        NSString *msg = dic[@"msg"];
        //NSLog(@"%@",dic);
        if (![code isEqualToString:@"000000"]) {
            [JNSHAutoSize showMsg:msg];
            [HUD hide:YES];
        }else {
            
            NSString *status = [NSString stringWithFormat:@"%@",dic[@"orderStatus"]];
            NSString *orderMemo = dic[@"orderMemo"];
            NSString *orderNo = dic[@"orderNo"];
            NSString *orderTimer = dic[@"orderTime"];
            NSString *product = [NSString stringWithFormat:@"%@",dic[@"product"]];
            JNSHPayResultViewController *PayResultVc = [[JNSHPayResultViewController alloc] init];
            PayResultVc.hidesBottomBarWhenPushed = YES;
            
            if ([status isEqualToString:@"12"] || [status isEqualToString:@"20"] || [status isEqualToString:@"30"]) {
                NSLog(@"%@",orderMemo);
                [HUD hide:YES];
                anthorIndex = 0;
                [anthorTimer invalidate];
                PayResultVc.orderStatus = @"SUCC";
                PayResultVc.orderMsg = orderMemo;
                PayResultVc.orderNo = orderNo;
                PayResultVc.orderTime = orderTimer;
                PayResultVc.orderMoney = self.payMoney;
                PayResultVc.bankName = self.bankName;
                PayResultVc.bankAccount = self.bankNo;
                PayResultVc.product = product;
                [self.navigationController pushViewController:PayResultVc animated:YES];
            }else if ((anthorIndex == 0) && ([status isEqualToString:@"11"] || [status isEqualToString:@"13"])) {
                NSLog(@"%@",orderMemo);
                [HUD hide:YES];
                anthorIndex = 0;
                [anthorTimer invalidate];
                PayResultVc.orderStatus = @"WAIT";
                PayResultVc.orderMsg = orderMemo;
                PayResultVc.orderNo = orderNo;
                PayResultVc.orderTime = orderTimer;
                PayResultVc.orderMoney = self.payMoney;
                PayResultVc.bankName = self.bankName;
                PayResultVc.bankAccount = self.bankNo;
                PayResultVc.product = product;
                [self.navigationController pushViewController:PayResultVc animated:YES];
            }else if ([status isEqualToString:@"21"]) {
                [HUD hide:YES];
                NSLog(@"%@",orderMemo);
                anthorIndex = 0;
                [anthorTimer invalidate];
                PayResultVc.orderStatus = @"FAIL";
                PayResultVc.orderMsg = orderMemo;
                PayResultVc.orderNo = orderNo;
                PayResultVc.orderTime = orderTimer;
                PayResultVc.orderMoney = self.payMoney;
                PayResultVc.bankName = self.bankName;
                PayResultVc.bankAccount = self.bankNo;
                PayResultVc.product = product;
                [self.navigationController pushViewController:PayResultVc animated:YES];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            JNSHTitleCell *Cell = [[JNSHTitleCell alloc] init];
            Cell.leftLab.text = @"支付金额";
            Cell.rightLab.text = [NSString stringWithFormat:@"￥%@",self.payMoney];
            Cell.rightLab.textColor = [UIColor redColor];
            cell = Cell;
        }else if (indexPath.row == 1) {
            JNSHBrandCell *Cell = [[JNSHBrandCell alloc] init];
            Cell.leftLab.text = @"银行卡信息";
            Cell.backgroundColor = ColorTableBackColor;
            cell = Cell;
        }else if (indexPath.row == 2) {
            JNSHTitleCell *Cell = [[JNSHTitleCell alloc] init];
            Cell.leftLab.text = self.bankName;
            Cell.changeBtn.hidden = NO;
            Cell.changeCardBlock = ^{   //变更银行卡
                JNSHPayOrderViewController *SureVc = [[JNSHPayOrderViewController alloc] init];
                SureVc.payMoney = [NSString stringWithFormat:@"%@",self.payMoney];
                SureVc.bankName = self.bankName;
                SureVc.bankNo = self.bankNo;
                SureVc.orderNo = self.orderNo;
                SureVc.cardPhone = self.cardPhone;
                SureVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:SureVc animated:YES];
            };
            Cell.rightLab.text = [self.bankNo stringByReplacingCharactersInRange:NSMakeRange(4, 8) withString:@"********"];
            cell = Cell;
            
        }else if (indexPath.row == 3) {
           
            PhoneCell = [[JNSHLabFldCell alloc] init];
            PhoneCell.leftLab.text = @"预留手机号";
            if ([self.cardPhone isEqualToString:@""]) {
                PhoneCell.textFiled.text = self.cardPhone;
            }else {
                PhoneCell.textFiled.text = [self.cardPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            }
            PhoneCell.textFiled.clearButtonMode = UITextFieldViewModeAlways;
            PhoneCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            cell = PhoneCell;
        
        }else if (indexPath.row == 4) {
            
            CodeCell = [[JNSHGetCodeCell alloc] init];
            CodeCell.leftLab.text = @"验证码";
            CodeCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            
            __weak typeof(self) weakSelf = self;
            
            CodeCell.getcodeBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf getcode];
            };
        
            cell = CodeCell;
            
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
        return 51;
    }
    return 41;
    
}

//获取验证码
- (void)getcode {
    
    CodeCell.codeBtn.enabled = NO;
    
    if ([PhoneCell.textFiled.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"手机号为空"];
        CodeCell.codeBtn.enabled = YES;
        return;
    }else if (PhoneCell.textFiled.text.length != 11) {
        [JNSHAutoSize showMsg:@"手机号格式错误"];
        CommitBtn.enabled = YES;
        return;
    }
    
    //发起验证码请求
    NSDictionary *dic = @{
                          @"orderNo":self.orderNo,
                          @"cardAccount":[JNSYUserInfo getUserInfo].userAccount,
                          @"cardCert":[JNSYUserInfo getUserInfo].userCert,
                          @"cardPhone":self.cardPhone,
                          };
    NSString *action = @"PayOrderNocardSms";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"data":dic,
                                 @"token":[JNSYUserInfo getUserInfo].userToken
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        NSString *msg = resultdic[@"msg"];
        NSLog(@"%@",resultdic);
        if([code isEqualToString:@"000000"]) {
            
            index = 59;
            //改变按钮
            [CodeCell.codeBtn setTitle:[NSString stringWithFormat:@"重新获取%lds",index] forState:UIControlStateNormal];
            [CodeCell.codeBtn setBackgroundColor:GrayColor];
            CodeCell.codeBtn.enabled = NO;
            
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            
            
        }else {
            [JNSHAutoSize showMsg:msg];
        }
        CodeCell.codeBtn.enabled = YES;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        CodeCell.codeBtn.enabled = YES;
    }];
}

- (void)countDown {
    
    index--;
    
    if (index < 0) {
        [CodeCell.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [CodeCell.codeBtn setBackgroundColor:ColorTabBarBackColor];
        CodeCell.codeBtn.enabled = YES;
        [timer invalidate];
    }else {
        
        [CodeCell.codeBtn setTitle:[NSString stringWithFormat:@"重新获取%lds",index] forState:UIControlStateNormal];
        [CodeCell.codeBtn setBackgroundColor:GrayColor];
        CodeCell.codeBtn.enabled = NO;
        
    }
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
