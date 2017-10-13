//
//  JNSHUsageViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/10/11.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHUsageViewController.h"
#import "JNSHMyCommonCell.h"
#import "JNSHUsageDetailViewController.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "AFNetworkReachabilityManager.h"
#import "JNSYUserInfo.h"

@interface JNSHUsageViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHUsageViewController {
    
    UITableView *table;
    UIButton *playBtn;
    UIButton *tipsBtn;
    UILabel *tipsLab;
   
}
- (void)viewWillAppear:(BOOL)animated {
    
    [table reloadData];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"操作说明";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    UIImageView *footView = [[UIImageView alloc] init];
    footView.frame = CGRectMake(0, 0, KscreenWidth, 400);
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.text = @"【视频教程】约20M，建议WiFi环境下观看，土豪随意！";
    titleLab.numberOfLines = 0;
    [footView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footView).offset([JNSHAutoSize height:10]);
        make.left.equalTo(footView).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth-40, [JNSHAutoSize height:38]));
    }];
    
    UIImageView *ViedoImgView = [[UIImageView alloc] init];
    ViedoImgView.backgroundColor = [UIColor blackColor];
    ViedoImgView.userInteractionEnabled = YES;
    [footView addSubview:ViedoImgView];
    [ViedoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset([JNSHAutoSize height:15]);
        make.left.equalTo(footView).offset([JNSHAutoSize width:15]);
        make.right.equalTo(footView).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:200]);
    }];
    
    playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playBtn setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [playBtn addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [ViedoImgView addSubview:playBtn];
    [playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ViedoImgView);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize width:70]));
    }];
    
    tipsBtn = [[UIButton alloc] init];
    tipsBtn.backgroundColor = [UIColor clearColor];
    tipsBtn.layer.borderWidth = 1;
    tipsBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    tipsBtn.layer.cornerRadius = 3;
    tipsBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    tipsBtn.titleLabel.textColor = [UIColor whiteColor];
    tipsBtn.hidden = YES;
    [tipsBtn addTarget:self action:@selector(playMovie) forControlEvents:UIControlEventTouchUpInside];
    [ViedoImgView addSubview:tipsBtn];
    [tipsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ViedoImgView);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:30]));
    }];
    
    
    tipsLab = [[UILabel alloc] init];
    tipsLab.font = [UIFont systemFontOfSize:15];
    tipsLab.textColor = [UIColor whiteColor];
    tipsLab.textAlignment = NSTextAlignmentCenter;
    tipsLab.numberOfLines = 0;
    tipsLab.hidden = YES;
    [ViedoImgView addSubview:tipsLab];
    
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tipsBtn.mas_top).offset(-[JNSHAutoSize height:10]);
        make.centerX.equalTo(ViedoImgView);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:160], [JNSHAutoSize height:40]));
    }];
    
    table.tableFooterView = footView;

    [self.view addSubview:table];
    
}

//播放视频
- (void)play {
    
//    //监听网络状态
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusNotReachable:
//                NSLog(@"网管，断网了！！！");
//                if (playerVc) {
//                    [playerVc dismissViewControllerAnimated:YES completion:^{
//
//                    }];
//                    tipsLab.text = @"视频加载失败";
//                    [tipsBtn setTitle:@"点击重试" forState:UIControlStateNormal];
//                    playBtn.hidden = YES;
//                    tipsLab.hidden = NO;
//                    tipsBtn.hidden = NO;
//                }
//                break;
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//                NSLog(@"土豪，你流量多!");
//                if (playerVc) {
//                    [playerVc dismissViewControllerAnimated:YES completion:^{
//
//                    }];
//                    tipsLab.text = @"当前处于非WiFi环境，继续播放可能产生流量费用";
//                    [tipsBtn setTitle:@"点击继续" forState:UIControlStateNormal];
//                    playBtn.hidden = YES;
//                    tipsLab.hidden = NO;
//                    tipsBtn.hidden = NO;
//                }else {
//                    tipsLab.text = @"当前处于非WiFi环境，继续播放可能产生流量费用";
//                    [tipsBtn setTitle:@"点击继续" forState:UIControlStateNormal];
//                    playBtn.hidden = YES;
//                    tipsLab.hidden = NO;
//                    tipsBtn.hidden = NO;
//                }
//                break;
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                NSLog(@"人生最爽的就是“空调WiFi西瓜!”");
//                [self playMovie];
//                break;
//            case AFNetworkReachabilityStatusUnknown:
//            default:
//                NSLog(@"不知名的网络");
//                break;
//        }
//    }];
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [self playMovie];
    
}

- (void)playMovie {
    
    //NSString *url = @"http://vf1.mtime.cn/Video/2012/06/21/mp4/120621104820876931.mp4";
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:[JNSYUserInfo getUserInfo].viedoUrl]];
    AVPlayerViewController *playerVc = [[AVPlayerViewController alloc] init];
    playerVc.player = player;
    [self presentViewController:playerVc animated:YES completion:nil];
    [playerVc.player play];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            cell.backgroundColor = ColorTableBackColor;
            cell.textLabel.text = @"【图片教程】 完成①、②两步即可正常收款。";
            cell.textLabel.textColor = ColorText;
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textAlignment = NSTextAlignmentLeft;
            
        }else if (indexPath.row == 1) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"1"];
            Cell.titleLab.text = @"实名认证";
            Cell.showBottomLine = YES;
            Cell.showTopLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 3) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"2"];
            Cell.titleLab.text = @"绑定结算卡";
            Cell.showBottomLine = YES;
            Cell.showTopLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 5) {
            JNSHMyCommonCell *Cell = [[JNSHMyCommonCell alloc] init];
            Cell.titleImage.image = [UIImage imageNamed:@"3"];
            Cell.titleLab.text = @"收款";
            Cell.showBottomLine = YES;
            Cell.showTopLine = YES;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else {
            cell.backgroundColor = ColorTableBackColor;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2 || indexPath.row == 4) {
        return 8;
    }else if(indexPath.row == 0){
        
        return 41;
        
    }else {
        
        return 41;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 5) {

//        JNSHMyCommonCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        JNSHUsageDetailViewController *UsageVc = [[JNSHUsageDetailViewController alloc] init];
        UsageVc.hidesBottomBarWhenPushed = YES;
        if (indexPath.row == 1) {
            UsageVc.typetag = 1;
        }else if (indexPath.row == 3) {
            UsageVc.typetag = 2;
        }else if (indexPath.row == 5) {
            UsageVc.typetag = 3;
        }
        [self.navigationController pushViewController:UsageVc animated:YES];
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
