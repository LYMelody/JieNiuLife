//
//  JNSHOrderDetailController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/17.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHOrderDetailController.h"
#import "JNSHLabFldCell.h"
#import "Masonry.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"

@interface JNSHOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHOrderDetailController


- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"订单详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navBarBgAlpha = @"1.0";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    [self.view addSubview:table];
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:120])];
    headerView.backgroundColor = ColorTableBackColor;
    
    UILabel *moneyLab = [[UILabel alloc] init];
    moneyLab.font = [UIFont systemFontOfSize:24];
    moneyLab.textColor = ColorText;
    moneyLab.textAlignment = NSTextAlignmentCenter;
    moneyLab.text = [NSString stringWithFormat:@"￥%.2f",[self.model.orderPrice floatValue]];
    
    [headerView addSubview:moneyLab];
    
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).offset([JNSHAutoSize height:30]);
        make.left.right.equalTo(headerView);
        make.height.mas_equalTo([JNSHAutoSize height:24]);
    }];
    
    UILabel *statusLab = [[UILabel alloc] init];
    statusLab.font = [UIFont systemFontOfSize:15];
    statusLab.textAlignment = NSTextAlignmentCenter;
    statusLab.textColor = GreenColor;
    statusLab.text = self.model.orderStatus;

    if ([self.model.orderStatus isEqualToString:@"初始化"]) {
        statusLab.textColor = [UIColor orangeColor];
    }else if ([self.model.orderStatus isEqualToString:@"支付成功"]) {
        statusLab.textColor = GreenColor;
    }else if ([self.model.orderStatus isEqualToString:@"支付失败"]) {
        statusLab.textColor = [UIColor redColor];
    }
    
    [headerView addSubview:statusLab];
    
    [statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.right.equalTo(headerView);
        make.height.mas_equalTo([JNSHAutoSize height:15]);
    }];

    table.tableHeaderView = headerView;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHLabFldCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHLabFldCell alloc] init];
        if (indexPath.row == 0) {
            cell.leftLab.text = @"交易名称";
            if ([self.model.product isEqualToString:@"1000"]) {
                cell.textFiled.text = @"商户收款";
            }else if ([self.model.product  isEqualToString:@"1001"]) {
                cell.textFiled.text = @"会员购买";
            }else if([self.model.product isEqualToString:@"1002"]) {
                cell.textFiled.text = @"升级代理商";
            }
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 1){
            cell.leftLab.text = @"交易银行";
            cell.textFiled.text = self.model.cardBank;
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 2){
            cell.leftLab.text = @"交易账户";
            cell.textFiled.text = self.model.cardNo;
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 3) {
            cell.leftLab.text = @"订单编号";
            cell.textFiled.text = self.model.orderNo;
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 4) {
            cell.leftLab.text = @"交易时间";
            cell.textFiled.text = self.model.orderReqTime;
            cell.textFiled.enabled = NO;
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
