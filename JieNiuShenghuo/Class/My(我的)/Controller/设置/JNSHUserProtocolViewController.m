//
//  JNSHUserProtocolViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/8.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHUserProtocolViewController.h"

@interface JNSHUserProtocolViewController ()

@end

@implementation JNSHUserProtocolViewController

- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"用户协议";
    self.view.backgroundColor = ColorTableBackColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
