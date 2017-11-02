//
//  JNSHPayResultViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/23.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHPayResultViewController.h"
#import "JNSHCommonButton.h"
#import "Masonry.h"
#import "JNSHTitleCell.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "MBProgressHUD.h"

@interface JNSHPayResultViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHPayResultViewController {
    
    
    NSInteger anthorIndex;
    JNSHCommonButton *CommitBtn;
    NSTimer *anthorTimer;
    MBProgressHUD *HUD;
    UIImageView *logoImg;
    UILabel *messageLab;
    UILabel *causeLab;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"支付结果";
    
    self.view.backgroundColor = ColorTabBarBackColor;
    
    self.navigationController.navigationBar.translucent = NO;
    
    //隐藏返回按钮
    [self.navigationItem setHidesBackButton:YES];
   
}

- (void)viewWillDisappear:(BOOL)animated {
    
     [self.navigationItem setHidesBackButton:NO];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //完成按钮
    UIButton *completBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completBtn.frame = CGRectMake(0, 0, [JNSHAutoSize width:60], [JNSHAutoSize height:30]);
    completBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [completBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [completBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backHomeBtn = [[UIBarButtonItem alloc] initWithCustomView:completBtn];
    self.navigationItem.rightBarButtonItem = backHomeBtn;
    
    //导航栏背景
    UIImageView *navBackImg = [[UIImageView alloc] init];
    navBackImg.userInteractionEnabled = YES;
    navBackImg.frame = CGRectMake(0, 0, KscreenWidth, 64);
    navBackImg.backgroundColor = ColorTabBarBackColor;
    [self.view addSubview:navBackImg];
    
    //table
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];

    //headerView
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:[JNSHAutoSize height:151]])];
    headerView.backgroundColor = ColorTableBackColor;
    
    logoImg = [[UIImageView alloc] init];
    logoImg.image = [UIImage imageNamed:@"pay-success"];
    
    [headerView addSubview:logoImg];
    
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(headerView).offset([JNSHAutoSize height:30]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:53], [JNSHAutoSize height:53]));
    }];
    
    //交易状态Lab
    messageLab = [[UILabel alloc] init];
    messageLab.font = [UIFont systemFontOfSize:14];
    messageLab.textColor = ColorText;
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.text = @"交易成功!";
    [headerView addSubview:messageLab];
    
    if([self.orderStatus isEqualToString:@"SUCC"]) {          //交易成功
        
    }else if ([self.orderStatus isEqualToString:@"WAIT"]) {   //交易处理中...
        logoImg.image = [UIImage imageNamed:@"payment_loading"];
        messageLab.text = @"交易处理中";
    }else if ([self.orderStatus isEqualToString:@"FAIL"]){    //交易失败
        logoImg.image = [UIImage imageNamed:@"payment-failed"];
        messageLab.text = @"交易失败";
    }

    [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(logoImg.mas_bottom).offset([JNSHAutoSize height:13]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:20]));
    }];
    
    //交易状态原因
    causeLab = [[UILabel alloc] init];
    causeLab.font = [UIFont systemFontOfSize:12];
    causeLab.textColor = BlueColor;
    causeLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:causeLab];
    if ([self.orderStatus isEqualToString:@"FAIL"]) {
        causeLab.text = self.orderMsg;
        causeLab.textColor = [UIColor redColor];
    }
    [causeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(messageLab.mas_bottom).offset([JNSHAutoSize height:12]);
        make.centerX.equalTo(messageLab);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:15]));
    }];
    
    table.tableHeaderView = headerView;
    
    //tablefootView
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:100])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    CommitBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:40], (KscreenWidth - [JNSHAutoSize width:30]), [JNSHAutoSize height:41])];
    [CommitBtn addTarget:self action:@selector(refresh) forControlEvents:UIControlEventTouchUpInside];
    [CommitBtn setTitle:@"刷新订单" forState:UIControlStateNormal];
    //订单审核状态下 显示查询按钮
    if ([self.orderStatus isEqualToString:@"WAIT"]) {
        CommitBtn.hidden = NO;
    }else {
        CommitBtn.hidden = YES;
    }
    
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

//确定
- (void)commit{
    
    NSLog(@"确定");
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
    
}

//刷新状态
- (void)refresh {
    
    CommitBtn.enabled = NO;
    anthorIndex = anthorIndex + 9;
    anthorTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(quaryOrder) userInfo:nil repeats:YES];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"查询中...";
    
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
        NSLog(@"%@",dic);
        if (![code isEqualToString:@"000000"]) {
            [JNSHAutoSize showMsg:msg];
            CommitBtn.enabled = YES;
            [HUD hide:YES];
        }else {
            
            NSString *status = [NSString stringWithFormat:@"%@",dic[@"orderStatus"]];
            NSString *orderMemo = dic[@"orderMemo"];
            NSString *orderNo = dic[@"orderNo"];
            NSString *orderTimer = dic[@"orderTime"];
            NSString *product = [NSString stringWithFormat:@"%@",dic[@"product"]];
            if ([status isEqualToString:@"20"] || [status isEqualToString:@"30"]) { //支付成功
                NSLog(@"%@",orderMemo);
                [HUD hide:YES];
                anthorIndex = 0;
                [anthorTimer invalidate];
                //展示图片
                logoImg.image = [UIImage imageNamed:@"pay-success"];
                messageLab.text = @"交易成功!";
                CommitBtn.hidden = YES;
                
            }else if ((anthorIndex == 0) && ([status isEqualToString:@"11"] || [status isEqualToString:@"13"] || [status isEqualToString:@"12"])) {    //支付查询中...
                NSLog(@"%@",orderMemo);
                [HUD hide:YES];
                anthorIndex = 0;
                [anthorTimer invalidate];
                CommitBtn.enabled = YES;
            }else if ([status isEqualToString:@"21"]) {        //支付失败
                [HUD hide:YES];
                NSLog(@"%@",orderMemo);
                anthorIndex = 0;
                [anthorTimer invalidate];
                
                logoImg.image = [UIImage imageNamed:@"payment-failed"];
                messageLab.text = @"交易失败";
                causeLab.text = self.orderMsg;
                causeLab.textColor = [UIColor redColor];
                CommitBtn.hidden = YES;
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [HUD hide:YES];
    }];
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHTitleCell alloc] init];
        if (indexPath.row == 0) {
            cell.leftLab.text = @"交易金额";
            cell.rightLab.text = [NSString stringWithFormat:@"￥%@",self.orderMoney];
            cell.rightLab.textColor = [UIColor redColor];
        }else if (indexPath.row == 1) {
            cell.leftLab.text = @"交易名称";
            if ([self.product isEqualToString:@"1000"]) {
                cell.rightLab.text = @"商户收款";
            }else if([self.product isEqualToString:@"1001"]) {
                cell.rightLab.text = @"会员购买";
            }else {
                cell.rightLab.text = @"升级代理商";
            }
        }else if (indexPath.row == 2) {
            cell.leftLab.text = @"交易银行";
            cell.rightLab.text = self.bankName;
        }else if (indexPath.row == 3) {
            cell.leftLab.text = @"交易账户";
            cell.rightLab.text = [self.bankAccount stringByReplacingCharactersInRange:NSMakeRange(4, 8) withString:@"********"];
        }else if (indexPath.row == 4) {
            cell.leftLab.text = @"订单编号";
            cell.rightLab.text = self.orderNo;
        }else if (indexPath.row == 5) {
            cell.leftLab.text = @"交易时间";
            cell.rightLab.text = self.orderTime;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
