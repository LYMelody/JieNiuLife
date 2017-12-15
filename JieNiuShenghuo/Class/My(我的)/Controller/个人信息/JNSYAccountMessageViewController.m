//
//  JNSYAccountMessageViewController.m
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/5/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSYAccountMessageViewController.h"
#import "JNSHCommon.h"
#import "JNSYHeaderTableViewCell.h"
#import "JNSHMyCommonCell.h"
#import "JNSYHeaderEditorViewController.h"
#import "JNSYNickNameViewController.h"
#import "JNSYSexSelectViewController.h"
#import "JNSYBornDateViewController.h"
#import "JNSHAccountInfoCell.h"
#import "JNSHAutoSize.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"

@interface JNSYAccountMessageViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>


@end

@implementation JNSYAccountMessageViewController {
    NSUserDefaults *User;
    UITableView *table;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];
        //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden = YES;
    
    User = [NSUserDefaults standardUserDefaults];
    //获取个人信息
    [self getAccountMsg];
    
    [table reloadData];
    
    self.navBarBgAlpha = @"1.0";
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
//    backImg.backgroundColor = ColorTabBarBackColor;
//    backImg.userInteractionEnabled = YES;
//    [self.view addSubview:backImg];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator = NO;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15)];
    
    [self.view addSubview:table];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
}

- (void)getAccountMsg {
    
    //时间戳
    NSString *timeSp = [JNSHAutoSize getTimeNow];
    
    NSDictionary *dic = @{
                          @"timestamp":timeSp
                          };
    NSString *action = @"UserBaseDetailState";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        //NSLog(@"%@,%@",resultdic,code);
        if([code isEqualToString:@"000000"]) {
            
            [JNSYUserInfo getUserInfo].userCode = resultdic[@"userCode"];
            [JNSYUserInfo getUserInfo].userPhone = resultdic[@"userPhone"];
            [JNSYUserInfo getUserInfo].userName = resultdic[@"userName"];
            [JNSYUserInfo getUserInfo].shopStates = resultdic[@"shopStates"];
            [JNSYUserInfo getUserInfo].userAccount = resultdic[@"userAccount"];
            [JNSYUserInfo getUserInfo].userCert = resultdic[@"userKey"];
            [JNSYUserInfo getUserInfo].userSex = [NSString stringWithFormat:@"%@",resultdic[@"sex"]] ;
            [JNSYUserInfo getUserInfo].birthday = resultdic[@"birthday"];
            //[JNSYUserInfo getUserInfo].addressInfo = resultdic[@"addressInfo"];
            [JNSYUserInfo getUserInfo].picHeader = resultdic[@"picHeader"];
            [JNSYUserInfo getUserInfo].lastIp = resultdic[@"lastIp"];
            [JNSYUserInfo getUserInfo].lastTime = resultdic[@"lastTime"];
            
            [table reloadData];
            
        }else {
            NSString *msg = resultdic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            JNSYHeaderTableViewCell *Cell = [[JNSYHeaderTableViewCell alloc] init];
            if (![[JNSYUserInfo getUserInfo].picHeader isEqualToString:@""]) {
                [Cell.headImg sd_setImageWithURL:[NSURL URLWithString:[JNSYUserInfo getUserInfo].picHeader]];
            }else {
                Cell.headImg.image = [UIImage imageNamed:@"my_head_portrait"];
            }
            
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else if (indexPath.row == 1) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"昵称";
            NSString *NickName = [User objectForKey:@"NickName"];
            NickName = [JNSYUserInfo getUserInfo].userName;
            if (NickName) {
                Cell.rightLab.text = NickName;
            }else {
                Cell.rightLab.text = @"捷牛生活";
            }
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }else if (indexPath.row == 2) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"性别";
//            Cell.leftLab.textColor = [UIColor blackColor];
//            Cell.leftLab.font = [UIFont systemFontOfSize:15];
//            Cell.rightLab.text = [[JNSYUserInfo getUserInfo].userSex integerValue]?@"男":@"女";
            if ([[JNSYUserInfo getUserInfo].userSex isEqualToString:@"0"]) {
                Cell.rightLab.text = @"女";
            }else if ([[JNSYUserInfo getUserInfo].userSex isEqualToString:@"1"]){
                Cell.rightLab.text = @"男";
            }else {
                Cell.rightLab.text = @"保密";
            }
            cell = Cell;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if (indexPath.row == 3) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"出生年月";
            NSString *birthDay = [JNSYUserInfo getUserInfo].birthday;
            if (birthDay &&![birthDay isEqualToString:@""]) {
                //Cell.rightLab.text = birthDay;
                NSString *front = [[JNSYUserInfo getUserInfo].birthday substringToIndex:4];
                NSString *mid = [[JNSYUserInfo getUserInfo].birthday substringWithRange:NSMakeRange(4, 2)];
                NSString *last = [[JNSYUserInfo getUserInfo].birthday substringWithRange:NSMakeRange(6, 2)];
                Cell.rightLab.text = [NSString stringWithFormat:@"%@-%@-%@",front,mid,last];
            }else {
                Cell.rightLab.text = @"";
            }
            
            Cell.isLast = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }

    }
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        return 70;
    }else
    {
        return 44;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) { //头像
        JNSYHeaderEditorViewController *Vc = [[JNSYHeaderEditorViewController alloc] init];
        
//        Vc.changeHeadeImgBlock = ^{
//            [table reloadData];
//        };
        
//        if (_changeHeaderImgBlock) {
//            _changeHeaderImgBlock();
//        }
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Vc animated:YES];
        
    }else if (indexPath.row == 1) {  //昵称
        JNSYNickNameViewController *NickVc = [[JNSYNickNameViewController alloc] init];
        NickVc.changeNickBlock = ^{
            [table reloadData];
        };
        NickVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:NickVc animated:YES];
        
    }else if (indexPath.row == 2) {  //性别
//        JNSYSexSelectViewController *SexvC = [[JNSYSexSelectViewController alloc] init];
////        SexvC.ChangeSexBlock = ^{
////            [tableView reloadData];
////        };
//        SexvC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:SexvC animated:YES];
    }else if (indexPath.row == 3) {
  
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
