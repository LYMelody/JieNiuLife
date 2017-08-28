//
//  JNSHInvateController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/18.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHInvateController.h"
#import "Masonry.h"
#import "JNSHInvateHistoryController.h"
@interface JNSHInvateController ()

@end

@implementation JNSHInvateController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"我的邀请码";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:ColorTabBarBackColor
                                                                      
                                                                      }];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = ColorTabBarBackColor;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    UIImageView *backimg = self.navigationController.navigationBar.subviews.firstObject;
    backimg.alpha = 0;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBar.barTintColor = ColorTabBarBackColor;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      
                                                                      }];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"invited_record"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 38, 38);
    [rightBtn addTarget:self action:@selector(InvateHistory) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 64, KscreenWidth, KscreenHeight - 64)];
    backImg.image = [UIImage imageNamed:@"形状-5-拷贝"];
    
    [self.view addSubview:backImg];
    
    //二维码
    UIImageView *erCodeImg = [[UIImageView alloc] init];
    erCodeImg.image = [UIImage imageNamed:@"invite_QR-code"];
    
    [backImg addSubview:erCodeImg];
    
    [erCodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(backImg);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:175], [JNSHAutoSize height:175]));
    }];
    
    //邀请码
    UILabel *InvateCodeLab = [[UILabel alloc] init];
    InvateCodeLab.textColor = [UIColor whiteColor];
    InvateCodeLab.font = [UIFont systemFontOfSize:18];
    InvateCodeLab.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"邀请码 188 8888 8888"];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 3)];
    InvateCodeLab.attributedText = attr;
    
    [backImg addSubview:InvateCodeLab];
    
    [InvateCodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImg);
        make.top.equalTo(backImg).offset([JNSHAutoSize height:176]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:30]));
    }];
    
   
    //邀请信息
    UILabel *detailLab = [[UILabel alloc] init];
    detailLab.text = @"邀请3位好友兑换30天会员；6位好友60天；\n9位好友90天；以此类推，上不封顶。";
    detailLab.font = [UIFont systemFontOfSize:12];
    detailLab.textColor = [UIColor blackColor];
    detailLab.textAlignment = NSTextAlignmentCenter;
    detailLab.numberOfLines = 0;
    [backImg addSubview:detailLab];
    
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImg);
        make.top.equalTo(erCodeImg.mas_bottom).offset([JNSHAutoSize height:13]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:35]));
    }];
    
}

- (void)InvateHistory {
    
    NSLog(@"邀请记录");
    
    JNSHInvateHistoryController *InvateHisVc = [[JNSHInvateHistoryController alloc] init];
    InvateHisVc.tag = 1;
    InvateHisVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:InvateHisVc animated:YES];
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
