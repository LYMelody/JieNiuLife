//
//  JNSHFenRunManagerViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHFenRunManagerViewController.h"
#import "JNSHFenRunDetailViewController.h"
#import "JNSHDalyFenRunViewController.h"

@interface JNSHFenRunManagerViewController ()

@end

@implementation JNSHFenRunManagerViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    JNSHFenRunDetailViewController *DetailVc = [[JNSHFenRunDetailViewController alloc] init];
    DetailVc.title = @"分润明细";
    
    JNSHDalyFenRunViewController *DalyVc = [[JNSHDalyFenRunViewController alloc] init];
    DalyVc.title = @"日分润汇总";
    
    self.viewControllers = @[DetailVc,DalyVc];
    self.scrollView.scrollEnabled = NO;
    
    
    
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
