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
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "JNSYUserInfo.h"
#import "MBProgressHUD.h"

@interface JNSHCommitEmailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHCommitEmailViewController {
    
    UITableView *table;
    JNSHCommonButton *bindBtn;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"我要做代理";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navBarBgAlpha = @"1.0";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    //底部视图
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:80])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    bindBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:40],(KscreenWidth - [JNSHAutoSize width:15]*2) , [JNSHAutoSize height:41])];
    [bindBtn setTitle:@"提交申请" forState:UIControlStateNormal];
    [bindBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:bindBtn];
    
    table.tableFooterView = footView;
    
    //头部视图
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:10])];
    headerView.backgroundColor = ColorTableBackColor;
    NSLog(@"message:%@",self.message);
    if (self.message) {
        
        headerView.frame = CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:51]);
        UILabel *lab = [[UILabel alloc] init];
        lab.frame = CGRectMake([JNSHAutoSize width:15], 0, KscreenWidth - [JNSHAutoSize width:15], [JNSHAutoSize height:51]);
        lab.font = [UIFont systemFontOfSize:15];
        lab.text = @"审核驳回";
        lab.textColor = [UIColor redColor];
        lab.textAlignment = NSTextAlignmentLeft;
        [headerView addSubview:lab];
        
        if ([self.message isEqualToString:@"1"]) {
            bindBtn.hidden = YES;
            lab.text = @"等待审核";
            lab.textColor = BlueColor;
        }
        
    }else {
        
    }
    
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
    
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    JNSHLabFldCell *cell = [table cellForRowAtIndexPath:indexPath];
    bindBtn.enabled = NO;
    
    //正则邮箱验证
    NSString *emailCkeck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCkeck];
    
    
    if ([cell.textFiled.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"邮箱为空!"];
        bindBtn.enabled = YES;
        return;
    }
    
    if (![emailTest evaluateWithObject:cell.textFiled.text]) {
        [JNSHAutoSize showMsg:@"邮箱格式不对!"];
        bindBtn.enabled = YES;
        return;
    }
    
    
    NSDictionary *dic = @{
                          @"userEmail":cell.textFiled.text
                          };
    NSString *action = @"UserToOrg";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSString *code = resultDic[@"code"];
        NSString *msg = resultDic[@"msg"];
        //NSLog(@"%@",resultDic);
        if ([code isEqualToString:@"000000"]) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"信息已提交";
            [hud hide:YES afterDelay:1.5];
            [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        bindBtn.enabled = YES;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        bindBtn.enabled = YES;
    }];
}

//返回
- (void)back {
    
    //返回根视图
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
            cell.textFiled.text = [JNSYUserInfo getUserInfo].userName;
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 1) {
            cell.leftLab.text = @"身份证";
            cell.textFiled.text = [[JNSYUserInfo getUserInfo].userCert stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
            cell.textFiled.enabled = NO;
        }else if (indexPath.row == 2) {
            cell.leftLab.text = @"结算卡";
            cell.textFiled.text = [[JNSYUserInfo getUserInfo].SettleCard stringByReplacingCharactersInRange:NSMakeRange(4, [JNSYUserInfo getUserInfo].SettleCard.length - 7) withString:@"**** **** ****"];
            cell.textFiled.enabled = NO;
            
        }else if (indexPath.row == 3) {
            cell.leftLab.text = @"邮   箱";
            cell.textFiled.placeholder = @"请输入邮箱";
            cell.textFiled.keyboardType = UIKeyboardTypeEmailAddress;
            if ([self.message isEqualToString:@"1"]) {
                cell.textFiled.text = self.email;
                cell.textFiled.enabled = NO;
            }
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
