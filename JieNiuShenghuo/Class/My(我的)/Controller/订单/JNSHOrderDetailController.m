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
@interface JNSHOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHOrderDetailController


- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"订单详情";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
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
    moneyLab.text = @"￥1234234.00";
    
    [headerView addSubview:moneyLab];
    
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerView).offset([JNSHAutoSize height:30]);
        make.left.right.equalTo(headerView);
        make.height.mas_equalTo([JNSHAutoSize height:24]);
    }];
    
    UILabel *statusLab = [[UILabel alloc] init];
    statusLab.font = [UIFont systemFontOfSize:15];
    statusLab.textAlignment = NSTextAlignmentCenter;
    statusLab.textColor = greenColor;
    statusLab.text = @"支付成功!";

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
            cell.textFiled.text = @"收款";
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 1){
            cell.leftLab.text = @"交易银行";
            cell.textFiled.text = @"中信银行";
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 2){
            cell.leftLab.text = @"交易账户";
            cell.textFiled.text = @"4033********1232";
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 3) {
            cell.leftLab.text = @"订单编号";
            cell.textFiled.text = @"10120170817123123";
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 4) {
            cell.leftLab.text = @"交易时间";
            cell.textFiled.text = @"2017-08-17 13:34:34";
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
