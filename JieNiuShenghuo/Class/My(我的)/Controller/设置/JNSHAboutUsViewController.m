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
    textView.attributedText = [[NSAttributedString alloc] initWithString:@"【捷牛生活】app是一款集综合性、实用性 为一体的领先的移动便民生活服务类平台，致 力于提供“简单”、“安全”、“快捷”的支 付解决方案；提供信用卡办理、信用卡优惠、 贷款、保险、投资理财等金融服务；以及缴费 充值、医疗挂号、彩票购买、打折票务等便民 服务，覆盖生活方方面面，真正做到“尽享指 尖臻至生活”。" attributes:attr];
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
