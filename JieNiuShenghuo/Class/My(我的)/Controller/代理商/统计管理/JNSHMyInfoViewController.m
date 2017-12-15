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
#import "IBHttpTool.h"
#import "SBJSON.h"
#import "JNSYUserInfo.h"

@interface JNSHMyInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHMyInfoViewController {
    
    NSString *openTime;
    NSString *orgCert;
    NSString *orgName;
    NSString *orgNick;
    NSString *orgPhone;
    NSString *orgProfitBank;
    NSString *orgType;
    
    UITableView *table;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"我的信息";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    [self.view addSubview:table];
    
    [self requestForAgentInfo];
    
    
}

- (void)requestForAgentInfo {
    
    NSDictionary *dic = @{
                      @"timestamp":[JNSHAutoSize getTimeNow]
                      };
    NSString *action = @"OrgSelfInfo";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        //NSLog(@"%@",resultDic);
        openTime = resultDic[@"openTime"];
        orgCert = resultDic[@"orgCert"];
        orgName = resultDic[@"orgName"];
        orgNick = resultDic[@"orgNick"];
        orgPhone = resultDic[@"orgPhone"];
        orgProfitBank = resultDic[@"orgProfitBank"];
        orgType = resultDic[@"orgType"];
        
        [table reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
            cell.leftLab.text = @"代理级别";
            if ([orgType isEqualToString:@"L30"]) {
                cell.rightLab.text = @"办事处";
            }else if ([orgType isEqualToString:@"L31"]) {
                cell.rightLab.text = @"一级代理";
            }else if ([orgType isEqualToString:@"L32"]) {
                cell.rightLab.text = @"特约代理";
            }
            
        }else if (indexPath.row == 1) {
            cell.leftLab.text = @"代理名称";
            cell.rightLab.text = orgName;
        }else if (indexPath.row == 2) {
            cell.leftLab.text = @"开通时间";
            cell.rightLab.text = openTime;
        }else if (indexPath.row == 3) {
            cell.leftLab.text = @"联系方式";
            cell.rightLab.text = orgPhone;
        }else if (indexPath.row == 4) {
            cell.leftLab.text = @"身份证";
            cell.rightLab.text = orgCert;
        }else if (indexPath.row == 5) {
            cell.leftLab.text = @"银行卡";
            cell.rightLab.text = orgProfitBank;
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
