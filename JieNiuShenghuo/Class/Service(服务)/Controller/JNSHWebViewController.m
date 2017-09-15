//
//  JNSHWebViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/14.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHWebViewController.h"

@interface JNSHWebViewController ()

@end

@implementation JNSHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.Navtitle;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64)];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [request setHTTPMethod:@"POST"];
    [web loadRequest:request];
    
    [self.view addSubview:web];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
