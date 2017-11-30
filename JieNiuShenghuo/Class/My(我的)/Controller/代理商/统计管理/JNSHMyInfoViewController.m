//
//  JNSHMyInfoViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/27.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHMyInfoViewController.h"
#import "UIViewController+Cloudox.h"
#import "JNSHTitleCell.h"

@interface JNSHMyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHMyInfoViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"我的信息";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    [self.view addSubview:table];
    

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
            cell.leftLab.text = @"代理级别";
            cell.rightLab.text = @"一级代理商";
        }else if (indexPath.row == 1) {
            cell.leftLab.text = @"代理名称";
            cell.rightLab.text = @"张三丰/捷牛科技";
        }else if (indexPath.row == 2) {
            cell.leftLab.text = @"开通时间";
            cell.rightLab.text = @"2017-12-12";
        }else if (indexPath.row == 3) {
            cell.leftLab.text = @"联系方式";
            cell.rightLab.text = @"151****3223";
        }else if (indexPath.row == 4) {
            cell.leftLab.text = @"身份证";
            cell.rightLab.text = @"411327******4248";
        }else if (indexPath.row == 5) {
            cell.leftLab.text = @"银行卡";
            cell.rightLab.text = @"6222********8888";
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
