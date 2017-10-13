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
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    [self.view addSubview:scrollView];
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"jnsh" ofType:@"txt"];
    NSString * pathString = [NSString stringWithContentsOfFile:path encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000) error:nil];
    if (nil ==  pathString ||pathString.length <= 0) {
        pathString = [NSString stringWithContentsOfFile:path encoding:4 error:nil];
    }
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake([JNSHAutoSize width:15], 0, KscreenWidth - [JNSHAutoSize width:30], 0)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSMutableAttributedString *mutableStr = [[NSMutableAttributedString alloc] initWithString:pathString];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = 10;
    style.lineSpacing = 10;
    style.alignment = NSTextAlignmentLeft;
    [mutableStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, pathString.length)];
    //label.backgroundColor = [UIColor clearColor];
    //label.text = pathString;
    label.attributedText = mutableStr;
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:13.0f];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    [label sizeToFit];
    
    [scrollView addSubview:label];
    scrollView.contentSize = CGSizeMake(0, label.bounds.size.height+64);
    
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
