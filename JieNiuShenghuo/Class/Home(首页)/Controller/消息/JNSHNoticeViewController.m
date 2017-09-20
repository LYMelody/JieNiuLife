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
#import "SBJSON.h"
#import "JNSYUserInfo.h"
#import "IBHttpTool.h"
#import "JNSHSystemMessageModel.h"
#import "JNSHActiveMessageController.h"

@interface JNSHNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHNoticeViewController {
    
    UITableView *table;
    NSString *activeLastMsg;
    NSString *activeLastMsgTime;
    NSString *activeUnRead;
    NSString *systemLastMSG;
    NSString *systemLastMsgTime;
    NSString *systemUnRead;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"消息";
    
    self.view.backgroundColor = ColorTabBarBackColor;
    
    self.navigationController.navigationBar.translucent = NO;
    
    //获取消息
    [self requestForAllMessage];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //灰色背景
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
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
            cell.messageLab.text = systemLastMSG;
            cell.timeLab.text = systemLastMsgTime;
            cell.badge = [systemUnRead integerValue];
        }else {
            cell.leftImg.image = [UIImage imageNamed:@"notice2"];
            cell.titleLab.text = @"活动通知";
            cell.messageLab.text = activeLastMsg;
            cell.timeLab.text = activeLastMsgTime;
            cell.badge = [activeUnRead integerValue];
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
    
//    JNSHMessageListCell *cell = [table cellForRowAtIndexPath:indexPath];
//    cell.badge = 0;
    
    if (indexPath.row == 0) {
        
        
    }
    
    //获取消息列表
    [self getMessage:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
    
}

//根据类型获取系统消息和活动消息
- (void)getMessage:(NSString *)type {
    
    NSDictionary *dic = @{
                          @"noticeType":type,
                          @"page":@"0"
                          };
    NSString *action = @"UserNoticeMsgListState";
    
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
        if ([code isEqualToString:@"000000"]) {
            NSLog(@"消息:%@",resultDic);
            if([resultDic[@"records"] isKindOfClass:[NSArray class]]) {
                if ([type isEqualToString:@"1"]) {   //系统通知
                    
                    JNSHSystemViewController *Systemvc = [[JNSHSystemViewController alloc] init];
                    Systemvc.messageList = resultDic[@"records"];
                    Systemvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:Systemvc animated:YES];
                    
                }else {   //活动通知
                    
                    JNSHActiveMessageController *ActiveVc = [[JNSHActiveMessageController alloc] init];
                    ActiveVc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:ActiveVc animated:YES];
                    
                }
            }
            
            
            
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


//获取消息
- (void)requestForAllMessage {
    
    NSDictionary *dic = @{
                          @"timestamp":[JNSHAutoSize getTimeNow]
                          };
    NSString *action = @"UserNoticeMsg";
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSString *code = resultDic[@"code"];
        //NSLog(<#NSString * _Nonnull format, ...#>)
        if([code isEqualToString:@"000000"]) {
            activeLastMsg = resultDic[@"activeLastMsg"];
            activeLastMsgTime = resultDic[@"activeLastMsgTime"];
            activeUnRead = [NSString stringWithFormat:@"%@",resultDic[@"activeUnRead"]];
            systemLastMSG = resultDic[@"systemLastMsg"];
            systemLastMsgTime = resultDic[@"systemLastMsgTime"];
            systemUnRead = [NSString stringWithFormat:@"%@",resultDic[@"systemUnRead"]];
            
            [table reloadData];
            
        }else {
            
            NSString *msg = resultDic[@"msg"];
            
            [JNSHAutoSize showMsg:msg];
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
