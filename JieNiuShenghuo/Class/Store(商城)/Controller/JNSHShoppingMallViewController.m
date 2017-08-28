//
//  JNSHShoppingMallViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/2.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHShoppingMallViewController.h"

@interface JNSHShoppingMallViewController ()

@end

@implementation JNSHShoppingMallViewController

- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    
    //设置状态栏为黑色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
    
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    
    [super viewWillDisappear:animated];

    //设置状态栏为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商城";
    self.view.backgroundColor = [UIColor yellowColor];
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
