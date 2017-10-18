//
//  JNSHWebViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/14.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHWebViewController.h"
#import "NSTimer+JNSHAddition.h"
@interface JNSHWebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)CAShapeLayer *progressLayer;

@property(nonatomic,strong)NSTimer *timer;

@end

static NSTimeInterval const KtimeInterval = 0.03;

@implementation JNSHWebViewController {
    
    CGFloat _plusWidth;    //增长点
    UIWebView *web;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.Navtitle;
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - ([self.Navtitle isEqualToString:@"订单支付"]?0:64))];
    web.delegate = self;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
    [request setHTTPMethod:@"GET"];
    [web loadRequest:request];
    
    [self.view addSubview:web];
    
}

//返回
- (void)back {
    
    if ([self.Navtitle isEqualToString:@"订单支付"]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else if (web.canGoBack) {
        [web goBack];
    }else {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
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
    
    if (_timer) {
        [self closeTimer];
    }
    if (_progressLayer) {
        [_progressLayer removeFromSuperlayer];
        _progressLayer = nil;
    }
}

- (void)dealloc {
    
    [self closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
    
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
