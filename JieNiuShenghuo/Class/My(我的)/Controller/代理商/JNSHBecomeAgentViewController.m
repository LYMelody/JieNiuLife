//
//  JNSHBecomeAgentViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHBecomeAgentViewController.h"
#import "Masonry.h"
#import "JNSHCommitEmailViewController.h"
#import "JNSHAgentPayViewController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "JNSHCommonButton.h"


@interface JNSHBecomeAgentViewController ()

@end

@implementation JNSHBecomeAgentViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"代理商";
    
    self.view.backgroundColor = ColorTableBackColor;
    
    self.navBarBgAlpha = @"1.0";
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //self.navigationController.navigationBar.translucent = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64)];
    scrollView.contentSize = CGSizeMake(KscreenWidth, 2268/750*KscreenWidth  + [JNSHAutoSize height:209]);
    
    [self.view addSubview:scrollView];
    
    UIImageView *ImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"代理商-"]];
    ImgView.userInteractionEnabled = YES;
    ImgView.backgroundColor = [UIColor orangeColor];
    ImgView.contentMode = UIViewContentModeScaleAspectFill;
    [scrollView addSubview:ImgView];
    
    [ImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView);
        make.top.equalTo(scrollView).offset([JNSHAutoSize height:104]);
        make.width.mas_equalTo(KscreenWidth);
        make.height.mas_equalTo(2268/750*KscreenWidth);
    }];
    
    JNSHCommonButton *netBtn = [[JNSHCommonButton alloc] init];
    [netBtn setTitle:@"我要成为代理商" forState:UIControlStateNormal];
    [netBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:netBtn];
    
    [netBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset([JNSHAutoSize width:15]);
        make.right.equalTo(self.view).offset(-[JNSHAutoSize width:15]);
        make.bottom.equalTo(self.view).offset(-[JNSHAutoSize height:25]);
        make.height.mas_equalTo([JNSHAutoSize height:41]);
    }];
    
}

- (void)next {
    
    NSLog(@"我要成为代理商");
    
    JNSHCommitEmailViewController *CommitVc = [[JNSHCommitEmailViewController alloc] init];
    CommitVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:CommitVc animated:YES];
    
    
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
