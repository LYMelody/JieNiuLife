//
//  JNSHMyViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/2.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHMyViewController.h"
#import "JNSHMyHeaderCell.h"
#import "JNSHMyCommonCell.h"
#import "Masonry.h"
#import "JNSHVipViewController.h"
#import "JNSYAccountMessageViewController.h"
#import "JNSHSettingViewController.h"
#import "JNSHReallNameController.h"
#import "JNSHSettlementCardController.h"
#import "JNSHSettleDetailController.h"
#import "JNSHOrderViewController.h"
#import "JNSHTicketsController.h"
#import "JNSHInvateController.h"
#import "JNSHLoginController.h"
#import "JNSHBecomeAgentViewController.h"
#import "JNSYUserInfo.h"
#import "JNSHAutoSize.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "JNSHCommitEmailViewController.h"
#import "JNSHAgentPayViewController.h"
#import "JNSHAgentDetailViewController.h"

@interface JNSHMyViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@end

@implementation JNSHMyViewController {
    
    UIImageView *barBackImg;
    UIImageView *headImageView;
    UITableView *table;
    BOOL islogoedIn;
    BOOL isVip;
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];

    self.navigationController.navigationBar.translucent = NO;
    //[[UINavigationBar appearance] setTranslucent:NO];
    //隐藏黑线
    self.navigationController.navigationBar.subviews[0].subviews[0].hidden = YES;
    
    [super viewDidAppear:animated];
    
//    barBackImg = self.navigationController.navigationBar.subviews.firstObject;
//    barBackImg.alpha = 0;
    self.navigationItem.title = @"";
    
    self.navBarBgAlpha = @"0.0";
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //判断是否登录
    if ([JNSYUserInfo getUserInfo].isLoggedIn) {
        [self getBaseInfo];
    }
    
    [table reloadData];
    self.navigationController.delegate = self;
    
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (self.childViewControllers.count == 1) {
        return NO;
    }
    
    CGFloat x = [gestureRecognizer locationInView:self.view].x;
    
    NSLog(@"%f",x);
    return YES;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    islogoedIn = NO;
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //设置按钮
    UIButton *SettingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [SettingBtn setImage:[UIImage imageNamed:@"my_head_set"] forState:UIControlStateNormal];
    [SettingBtn addTarget:self action:@selector(Setting) forControlEvents:UIControlEventTouchUpInside];
    SettingBtn.frame = CGRectMake(0, 0, 36, 36);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:SettingBtn];
    
    //取消tableView自动布局
    //self.automaticallyAdjustsScrollViewInsets = NO;
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, -64, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
    table.showsVerticalScrollIndicator = YES;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    //顶部背景色
    headImageView = [[UIImageView alloc] init];
    headImageView.frame = CGRectMake(0, -200, KscreenWidth, 200);
    headImageView.backgroundColor = ColorTabBarBackColor;
    [table addSubview:headImageView];
    
}

//设置按钮跳转
- (void)Setting {
    
    JNSHSettingViewController *SettingVc = [[JNSHSettingViewController alloc] init];
    SettingVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:SettingVc animated:YES];
    
}

//获取用户基本信息
- (void)getBaseInfo {
    
    NSString *timestamp = [JNSHAutoSize getTimeNow];
    
    NSDictionary *dic = @{
                          @"timestamp":timestamp
                          };
    
    NSString *action = @"UserBaseInfoState";
    
    NSLog(@"%@",[JNSYUserInfo getUserInfo].userToken);
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        if([code isEqualToString:@"000000"]) {
            
            [JNSYUserInfo getUserInfo].userCode = resultdic[@"userCode"];
            [JNSYUserInfo getUserInfo].userPhone = resultdic[@"userPhone"];
            [JNSYUserInfo getUserInfo].userAccount = resultdic[@"userAccount"];
            [JNSYUserInfo getUserInfo].userCert = resultdic[@"userCert"];
            [JNSYUserInfo getUserInfo].userPoints = resultdic[@"userPoints"];
            [JNSYUserInfo getUserInfo].userSex = [NSString stringWithFormat:@"%@",resultdic[@"sex"]];
            [JNSYUserInfo getUserInfo].picHeader = resultdic[@"picHeader"];
            [JNSYUserInfo getUserInfo].userVipFlag = [NSString stringWithFormat:@"%@",resultdic[@"vipFig"]];
            [JNSYUserInfo getUserInfo].userQr = resultdic[@"picQr"];
            [JNSYUserInfo getUserInfo].birthday = resultdic[@"birthday"];
            [JNSYUserInfo getUserInfo].SettleCard = resultdic[@"userBank"];
            
            //实名认证状态
            NSString *userStatus = resultdic[@"userStatus"];
            if ([userStatus isEqualToString:@"11"]) {
                [JNSYUserInfo getUserInfo].userStatus = @"待审核";
            }else if ([userStatus isEqualToString:@"12"]){
                [JNSYUserInfo getUserInfo].userStatus = @"审核驳回";
            }else if ([userStatus isEqualToString:@"20"]) {
                [JNSYUserInfo getUserInfo].userStatus = @"审核通过";
            }else if([userStatus isEqualToString:@"10"]){
                [JNSYUserInfo getUserInfo].userStatus = @"初始化";
            }else if ([userStatus isEqualToString:@"19"]) {
                [JNSYUserInfo getUserInfo].userStatus = @"初审通过";
            }else if ([userStatus isEqualToString:@"30"]) {
                [JNSYUserInfo getUserInfo].userStatus = @"系统风控";
            }else {
                [JNSYUserInfo getUserInfo].userStatus = @"停用删除";
            }
            //判断是否是Vip  g    0:未开通 1:开通有效 2:开通已到期
            if ([[JNSYUserInfo getUserInfo].userVipFlag isEqualToString:@"1"]) {
                
                isVip = YES;
                
            }
            //刷新视图
            [table reloadData];
            
        }else {
            NSString *msg = resultdic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
    } failure:^(NSError *error) {
        
        //[JNSYAutoSize showMsg:error];
        
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 16;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            cell.backgroundColor = ColorTabBarBackColor;
        }else if (indexPath.row == 1) {
            
            JNSHMyHeaderCell *Cell = [[JNSHMyHeaderCell alloc] init];
            Cell.headerView.image = [UIImage imageNamed:@"my_head_portrait"];
            Cell.nickNameLab.text = [JNSYUserInfo getUserInfo].userNick;
            Cell.phoneLab.text = [[JNSYUserInfo getUserInfo].userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            islogoedIn = [JNSYUserInfo getUserInfo].isLoggedIn;
            //判断是否是Vip
            if (isVip) {
                Cell.showVip = YES;
            }else {
                Cell.showVip = NO;
            }
            if (![[JNSYUserInfo getUserInfo].picHeader isEqualToString:@""]) {
                [Cell.headerView sd_setImageWithURL:[NSURL URLWithString:[JNSYUserInfo getUserInfo].picHeader]];
            }else {
                Cell.headerView.image = [UIImage imageNamed:@"my_head_portrait"];
            }
            if (islogoedIn) {
                Cell.isLogoedIn = YES;
                Cell.nickNameLab.text = [JNSYUserInfo getUserInfo].userNick;
            }else {
                
                Cell.isLogoedIn = NO;
            }
            
            cell = Cell;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if (indexPath.row == 2|| indexPath.row == 4||indexPath.row == 7 || indexPath.row == 10 || indexPath.row == 14) {
            
            cell.backgroundColor = ColorTableBackColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if (indexPath.row == 3) {
            
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"my_vip"];
            Cell.titleLab.text = @"会员中心";
            if (isVip) {
                Cell.rightLab.text = @"20天后到期";
            }else {
                Cell.rightLab.text = @"立即开通";
            }
            
            Cell.showBottomLine = YES;
            Cell.showTopLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 5) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"my_Certification"];
            Cell.titleLab.text = @"实名认证";
            Cell.rightLab.text = [JNSYUserInfo getUserInfo].userStatus;
            Cell.showTopLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 6) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"my_card"];
            Cell.titleLab.text = @"结算卡";
            if (![[JNSYUserInfo getUserInfo].SettleCard isEqualToString:@""] && ([JNSYUserInfo getUserInfo].SettleCard != nil)) {
                Cell.rightLab.text = @"已绑定";
                Cell.rightLab.textColor = GreenColor;
            }else {
                Cell.rightLab.text = @"待绑定";
            }
            Cell.showBottomLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 8) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"my_order"];
            Cell.titleLab.text = @"订单";
            Cell.rightLab.text = @"";
            Cell.showTopLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 9) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"my_coupon"];
            Cell.titleLab.text = @"卡券包";
            Cell.rightLab.text = @"";
            Cell.showBottomLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 11) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"my_invite-code"];
            Cell.titleLab.text = @"邀请码";
            Cell.rightLab.text = @"";
            Cell.showTopLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 12) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"my_phone"];
            Cell.titleLab.text = @"客服电话";
            Cell.rightLab.text = @"400-600-7909";
            cell = Cell;
        }else if (indexPath.row == 13) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"my_instructions"];
            Cell.titleLab.text = @"使用说明";
            Cell.rightLab.text = @"";
            Cell.showBottomLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 15) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"my_agent"];
            Cell.titleLab.text = @"代理商";
            Cell.rightLab.text = @"";
            Cell.showBottomLine = YES;
            Cell.showTopLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 64;
    }else if (indexPath.row == 1) {
        return 74;
    }else if (indexPath.row == 2) {
        return 20;
    }else if (indexPath.row == 4||indexPath.row == 7 || indexPath.row == 10 || indexPath.row == 14){
        return 10;
    }
    
    return 44;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) { //个人信息

        if (islogoedIn) {
            JNSYAccountMessageViewController *AccountVc = [[JNSYAccountMessageViewController alloc] init];
            AccountVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:AccountVc animated:YES];
        }else {
            JNSHLoginController *LogInVc = [[JNSHLoginController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:LogInVc];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
        
    }
    
    if (indexPath.row == 3) {  //会员
        
        if (islogoedIn) {
            JNSHVipViewController *VipVc = [[JNSHVipViewController alloc] init];
            VipVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VipVc animated:YES];
        }else {
            JNSHLoginController *LogInVc = [[JNSHLoginController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:LogInVc];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
        
       
    }else if (indexPath.row == 5) {  //实名认证
        
        if (islogoedIn) {
            JNSHReallNameController *RealNameVc = [[JNSHReallNameController alloc] init];
            RealNameVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:RealNameVc animated:YES];
        }else {
            JNSHLoginController *LogInVc = [[JNSHLoginController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:LogInVc];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
        
       
    }else if (indexPath.row == 6) { //结算卡
        
        
        if (islogoedIn) {
            
            if ((![[JNSYUserInfo getUserInfo].SettleCard isEqualToString:@""]) &&([JNSYUserInfo getUserInfo].SettleCard != nil)) {
                
                JNSHSettleDetailController *Detail = [[JNSHSettleDetailController alloc] init];
                Detail.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:Detail animated:YES];

            }else {
                JNSHSettlementCardController *CardVc = [[JNSHSettlementCardController alloc] init];
                CardVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:CardVc animated:YES];
            }
            
        }else {
            JNSHLoginController *LogInVc = [[JNSHLoginController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:LogInVc];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
        
    }else if (indexPath.row == 8) {   //订单
        
        if (islogoedIn) {
            JNSHOrderViewController *OrderVc = [[JNSHOrderViewController alloc] init];
            OrderVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:OrderVc animated:YES];
            
        }else {
            JNSHLoginController *LogInVc = [[JNSHLoginController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:LogInVc];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
        
       
        
    }else if (indexPath.row == 9) {    //卡包券
        
        
        if (islogoedIn) {
            JNSHTicketsController *ticketVc = [[JNSHTicketsController alloc] init];
            ticketVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ticketVc animated:YES];
            
        }else {
            JNSHLoginController *LogInVc = [[JNSHLoginController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:LogInVc];
            
            [self presentViewController:nav animated:YES completion:nil];
        }

        
      
        
        
    }else if (indexPath.row == 11) {  //邀请码
        
        if (islogoedIn) {
            JNSHInvateController *InvateVc = [[JNSHInvateController alloc] init];
            InvateVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:InvateVc animated:YES];
            
        }else {
            JNSHLoginController *LogInVc = [[JNSHLoginController alloc] init];
            
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:LogInVc];
            
            [self presentViewController:nav animated:YES completion:nil];
        }
        
    }else if (indexPath.row == 12) {  //客服电话
        
        JNSHMyCommonCell *cell = [table cellForRowAtIndexPath:indexPath];
        cell.selected = NO;
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",@"400-600-7909"]]];
        
    }
    else if (indexPath.row == 15) {     //代理商
        if (islogoedIn) {
            //获取代理商信息
            if ([[JNSYUserInfo getUserInfo].userCert isEqualToString:@""] ) {
                [JNSHAutoSize showMsg:@"请先实名认证"];
                return;
            }else if ([[JNSYUserInfo getUserInfo].SettleCard isEqualToString:@""]) {
                [JNSHAutoSize showMsg:@"请先绑定结算卡"];
                return;
            }
            else {
                [self getAgentInfo];
            }
        }else {
            JNSHLoginController *LogInVc = [[JNSHLoginController alloc] init];
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:LogInVc];
            [self presentViewController:nav animated:YES completion:nil];
        }
    }
}

//获取代理商信息
- (void)getAgentInfo {
    
    NSDictionary *dic = @{
                          @"timestamp":[JNSHAutoSize getTimeNow]
                          };
    NSString *action = @"UserOrgInfo";
    
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
        NSLog(@"%@",resultDic);
        if ([code isEqualToString:@"000000"]) {
            //代理商状态
            NSString *orgStatus = [NSString stringWithFormat:@"%@",resultDic[@"orgStatus"]];
            if ([orgStatus isEqualToString:@"0"]) {   //未申请
                
                JNSHBecomeAgentViewController *BecomeAgentVc = [[JNSHBecomeAgentViewController alloc] init];
                BecomeAgentVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:BecomeAgentVc animated:YES];
                
            }else if ([orgStatus isEqualToString:@"1"] || [orgStatus isEqualToString:@"3"]) {  //等待审核、审核驳回
                
                JNSHCommitEmailViewController *CommitEmailVc = [[JNSHCommitEmailViewController alloc] init];
                CommitEmailVc.message = [NSString stringWithFormat:@"%@",orgStatus];
                CommitEmailVc.email = resultDic[@"userEmail"];
                CommitEmailVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:CommitEmailVc animated:YES];
                
            }else if ([orgStatus isEqualToString:@"2"])  {  //审核通过
//
//                JNSHAgentDetailViewController *payVc = [[JNSHAgentDetailViewController alloc] init];
//                payVc.hidesBottomBarWhenPushed = YES;
//                [self.navigationController pushViewController:payVc animated:YES];
//
                JNSHBecomeAgentViewController *BecomeAgentVc = [[JNSHBecomeAgentViewController alloc] init];
                BecomeAgentVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:BecomeAgentVc animated:YES];
                
            }else if ([orgStatus isEqualToString:@"9"]) {   //等待支付
                
                JNSHAgentPayViewController *PayVc = [[JNSHAgentPayViewController alloc] init];
                PayVc.payOrder = resultDic[@"payOrder"];
                PayVc.payPrice = [NSString stringWithFormat:@"%@",resultDic[@"payPrice"]];
                PayVc.orgType = [NSString stringWithFormat:@"%@",resultDic[@"orgType"]];
                PayVc.email = resultDic[@"userEmail"];
                PayVc.taskId = [NSString stringWithFormat:@"%@",resultDic[@"taskId"]];
                PayVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:PayVc animated:YES];
                
            }
        
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat y = scrollView.contentOffset.y;
    
    //NSLog(@"移动:%f",y);
    
    //控制导航栏的透明度
    if (y >= 64) {
        //隐藏黑线
        self.navigationController.navigationBar.subviews[0].subviews[0].hidden = NO;
        
        //barBackImg.alpha = 1;
        self.navBarBgAlpha = @"1.0";
        self.navigationItem.title = @"我";
        
    }else if (y < 64) {
        self.navBarBgAlpha = @"0.0";
        self.navigationItem.title = @"";
        
    }
    
    //控制背景色
    if (y < 0) {
        CGRect frame = headImageView.frame;
        frame.origin.y = y;
        frame.size.height = -y;
        headImageView.frame = frame;
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
