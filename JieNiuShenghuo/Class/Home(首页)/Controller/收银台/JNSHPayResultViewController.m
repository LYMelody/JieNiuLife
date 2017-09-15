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

@interface JNSHPayResultViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHPayResultViewController

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
    
    UIImageView *navBackImg = [[UIImageView alloc] init];
    navBackImg.userInteractionEnabled = YES;
    navBackImg.frame = CGRectMake(0, 0, KscreenWidth, 64);
    navBackImg.backgroundColor = ColorTabBarBackColor;
    [self.view addSubview:navBackImg];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];

    //headerView
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:[JNSHAutoSize height:151]])];
    headerView.backgroundColor = ColorTableBackColor;
    
    UIImageView *logoImg = [[UIImageView alloc] init];
    logoImg.image = [UIImage imageNamed:@"pay-success"];
    
    
    
    [headerView addSubview:logoImg];
    
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(headerView).offset([JNSHAutoSize height:30]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:53], [JNSHAutoSize height:53]));
    }];
    
    //交易状态Lab
    UILabel *messageLab = [[UILabel alloc] init];
    messageLab.font = [UIFont systemFontOfSize:14];
    messageLab.textColor = ColorText;
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.text = @"交易成功!";
    [headerView addSubview:messageLab];
    
    if([self.orderStatus isEqualToString:@"SUCC"]) {
        
    }else if ([self.orderStatus isEqualToString:@"WAIT"]) {
        
    }else if ([self.orderStatus isEqualToString:@"FAIL"]){
        logoImg.image = [UIImage imageNamed:@"payment-failed"];
        messageLab.text = @"交易失败";
    }

    [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(logoImg.mas_bottom).offset([JNSHAutoSize height:13]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:20]));
    }];
    
    //交易状态原因
    UILabel *causeLab = [[UILabel alloc] init];
    causeLab.font = [UIFont systemFontOfSize:12];
    causeLab.textColor = blueColor;
    causeLab.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:causeLab];
    if ([self.orderStatus isEqualToString:@"FAIL"]) {
        causeLab.text = self.orderMsg;
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
    
    JNSHCommonButton *CommitBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:40], (KscreenWidth - [JNSHAutoSize width:30]), [JNSHAutoSize height:41])];
    [CommitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [CommitBtn setTitle:@"确定" forState:UIControlStateNormal];
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
