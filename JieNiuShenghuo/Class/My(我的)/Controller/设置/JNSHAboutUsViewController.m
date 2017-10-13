//
//  JNSHAboutUsViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/8.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAboutUsViewController.h"
#import "Masonry.h"

@interface JNSHAboutUsViewController ()

@end

@implementation JNSHAboutUsViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear: animated];
    
    self.title = @"关于我们";
    self.view.backgroundColor = ColorTableBackColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *logoimage = [[UIImageView alloc] init];
    logoimage.image = [UIImage imageNamed:@"icon"];
    
    [self.view addSubview:logoimage];
    
    [logoimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset([JNSHAutoSize height:57]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:96], [JNSHAutoSize width:96]));
    }];
    
    UITextView *textView = [[UITextView alloc] init];
    
    textView.scrollEnabled = NO;
    textView.editable = NO;
    textView.textColor = ColorText;
    textView.backgroundColor = ColorTableBackColor;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;
    NSDictionary *attr = @{
                           NSFontAttributeName:[UIFont systemFontOfSize:15],
                           NSParagraphStyleAttributeName:paragraphStyle
                           };
    textView.attributedText = [[NSAttributedString alloc] initWithString:@"捷牛生活app是一款提供PICC保险产品，小额贷款，信用卡办理与消费，特色商城，投资理财和移动收银台为一体的综合性生活服务平台，为中国广大消费者提供安全稳定的便民消费和优质可靠的金融服务；" attributes:attr];
    textView.userInteractionEnabled = NO;
    [self.view addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoimage.mas_bottom).offset([JNSHAutoSize height:56]);
        make.left.equalTo(self.view).offset([JNSHAutoSize width:30]);
        make.right.equalTo(self.view).offset(-[JNSHAutoSize width:30]);
        make.bottom.equalTo(self.view);
    }];
    
    
    
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
