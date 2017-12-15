//
//  JNSHAgentDetailViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAgentDetailViewController.h"
#import "JNSHAccountInfoCell.h"
#import "JNSHTradeNumCell.h"
#import "JNSHAgentCell.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSYUserInfo.h"
#import "MBProgressHUD.h"
#import "JNSHAgentMessageViewController.h"
#import "Masonry.h"
#import "JNSHAgentTypeCell.h"
#import "JNSHGetCodeCell.h"
#import "JNSHSaleStatisticViewController.h"
#import "JNSHUserManagerViewController.h"
#import "JNSHAgentManagerViewController.h"
#import "JNSHOrderManagerViewController.h"
#import "JNSHFenRunManagerViewController.h"
#import "JNSHTiXianViewController.h"


@interface JNSHAgentDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHAgentDetailViewController {
    
    NSString *dayProfit;     //日分润
    NSString *payCount;      //日交易笔数
    NSString *allProfit;     //累计分润
    NSString *paySumPrice;   //日交易金额
    NSString *dayOrg;        //日新增代理商
    NSString *subAgent;       //下级代理商
    NSString *passUser;      //日审核通过商户
    NSString *regUser;       //日注册商户
    NSString *orgType;       //代理商级别
    UITableView *table;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"代理商";
    self.view.backgroundColor = ColorTabBarBackColor;
    self.navBarBgAlpha = @"1.0";
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = ColorTabBarBackColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    //消息按钮
    //右侧消息按钮
    UIButton *MessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    MessageBtn.frame = CGRectMake(0, 0, 38, 38);
    [MessageBtn setImage:[UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
    [MessageBtn addTarget:self action:@selector(messageTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:MessageBtn];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = ColorTableBackColor;
    
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    [backImg addSubview:table];
    
    //获取代理商信息
    [self requestForAgentInfo];
    
}

//消息按钮
- (void)messageTap {
    
    JNSHAgentMessageViewController *Vc = [[JNSHAgentMessageViewController alloc] init];
    Vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:Vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 12;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0 ) {
            
            JNSHAgentTypeCell *Cell = [[JNSHAgentTypeCell alloc] init];
            //orgType = @"L31";
            Cell.orgType = orgType;
            Cell.backgroundColor = ColorTableBackColor;
            cell = Cell;
            
        }else if (indexPath.row == 1) {
            
            JNSHGetCodeCell *Cell = [[JNSHGetCodeCell alloc] init];
            Cell.textFiled.hidden = YES;
            [Cell.codeBtn setTitle:@"提现" forState:UIControlStateNormal];
            Cell.getcodeBlock = ^{
                NSLog(@"提现啦!");
                
                JNSHTiXianViewController *TixianVc = [[JNSHTiXianViewController alloc] init];
                TixianVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:TixianVc animated:YES];
                
            };
            Cell.leftLab.text = @"分润";
            Cell.leftLab.font = [UIFont systemFontOfSize:15];
            cell = Cell;
            
        }else if (indexPath.row == 4 || indexPath.row == 6) {
            
            cell.backgroundColor = ColorTableBackColor;
            
        }else if (indexPath.row == 2) {
            
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"日分润";
            Cell.rightLab.text = [NSString stringWithFormat:@"￥%.2f",[dayProfit floatValue]/100];
            Cell.rightLab.textColor = ColorTabBarBackColor;
            cell = Cell;
            
        }else if (indexPath.row == 3) {
            JNSHTradeNumCell *Cell = [[JNSHTradeNumCell alloc] init];
            Cell.numLab.text = [NSString stringWithFormat:@"共%@笔",payCount];
            Cell.dayNumLab.text = [NSString stringWithFormat:@"￥%.2f",[paySumPrice floatValue]/100];
            Cell.totalBenefitLab.text = [NSString stringWithFormat:@"￥%.2f",[allProfit floatValue]/100];
            cell = Cell;
        }else if (indexPath.row == 5) {
            
            JNSHAgentCell *Cell = [[JNSHAgentCell alloc] init];
            Cell.addDalyLab.text = dayOrg;
            Cell.totalAgentLab.text = subAgent;
            Cell.legalAgentDalyLab.text = passUser;
            Cell.resignDalyLab.text = regUser;
            cell = Cell;
            
        }
        else if (indexPath.row == 7) {
            
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"销售统计";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else if (indexPath.row == 8) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"商户管理";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 9) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"代理管理";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 10) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"订单管理";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 11) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"分润管理";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return [JNSHAutoSize height:110];
    }else if ( indexPath.row == 4 || indexPath.row == 6) {
        return [JNSHAutoSize height:15];
    }else if (indexPath.row == 3) {
        return [JNSHAutoSize height:61];
    }else if (indexPath.row == 5) {
        return [JNSHAutoSize height:76];
    }else {
        return [JNSHAutoSize height:41];
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 7) {
        JNSHSaleStatisticViewController *SaleStatisVc = [[JNSHSaleStatisticViewController alloc] init];
        SaleStatisVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:SaleStatisVc animated:YES];
        
    }else if (indexPath.row == 8) {
        JNSHUserManagerViewController *UserManagerVc = [[JNSHUserManagerViewController alloc] init];
        UserManagerVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:UserManagerVc animated:YES];
    }else if (indexPath.row == 9) {
        JNSHAgentManagerViewController *AgentManagerVc = [[JNSHAgentManagerViewController alloc] init];
        AgentManagerVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:AgentManagerVc animated:YES];
    }else if (indexPath.row == 10) {
        JNSHOrderManagerViewController *OrderVc = [[JNSHOrderManagerViewController alloc] init];
        OrderVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:OrderVc animated:YES];
    }else if (indexPath.row == 11) {
        JNSHFenRunManagerViewController *FenRunManagerVc = [[JNSHFenRunManagerViewController alloc] init];
        FenRunManagerVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:FenRunManagerVc animated:YES];
        
    }

}

- (void)requestForAgentInfo {
    
    NSDictionary *dic = @{
                          @"timestamp":[JNSHAutoSize getTimeNow]
                          };
    NSString *action = @"OrgStsDay";
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSString *code = resultDic[@"code"];
        //NSLog(@"%@",resultDic);
        if ([code isEqualToString:@"000000"]) {
            
            dayProfit = [NSString stringWithFormat:@"%@",resultDic[@"dayProfit"]];
            payCount = [NSString stringWithFormat:@"%@",resultDic[@"payCount"]];
            paySumPrice = [NSString stringWithFormat:@"%@",resultDic[@"paySumPrice"]];
            allProfit = [NSString stringWithFormat:@"%@",resultDic[@"allProfit"]];
            dayOrg = [NSString stringWithFormat:@"%@",resultDic[@"dayOrg"]];
            subAgent = [NSString stringWithFormat:@"%@",resultDic[@"childOrgCount"]];
            passUser = [NSString stringWithFormat:@"%@",resultDic[@"passUser"]];
            regUser = [NSString stringWithFormat:@"%@",resultDic[@"regUser"]];
            orgType = [NSString stringWithFormat:@"%@",resultDic[@"orgType"]];
            
            [table reloadData];
            
        }else {
            
            [JNSHAutoSize showMsg:code];
            
        }
    
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
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
