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
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
@interface JNSHInvateHistoryController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHInvateHistoryController {
    
    UITableView *table;
    UIButton *changeBtn;
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    
    self.title = @"邀请记录";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
   self.navBarBgAlpha = @"1.0";
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64)];
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
    titleLab.text = @"邀请3位好友可兑换会员资格";
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = ColorText;
    titleLab.textAlignment = NSTextAlignmentLeft;
    
    [headerView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:260], [JNSHAutoSize height:15]));
    }];
    
    changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
    [changeBtn setBackgroundColor:[UIColor grayColor]];
    changeBtn.alpha = 0.5;
    changeBtn.enabled = NO;
    
//    if (self.tag == 2) {
//        [changeBtn setBackgroundColor:[UIColor grayColor]];
//        changeBtn.alpha = 0.5;
//        changeBtn.enabled = NO;
//    }else {
//        [changeBtn setBackgroundColor:ColorTabBarBackColor];
//        changeBtn.alpha = 1;
//        changeBtn.enabled = YES;
//    }
    
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
    
    
    //获取兑换信息
    [self requestFriendsInfo];
    
    //获取兑换好友列表
   // [self getFriendsList:@"0"];
    //已过期
    if(self.tag == 2) {
        [self getFriendsList:@"1"];
    }else {
        [self getFriendsList:@"0"];
    }
    
    
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
        [self requestForVip];
    
        [alert dismiss];
    };
    [alertView show:@"确定用3个邀请名额兑换\n30天会员权益?" inView:self.view];
    
}

//获取兑换信息(是否可兑换)
- (void)requestFriendsInfo{
    
    NSDictionary *dic = @{
                          @"timestamp":[JNSHAutoSize getTimeNow],

                          };
    NSString *action = @"UserInviteDetail";
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSString *code = resultDic[@"code"];
        NSLog(@"%@",resultDic);
        if ([code isEqualToString:@"000000"]) {
            
            NSString *ischarge = [NSString stringWithFormat:@"%@",resultDic[@"isCharge"]];
            if ([ischarge isEqualToString:@"1"]) {
                [changeBtn setBackgroundColor:ColorTabBarBackColor];
                changeBtn.alpha = 1;
                changeBtn.enabled = YES;
            }
            
        }else {
            NSString *msg = resultDic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//兑换会员
- (void)requestForVip {
    
    NSInteger count = 0;
    
    if(self.listArray.count >=3) {
        
        count = self.listArray.count/3*3;
        
    }else {
        count = 3;
    }
    
    NSDictionary *dic = @{
                          @"chargeUser":[NSString stringWithFormat:@"%ld",count],
                          @"chargeDay":[NSString stringWithFormat:@"%ld",(long)count*10]
                          };
    NSString *action = @"UserInviteExchange";
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSString *code = resultDic[@"code"];
        if ([code isEqualToString:@"000000"]) {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"兑换成功!";
            [hud hide:YES afterDelay:1.5];
            [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
        }else {
            NSString *msg = resultDic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)back {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
        //NSLog(@"%@",resultdic);
        NSString *msg = resultdic[@"msg"];
        if ([code isEqualToString:@"000000"]) {
            
            if ([resultdic[@"records"] isKindOfClass:[NSArray class]]) {
                self.listArray = resultdic[@"records"];
                [table reloadData];
            }
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
//    if (self.tag == 2) {
//        return 9;
//    }
    
    return self.listArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHInvateHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHInvateHistoryCell alloc] init];
        
        NSDictionary *dic =self.listArray[indexPath.row];
        NSString *picHeader = dic[@"picHeader"];             //头像
        NSString *userNick = dic[@"userNick"];               //昵称
        NSString *userPhone = dic[@"userPhone"];             //电话
        NSString *isComplete = [NSString stringWithFormat:@"%@",dic[@"isOver"]];                 //是否已完成
        cell.nameLab.text = userNick;
        cell.phoneLab.text = [userPhone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
        //设置头像
        if ([picHeader isEqualToString:@""]) {
            
        }else {
            [cell.headerImg sd_setImageWithURL:[NSURL URLWithString:picHeader]];
        }
        //设置是否完成
        if (![isComplete isEqualToString:@"0"]) {
            cell.statusLab.text = @"已完成";
            cell.statusLab.textColor = GreenColor;
        }
        if (self.tag == 2) {
           
            cell.statusLab.text = @"已完成";
            cell.statusLab.textColor = GreenColor;
            cell.isUsed = YES;
            
        }else {
            
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
