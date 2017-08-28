//
//  JNSHMainBarController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/2.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHMainBarController.h"
#import "JNSHHomeViewController.h"
#import "JNSHShoppingMallViewController.h"
#import "JNSHServiceViewController.h"
#import "JNSHMyViewController.h"

@interface JNSHMainBarController ()

@end

@implementation JNSHMainBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //首页
    JNSHHomeViewController *homeVc = [[JNSHHomeViewController alloc] init];
    homeVc.tabBarItem.image = [[UIImage imageNamed:@"home_home_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_home_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    homeVc.title = @"首页";
    UINavigationController *homenAV = [[UINavigationController alloc] initWithRootViewController:homeVc];
    
    //商城
    JNSHShoppingMallViewController *shoppingMall = [[JNSHShoppingMallViewController alloc] init];
    shoppingMall.tabBarItem.image = [[UIImage imageNamed:@"home_mall_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shoppingMall.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_mall_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    shoppingMall.title = @"商城";
    UINavigationController *shoppingNav = [[UINavigationController alloc] initWithRootViewController:shoppingMall];
    
    //服务
    JNSHServiceViewController *serviceVc = [[JNSHServiceViewController alloc] init];
    serviceVc.tabBarItem.image = [[UIImage imageNamed:@"home_service_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    serviceVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_service_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    serviceVc.title = @"服务";
    UINavigationController *serviceNav = [[UINavigationController alloc] initWithRootViewController:serviceVc];
    
    //我的
    JNSHMyViewController *MyVc = [[JNSHMyViewController alloc] init];
    MyVc.tabBarItem.image = [[UIImage imageNamed:@"home_my_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MyVc.tabBarItem.selectedImage = [[UIImage imageNamed:@"home_my_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    MyVc.title = @"我";
    UINavigationController *MyNav = [[UINavigationController alloc] initWithRootViewController:MyVc];
    MyNav.navigationBar.barTintColor = ColorTabBarBackColor;
    [MyNav.navigationBar setTitleTextAttributes:@{
                                                  NSForegroundColorAttributeName:[UIColor whiteColor]
                                                  }];
    //MyNav.navigationBar.translucent = NO;
    
    self.viewControllers = @[homenAV,shoppingNav,serviceNav,MyNav];
    
    //工具栏字体颜色
    self.tabBar.tintColor = ColorTabBarBackColor;
    
    
    
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
