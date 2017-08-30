//
//  JNSHCommitEmailViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHCommitEmailViewController.h"
#import "JNSHLabFldCell.h"
#import "Masonry.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSHCommonButton.h"

@interface JNSHCommitEmailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHCommitEmailViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"我要做代理";
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    //底部视图
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:80])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    JNSHCommonButton *bindBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:40],(KscreenWidth - [JNSHAutoSize width:15]*2) , [JNSHAutoSize height:41])];
    [bindBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [bindBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:bindBtn];
    
    table.tableFooterView = footView;
    
    //头部视图
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:10])];
    headerView.backgroundColor = ColorTableBackColor;
    
    table.tableHeaderView = headerView;
    
    
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

//提交申请
- (void)commit {
    
    NSLog(@"提交");
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHLabFldCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHLabFldCell alloc] init];
        if (indexPath.row == 0) {
            cell.leftLab.text = @"姓   名";
            cell.textFiled.text = @"张三";
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 1) {
            cell.leftLab.text = @"身份证";
            cell.textFiled.text = @"411327********5612";
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 2) {
            cell.leftLab.text = @"结算卡";
            cell.textFiled.text = @"3212**** **** **** 666";
            cell.textFiled.enabled = NO;
            
        }else if (indexPath.row == 3) {
            cell.leftLab.text = @"邮   箱";
            cell.textFiled.placeholder = @"请输入邮箱";
            cell.textFiled.keyboardType = UIKeyboardTypeEmailAddress;
        }
        
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
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
