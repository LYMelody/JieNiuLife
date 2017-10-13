//
//  JNSHAgentMessageViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/10/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAgentMessageViewController.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSYUserInfo.h"
#import "JNSHAgentmsgCell.h"
#import "JNSHMessageDetailViewController.h"


@interface JNSHAgentMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *messageList;

@end

@implementation JNSHAgentMessageViewController {
    
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
    
    self.messageList = [[NSArray alloc] init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messageList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHAgentmsgCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        
        cell = [[JNSHAgentmsgCell alloc] init];
        cell.titleLab.text = self.messageList[indexPath.row][@"noticeTitle"];
        cell.timeLab.text = self.messageList[indexPath.row][@"noticeTime"];
        NSString *type = [NSString stringWithFormat:@"%@",self.messageList[indexPath.row][@"noticeType"]];
        if ([type isEqualToString:@"2"]) {
            cell.headimg.image = [UIImage imageNamed:@"message_head_portrait"];
        }else {
            cell.headimg.image = [UIImage imageNamed:@"message_notice"];
        }
        NSString *read = [NSString stringWithFormat:@"%@",self.messageList[indexPath.row][@"readed"]];
        if ([read isEqualToString:@"0"]) { //未读
            cell.isRead = NO;
        }else {
            cell.isRead = YES;
        }
    }
    //cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 51;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    

    if (indexPath.row == 0) {
        
        
    }
    
    //获取消息列表
    [self getMessage:[NSString stringWithFormat:@"%@",self.messageList[indexPath.row][@"id"]]];
    
    JNSHAgentmsgCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
}

//根据类型获取系统消息和活动消息
- (void)getMessage:(NSString *)type {
    
    NSDictionary *dic = @{
                          
                          @"id":type
                          };
    NSString *action = @"OrgMsgDetail";
    
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
            //NSLog(@"消息:%@",resultDic);
            
               
                JNSHMessageDetailViewController *Vc = [[JNSHMessageDetailViewController alloc] init];
                Vc.AgentName = resultDic[@"noticeContent"];
                Vc.AgentType = [NSString stringWithFormat:@"%@",resultDic[@"noticeType"]];
                Vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:Vc animated:YES];
            
            
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
                          @"page":@"0"
                          };
    NSString *action = @"OrgMsgList";
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
           
            NSLog(@"消息列表:%@",resultDic);
            
            if([resultDic[@"records"] isKindOfClass:[NSArray class]]) {
                
                
                self.messageList = resultDic[@"records"];
                
                
            }
            
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
