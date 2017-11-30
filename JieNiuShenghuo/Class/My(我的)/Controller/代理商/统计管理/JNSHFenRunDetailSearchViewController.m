//
//  JNSHFenRunDetailSearchViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHFenRunDetailSearchViewController.h"
#import "Masonry.h"
#import "JNSHFenRunDetailCell.h"
#import "UIViewController+Cloudox.h"

@interface JNSHFenRunDetailSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHFenRunDetailSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"分润明细搜索";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = ColorTableBackColor;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *headerImg = [[UIImageView alloc] init];
    headerImg.backgroundColor = [UIColor whiteColor];
    headerImg.userInteractionEnabled = YES;
    [self.view addSubview:headerImg];
    
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:51]);
    }];
    
    UILabel *FenRunLab = [[UILabel alloc] init];
    FenRunLab.text = @"当前共888笔交易，合计分润￥8888.00";
    FenRunLab.textColor = ColorText;
    FenRunLab.textAlignment = NSTextAlignmentLeft;
    FenRunLab.font = [UIFont systemFontOfSize:14];
    [headerImg addSubview:FenRunLab];
    
    [FenRunLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerImg);
        make.left.equalTo(headerImg).offset([JNSHAutoSize width:15]);
        make.right.equalTo(headerImg);
        make.height.mas_equalTo([JNSHAutoSize height:20]);
    }];
    
    
    
    //tableview
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:51], KscreenWidth, KscreenHeight - [JNSHAutoSize height:51+64]) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:table];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHFenRunDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[JNSHFenRunDetailCell alloc] init];
        cell.orderNumLab.text = @"￥20000.00";
        cell.fenRunCashLab.text = @"￥200.00";
        cell.saleTimeLab.text = @"2017-12-01 12:20:20";
        cell.orderTypeLab.text = @"无卡快捷";
        cell.orderNoLab.text = @"201711301220207897";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
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
