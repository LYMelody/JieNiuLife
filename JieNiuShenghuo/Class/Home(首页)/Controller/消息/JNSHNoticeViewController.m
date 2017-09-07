//
//  JNSHNoticeViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/5.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHNoticeViewController.h"
#import "JPUSHService.h"
#import "AppDelegate.h"
#import "JNSHMessageListCell.h"
#import "JNSHSystemViewController.h"
@interface JNSHNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHNoticeViewController {
    
    UITableView *table;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"消息";
    
    self.view.backgroundColor = ColorTabBarBackColor;
    
    [table reloadData];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //灰色背景
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight)];
    backImg.userInteractionEnabled = YES;
    backImg.backgroundColor = ColorTableBackColor;
    
    [self.view addSubview:backImg];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = ColorTableBackColor;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:10])];
    headerView.backgroundColor = ColorTableBackColor;
    table.tableHeaderView = headerView;
    [backImg addSubview:table];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHMessageListCell alloc] init];
        if (indexPath.row == 0) {
            cell.leftImg.image = [UIImage imageNamed:@"notice1"];
            cell.titleLab.text = @"系统通知";
            cell.messageLab.text = @"公告:今天公司停电，放假一天,望大家互相转告!";
            cell.timeLab.text = @"2017-09-06";
            cell.badge = 1;
        }else {
            cell.leftImg.image = [UIImage imageNamed:@"notice2"];
            cell.titleLab.text = @"活动通知";
            cell.messageLab.text = @"公告:会员升级啦，快围过来看看~";
            cell.timeLab.text = @"2017-09-03";
            cell.isBottom = YES;
            
        }
        
    }
    //cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 51;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JNSHMessageListCell *cell = [table cellForRowAtIndexPath:indexPath];
    cell.badge = 0;
    
    if (indexPath.row == 0) {
        
        JNSHSystemViewController *Systemvc = [[JNSHSystemViewController alloc] init];
        Systemvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Systemvc animated:YES];
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
