//
//  JNSHPayOrderViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHPayOrderViewController.h"
#import "JNSHCommonButton.h"
#import "JNSHTitleCell.h"
#import "JNSHLabFldCell.h"
#import "JNSHGetCodeCell.h"
#import "JNSHBrandCell.h"
#import "JNSHPopYXQView.h"
#import "JNSHPayResultViewController.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"

@interface JNSHPayOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation JNSHPayOrderViewController {
    
    NSTimer *timer;
    NSInteger index;
    JNSHGetCodeCell *CodeCell;
    JNSHLabFldCell *YxqCell;
    JNSHLabFldCell *CVVCell;
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
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
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

//下一步
- (void)commit {
    
    NSLog(@"下一步");
    
    JNSHPayResultViewController *PayResultVc = [[JNSHPayResultViewController alloc] init];
    PayResultVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:PayResultVc animated:YES];
    
    
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
            JNSHTitleCell *Cell = [[JNSHTitleCell alloc] init];
            Cell.leftLab.text = @"支付金额";
            Cell.rightLab.text = [NSString stringWithFormat:@"￥%@",self.payMoney];
            Cell.rightLab.textColor = [UIColor redColor];
            cell = Cell;
        }else if (indexPath.row == 1) {
            
            JNSHTitleCell *Cell = [[JNSHTitleCell alloc] init];
            Cell.leftLab.text = @"姓      名";
            Cell.rightLab.text = [JNSYUserInfo getUserInfo].userAccount;
            cell = Cell;
            
        }else if (indexPath.row == 2) {
            
            JNSHTitleCell *Cell = [[JNSHTitleCell alloc] init];
            Cell.leftLab.text = @"身份证号";
            Cell.rightLab.text = [[JNSYUserInfo getUserInfo].userCert stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
            cell = Cell;
            
        }else if (indexPath.row == 3) {
            
            JNSHBrandCell *Cell = [[JNSHBrandCell alloc] init];
            Cell.leftLab.text = @"银行卡信息";
            cell = Cell;
            cell.backgroundColor = ColorTableBackColor;
            
        }else if (indexPath.row == 4) {
            
            JNSHTitleCell *Cell = [[JNSHTitleCell alloc] init];
            Cell.leftLab.text = self.bankName;
            Cell.rightLab.text = self.bankNo;
            cell = Cell;
            
        }else if (indexPath.row == 5) {
            
            YxqCell = [[JNSHLabFldCell alloc] init];
            YxqCell.leftLab.text = @"有效期";
            YxqCell.textFiled.placeholder = @"请选择有效期";
            YxqCell.textFiled.enabled = NO;
            cell = YxqCell;
            
        }else if (indexPath.row == 6) {
            
            CVVCell = [[JNSHLabFldCell alloc] init];
            CVVCell.leftLab.text = @"CVV";
            CVVCell.textFiled.placeholder = @"银行卡背面后三位";
            CVVCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            CVVCell.textFiled.secureTextEntry = YES;
            CVVCell.textFiled.delegate = self;
            cell = CVVCell;
            
        }else if (indexPath.row == 7) {
            
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"预留手机号";
            Cell.textFiled.text = [[JNSYUserInfo getUserInfo].userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            Cell.textFiled.placeholder = @"请输入手机号";
            Cell.textFiled.clearButtonMode = UITextFieldViewModeAlways;
            cell = Cell;
            
        }else if (indexPath.row == 8) {
            
            CodeCell = [[JNSHGetCodeCell alloc] init];
            CodeCell.leftLab.text = @"验证码";
            CodeCell.textFiled.placeholder = @"请输入验证码";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 5) {
        
        JNSHPopYXQView *YXQView = [[JNSHPopYXQView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        
        YXQView.selectdateblock = ^(NSString *selectDate) {
            JNSHLabFldCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.textFiled.text = selectDate;
        };
        
        [YXQView showInView:self.view];

    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (range.location > 2) {
        return NO;
    }
    
    return YES;
}


//获取验证码
- (void)getcode {
    
    CodeCell.codeBtn.enabled = NO;
    
    if ([YxqCell.textFiled.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"有效期为空!"];
         CodeCell.codeBtn.enabled = YES;
        return;
    }else if([CVVCell.textFiled.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"CVV为空!"];
         CodeCell.codeBtn.enabled = YES;
        return;
    }
    
    //发起验证码请求
    NSDictionary *dic = @{
                          @"orderNo":self.orderNo,
                          @"cardAccount":[JNSYUserInfo getUserInfo].userAccount,
                          @"cardCert":[JNSYUserInfo getUserInfo].userCert,
                          @"cardPhone":[JNSYUserInfo getUserInfo].userPhone,
                          @"cardCvv":CVVCell.textFiled.text,
                          @"cardYxq":YxqCell.textFiled.text
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
            
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            index = 60;
            
        }else {
            [JNSHAutoSize showMsg:msg];
        }
    
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

//定时器方法
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 3) {
        return 51;
    }
    
    return 41;
    
    
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
