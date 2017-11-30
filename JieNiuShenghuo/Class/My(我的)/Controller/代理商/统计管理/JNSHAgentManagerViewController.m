//
//  JNSHAgentManagerViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/27.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAgentManagerViewController.h"
#import "JNSHMyInfoViewController.h"
#import "JNSHAgentInfoViewController.h"
#import "UIViewController+Cloudox.h"

@interface JNSHAgentManagerViewController ()

@end

@implementation JNSHAgentManagerViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"代理管理";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    JNSHMyInfoViewController *myInfoVc = [[JNSHMyInfoViewController alloc] init];
    myInfoVc.title = @"我的信息";
    
    JNSHAgentInfoViewController *AgentInfoVc = [[JNSHAgentInfoViewController alloc] init];
    AgentInfoVc.title = @"代理信息";
    
    self.scrollView.scrollEnabled = NO;
    self.viewControllers = @[myInfoVc,AgentInfoVc];
    
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
