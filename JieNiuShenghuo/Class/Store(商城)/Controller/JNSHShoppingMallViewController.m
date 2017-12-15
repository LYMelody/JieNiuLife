//
//  JNSHShoppingMallViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/2.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHShoppingMallViewController.h"
#import "NSTimer+JNSHAddition.h"
@interface JNSHShoppingMallViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)CAShapeLayer *progressLayer;

@property(nonatomic,strong)NSTimer *timer;

@end

static NSTimeInterval const KtimeInterval = 0.03;

@implementation JNSHShoppingMallViewController {
    
    CGFloat _plusWidth;    //增长点
    UIWebView *web;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = ColorTabBarBackColor;
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.frame = CGRectZero;   //将tabbar frame 设置为0；
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商城";
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"用浏览器打开" forState:UIControlStateNormal];
//    button.titleLabel.font = [UIFont systemFontOfSize:14];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(openLink) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
//    self.navigationItem.rightBarButtonItem = rightBtn;
    
   //自定义返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 5, 0)] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(-15, 0, 35, 44);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
   
    if(IS_IOS11) {
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [leftView addSubview:backBtn];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftView];
        self.navigationItem.leftBarButtonItem = backItem;
    }else {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        UIBarButtonItem *fixBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixBtn.width = -20;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:fixBtn,backItem, nil];
    }
    
    //加载进度
    _progressLayer = [[CAShapeLayer alloc] init];
    _progressLayer.lineWidth = 2;
    _progressLayer.strokeColor = SmothYellow.CGColor;
    _progressLayer.frame = CGRectMake(0, 42, KscreenWidth, 2);
    _timer = [NSTimer scheduledTimerWithTimeInterval:KtimeInterval target:self selector:@selector(timeDownAction) userInfo:nil repeats:YES];
    [_timer pause];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 2)];
    [path addLineToPoint:CGPointMake(KscreenWidth, 2)];
    _progressLayer.path = path.CGPath;
    _progressLayer.strokeEnd = 0;
    _plusWidth = 0.01;
    
    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    
    //webView
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    web.delegate = self;
    NSString *url = @"http://m.haidaowang.com/index.html#back_flag";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"GET"];
    [web loadRequest:request];
    
    [self.view addSubview:web];
    
}

- (void)openLink {
    
    NSLog(@"link");
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://m.haidaowang.com/index.html#back_flag"]];
    
}


#define mark - webViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    
    [self startLoad];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self finishedLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self finishedLoad];
    
}

#define layers method

//定时器方法
- (void)timeDownAction {
    
    _progressLayer.strokeEnd += _plusWidth;
    
    if (_progressLayer.strokeEnd > 0.8) {
        _plusWidth = 0.02;
    }
    
    
}

- (void)startLoad {
    
    [_timer resumeWithTimeInterval:KtimeInterval];
    
}

- (void)finishedLoad {
    
    [self closeTimer];
    
    _progressLayer.strokeEnd = 1.0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _progressLayer.hidden = YES;
        [_progressLayer removeFromSuperlayer];
    });
}

- (void)closeTimer {
    
    [_timer invalidate];
    _timer = nil;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.frame = CGRectMake(0, KscreenHeight - 49, KscreenWidth, 49);
    self.tabBarController.tabBar.hidden = NO;
    if (_timer) {
        [self closeTimer];
    }
    if (_progressLayer) {
        [_progressLayer removeFromSuperlayer];
        _progressLayer = nil;
    }
}

//切换tabbar
- (void)back {
    
    
    if ([web canGoBack]) {
        [web goBack];
    }else {
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    }
    
}


- (void)dealloc {
    
    [self closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
    
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
