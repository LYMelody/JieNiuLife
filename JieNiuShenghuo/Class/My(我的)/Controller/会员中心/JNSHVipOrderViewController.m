//
//  JNSHVipOrderViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHVipOrderViewController.h"
#import "JNSHTitleCell.h"
#import "JNSHLabFldCell.h"
#import "Masonry.h"
#import "JNSHPopBankCardView.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSYUserInfo.h"
#import "JNSHOrderCodeViewController.h"
#import "JNSHPayOrderViewController.h"

@interface JNSHVipOrderViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation JNSHVipOrderViewController {
    
    JNSHPopBankCardView *Popview;
    JNSHLabFldCell *CardCell;
    NSString *BankName;
    NSString *BankNo;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"订单确认";
    self.view.backgroundColor = ColorTableBackColor;
    self.navBarBgAlpha = @"1.0";
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
//    backImg.backgroundColor = ColorTabBarBackColor;
//    backImg.userInteractionEnabled = YES;
//    [self.view addSubview:backImg];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.backgroundColor = ColorTableBackColor;
    
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:100])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(Next) forControlEvents:UIControlEventTouchUpInside];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"btn_nor"] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateSelected];
    nextBtn.layer.cornerRadius = 3;
    nextBtn.layer.masksToBounds = YES;
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [footView addSubview:nextBtn];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footView).offset([JNSHAutoSize height:40]);
        make.left.equalTo(footView).offset([JNSHAutoSize width:16]);
        make.right.equalTo(footView).offset(-[JNSHAutoSize width:16]);
        make.height.mas_equalTo([JNSHAutoSize height:41]);
    }];
    
    table.tableFooterView = footView;
    
    [self.view addSubview:table];
    
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
- (void)Next {
    
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
            
            self.orderNo = resultdic[@"orderNo"];
            NSString *isBind = [NSString stringWithFormat:@"%@",resultdic[@"isBind"]];
            BankNo = resultdic[@"cardNo"];
            BankName = resultdic[@"cardBank"];
            NSString *cardPhone = resultdic[@"cardPhone"];
            if ([isBind isEqualToString:@"1"]) {  //已绑信用卡
                JNSHOrderCodeViewController *CodeVc = [[JNSHOrderCodeViewController alloc] init];
                CodeVc.hidesBottomBarWhenPushed = YES;
                CodeVc.payMoney = [NSString stringWithFormat:@"%@",self.money];
                CodeVc.bankNo = BankNo;
                CodeVc.bankName = BankName;
                CodeVc.orderNo = self.orderNo;
                CodeVc.cardPhone =  cardPhone;
                [self.navigationController pushViewController:CodeVc animated:YES];
                
            }else {   // 新信用卡首次支付
                
                JNSHPayOrderViewController *PayOrderVc = [[JNSHPayOrderViewController alloc] init];
                PayOrderVc.payMoney = [NSString stringWithFormat:@"%@",self.money];
                PayOrderVc.bankName = BankName;
                PayOrderVc.bankNo = BankNo;
                PayOrderVc.orderNo = self.orderNo;
                PayOrderVc.cardPhone = cardPhone;
                PayOrderVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:PayOrderVc animated:YES];
                
            }
            
        }else {
            [JNSHAutoSize showMsg:msg];
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
            Cell.leftLab.text = @"订单信息";
            Cell.bottomLine.hidden = YES;
            cell = Cell;
            cell.backgroundColor = ColorTableBackColor;
        }else if (indexPath.row == 1) {
            JNSHTitleCell *Cell = [[JNSHTitleCell alloc] init];
            Cell.leftLab.text = @"订单名称";
            Cell.rightLab.text = self.productName;
            cell = Cell;
            cell.backgroundColor = [UIColor whiteColor];
        }else if (indexPath.row == 2) {
            JNSHTitleCell *Cell = [[JNSHTitleCell alloc] init];
            Cell.leftLab.text = @"订单金额";
            Cell.rightLab.text = [NSString stringWithFormat:@"￥%@",self.money];
             Cell.bottomLine.hidden = YES;
            cell = Cell;
            cell.backgroundColor = [UIColor whiteColor];
        }else if (indexPath.row == 3) {
            JNSHTitleCell *Cell = [[JNSHTitleCell alloc] init];
            Cell.leftLab.text = @"支付信息";
            Cell.bottomLine.hidden = YES;
            cell = Cell;
            cell.backgroundColor = ColorTableBackColor;
        }else if (indexPath.row == 4) {
            CardCell = [[JNSHLabFldCell alloc] init];
            if (self.cardsArray.count > 0) {
                
                CardCell.leftLab.text = self.cardsArray[0][@"cardBank"];
                CardCell.textFiled.text = [self.cardsArray[0][@"cardNo"] stringByReplacingCharactersInRange:NSMakeRange(4, 8) withString:@"********"];
                BankNo = self.cardsArray[0][@"cardNo"];
                BankName = self.cardsArray[0][@"cardBank"];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) { //弹出银行卡列表
        
        //先影藏键盘
        [CardCell.textFiled resignFirstResponder];
        
        Popview = [[JNSHPopBankCardView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        Popview.typetag = 1;
        __block JNSHLabFldCell *Card = CardCell;
        Popview.bankArray = self.cardsArray;
        Popview.addnewCardBlock = ^{
            Card.leftLab.text = @"新信用卡";
            Card.textFiled.text = @"";
            Card.textFiled.enabled = YES;
            [Card.textFiled becomeFirstResponder];
            
            BankNo = @"";
            BankName = @"新信用卡";
            
        };
        
        Popview.bankselectBlock = ^(NSString *bankName, NSString *bankCode) {
            Card.leftLab.text = bankName;
            Card.textFiled.text = [bankCode stringByReplacingCharactersInRange:NSMakeRange(bankCode.length -8 - 4, 8) withString:@"********"];
            BankNo = bankCode;
            BankName = bankName;
            Card.textFiled.enabled = NO;
        };
        
        [Popview showInView:self.view];
    }
}


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
