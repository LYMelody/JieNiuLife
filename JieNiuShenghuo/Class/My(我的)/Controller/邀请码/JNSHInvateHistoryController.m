//
//  JNSHInvateHistoryController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/18.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHInvateHistoryController.h"
#import "JNSHInvateHistoryCell.h"
#import "Masonry.h"
#import "Controller.h"
#import "JNSHAlertView.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"

@interface JNSHInvateHistoryController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHInvateHistoryController

- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    
    self.title = @"邀请记录";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backimg = self.navigationController.navigationBar.subviews.firstObject;
    backimg.alpha = 1;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *backimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    backimg.userInteractionEnabled = YES;
    backimg.backgroundColor = ColorTabBarBackColor;
    [self.view addSubview:backimg];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight - 64)];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
   
    
    [self.view addSubview:table];
    
    //headerView
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:50])];
    headerView.backgroundColor = ColorTableBackColor;
    headerView.userInteractionEnabled = YES;
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"邀请5位好友可兑换会员资格";
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = ColorText;
    titleLab.textAlignment = NSTextAlignmentLeft;
    
    [headerView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:260], [JNSHAutoSize height:15]));
    }];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
    changeBtn.layer.cornerRadius = 2;
    changeBtn.layer.masksToBounds = YES;
    [changeBtn setBackgroundColor:ColorTabBarBackColor];
    [changeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    [changeBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:changeBtn];
    
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).offset(-[JNSHAutoSize width:23]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize height:25]));
    }];
    
    if (self.tag == 2) {
        [changeBtn setBackgroundColor:[UIColor grayColor]];
        changeBtn.alpha = 0.5;
        changeBtn.enabled = NO;
    }else {
        [changeBtn setBackgroundColor:ColorTabBarBackColor];
        changeBtn.alpha = 1;
        changeBtn.enabled = YES;
    }
    
    
    table.tableHeaderView = headerView;
    
    //footView
    
    UIImageView *footImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:80])];
    footImageView.backgroundColor = ColorTableBackColor;
    footImageView.userInteractionEnabled = YES;
    
    UILabel *footLab = [[UILabel alloc] init];
    footLab.text = @"查看已兑换名单>>";
    footLab.font = [UIFont systemFontOfSize:13];
    footLab.textAlignment = NSTextAlignmentCenter;
    footLab.textColor = ColorText;
    
    [footImageView addSubview:footLab];
    
    [footLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footImageView);
        make.size.equalTo(footImageView);
    }];
    
    table.tableFooterView = footImageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.numberOfTapsRequired = 1;
    
    [footImageView addGestureRecognizer:tap];
    
    if(self.tag == 2) {
        table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    
    
    [self getFriendsList:@"0"];
    
}

//查看已兑换名单
- (void)tap {
    
    JNSHInvateHistoryController *invateHistoryVc = [[JNSHInvateHistoryController alloc] init];
    invateHistoryVc.tag = 2;
    invateHistoryVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:invateHistoryVc animated:YES];
    
}

//兑换按钮
- (void)change {
    
   
    
    
    JNSHAlertView *alertView = [[JNSHAlertView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) cancle:@"取消" sure:@"确定"];
    __block typeof(JNSHAlertView) *alert = alertView;
    alertView.sureAlertBlock = ^{
         NSLog(@"兑换");
        [alert dismiss];
    };
    [alertView show:@"确定用3个邀请名额兑换\n30天会员权益?" inView:self.view];
    
}

//获取邀请好友列表
- (void)getFriendsList:(NSString *)isCharge {
    
    NSDictionary *dic = @{
                          @"isCharge":isCharge
                          };
    NSString *action = @"UserInviteList";
    
    NSDictionary *requstDic = @{
                                @"action":action,
                                @"data":dic,
                                @"token":[JNSYUserInfo getUserInfo].userToken
                                };
    
    NSString *params = [requstDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        NSLog(@"%@",resultdic);
        NSString *msg = resultdic[@"msg"];
        if ([code isEqualToString:@"000000"]) {
            
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    if (self.tag == 2) {
        return 9;
    }
    
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHInvateHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHInvateHistoryCell alloc] init];
        if (self.tag == 2) {
            if (indexPath.row == 3) {
                cell.statusLab.text = @"已完成";
                cell.statusLab.textColor = greenColor;
            }else if (indexPath.row > 3) {
                cell.statusLab.text = @"已完成";
                cell.statusLab.textColor = greenColor;
                cell.isUsed = YES;
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [JNSHAutoSize height:51];
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    Controller *ctr = [[Controller alloc] init];
//    ctr.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:ctr animated:YES];
    
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
