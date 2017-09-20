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
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "JNSYUserInfo.h"
#import "UIImageView+WebCache.h"

#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKUI/SSUIEditorViewStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import "WeiboSDK.h"



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
    
    
    self.navBarBgAlpha = @"1.0";
    
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
    
    
    UIImageView *navImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, KscreenWidth, 64)];
    navImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navImg];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"invited_record"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, 38, 38);
    [rightBtn addTarget:self action:@selector(InvateHistory) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0 , 0, KscreenWidth, KscreenHeight - 64)];
    backImg.image = [UIImage imageNamed:@"形状-5-拷贝"];
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    //二维码
    UIImageView *erCodeImg = [[UIImageView alloc] init];
    //erCodeImg.image = [UIImage imageNamed:@"invite_QR-code"];
    [erCodeImg sd_setImageWithURL:[NSURL URLWithString:[JNSYUserInfo getUserInfo].userQr]];
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
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"邀请码 %@",[JNSYUserInfo getUserInfo].userPhone]];
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
    
    //分享
    UIImageView *ShareImageView = [[UIImageView alloc] init];
    ShareImageView.image = [UIImage imageNamed:@"invite_share"];
    [ShareImageView setBackgroundColor:[UIColor clearColor]];
    
    [backImg addSubview:ShareImageView];
    
    [ShareImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImg);
        make.top.equalTo(detailLab.mas_bottom).offset([JNSHAutoSize height:20]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:22]));
    }];
    
    UIImageView *whiteBack = [[UIImageView alloc] init];
    whiteBack.backgroundColor = [UIColor whiteColor];
    whiteBack.userInteractionEnabled = YES;
    whiteBack.layer.cornerRadius = 3;
    [backImg addSubview:whiteBack];
    
    [whiteBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ShareImageView.mas_bottom).offset([JNSHAutoSize height:14]);
        make.left.equalTo(backImg).offset([JNSHAutoSize width:15]);
        make.right.equalTo(backImg).offset(-[JNSHAutoSize height:15]);
        make.height.mas_equalTo([JNSHAutoSize height:81]);
    }];
    //微信好友
    UIButton *WeChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    WeChatBtn.tag = 100;
    [WeChatBtn setImage:[UIImage imageNamed:@"invite_wechat"] forState:UIControlStateNormal];
    [WeChatBtn setImage:[UIImage imageNamed:@"invite_wechat"] forState:UIControlStateHighlighted];
    [WeChatBtn setBackgroundColor:[UIColor clearColor]];
    [WeChatBtn addTarget:self action:@selector(Share:) forControlEvents:UIControlEventTouchUpInside];
    [whiteBack addSubview:WeChatBtn];
    
    [WeChatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(whiteBack);
        //make.top.equalTo(whiteBack).offset([JNSHAutoSize height:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:58], [JNSHAutoSize height:60]));
        make.left.equalTo(whiteBack).offset([JNSHAutoSize width:48]);
        
    }];
    
    //朋友圈
    UIButton *FriendsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    FriendsBtn.tag = 101;
    [FriendsBtn setImage:[UIImage imageNamed:@"invite_wechat_-"] forState:UIControlStateNormal];
    [FriendsBtn setImage:[UIImage imageNamed:@"invite_wechat_-"] forState:UIControlStateHighlighted];
    [FriendsBtn setBackgroundColor:[UIColor clearColor]];
    [FriendsBtn addTarget:self action:@selector(Share:) forControlEvents:UIControlEventTouchUpInside];
    [whiteBack addSubview:FriendsBtn];
    
    [FriendsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(whiteBack);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:58], [JNSHAutoSize height:60]));
    }];
    
    //新浪微博
    UIButton *WeiBoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    WeiBoBtn.tag = 102;
    [WeiBoBtn setImage:[UIImage imageNamed:@"invite_weibo"] forState:UIControlStateNormal];
    [WeiBoBtn setImage:[UIImage imageNamed:@"invite_weibo"] forState:UIControlStateHighlighted];
    [WeiBoBtn setBackgroundColor:[UIColor clearColor]];
    [WeiBoBtn addTarget:self action:@selector(Share:) forControlEvents:UIControlEventTouchUpInside];
    [whiteBack addSubview:WeiBoBtn];
    
    [WeiBoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(whiteBack);
        make.top.equalTo(FriendsBtn);
        make.right.equalTo(whiteBack).offset(-[JNSHAutoSize width:48]);
        make.size.mas_equalTo(FriendsBtn);
    }];
    
    
}

//分享
- (void)Share:(UIButton *)btn {
    
    SSDKPlatformType type;
    
    
    if (btn.tag == 100) {
        
        type = SSDKPlatformSubTypeWechatSession;
        
        NSLog(@"分享给微信好友");
    }else if (btn.tag == 101) {
        type = SSDKPlatformSubTypeWechatTimeline;
        NSLog(@"分享到朋友圈");
    }else {
        type = SSDKPlatformTypeSinaWeibo;
        NSLog(@"分享到新浪微博");
    }
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"捷牛生活-logo-"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"http://ktb.4006007909.com/down"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://ktb.4006007909.com/down"]
                                          title:@"卡捷通APP不止于收款，欢迎您下载使用"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        [ShareSDK share:type parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            switch (state) {
                case SSDKResponseStateSuccess:
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                        message:nil
                                                                       delegate:nil
                                                              cancelButtonTitle:@"确定"
                                                              otherButtonTitles:nil];
                    [alertView show];
                    break;
                }
                case SSDKResponseStateFail:
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                    message:[NSString stringWithFormat:@"%@",error]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil, nil];
                    [alert show];
                    break;
                }
                default:
                    break;
            }
        }];
    }
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
