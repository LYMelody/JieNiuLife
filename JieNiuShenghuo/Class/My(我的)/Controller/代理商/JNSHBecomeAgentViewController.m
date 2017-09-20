//
//  JNSHBecomeAgentViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHBecomeAgentViewController.h"
#import "Masonry.h"
#import "JNSHCommitEmailViewController.h"
#import "JNSHAgentPayViewController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"


@interface JNSHBecomeAgentViewController ()

@end

@implementation JNSHBecomeAgentViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"代理商";
    
    self.view.backgroundColor = ColorTabBarBackColor;
    
    self.navBarBgAlpha = @"1.0";
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //self.navigationController.navigationBar.translucent = YES;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    backImg.backgroundColor = ColorTabBarBackColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];

    UIImageView *whiteImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth , KscreenHeight)];
    whiteImg.backgroundColor = ColorTableBackColor;
    whiteImg.userInteractionEnabled = YES;
    [backImg addSubview:whiteImg];
    
    //代理商是什么
    UIImageView *FirstWhietBackImg = [[UIImageView alloc] init];
    FirstWhietBackImg.backgroundColor = [UIColor whiteColor];
    FirstWhietBackImg.userInteractionEnabled = YES;
    
    [whiteImg addSubview:FirstWhietBackImg];
    
    [FirstWhietBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(whiteImg).offset([JNSHAutoSize height:25]);
        make.height.mas_equalTo([JNSHAutoSize height:100]);
    }];
    
    UILabel *AgentLab = [[UILabel alloc] init];
    AgentLab.font = [UIFont systemFontOfSize:15];
    AgentLab.textAlignment = NSTextAlignmentLeft;
    AgentLab.textColor = ColorTabBarBackColor;
    AgentLab.text = @"代理商是什么?";
    [FirstWhietBackImg addSubview:AgentLab];
    
    [AgentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(FirstWhietBackImg).offset([JNSHAutoSize height:15]);
        make.left.equalTo(FirstWhietBackImg).offset([JNSHAutoSize width:15]);
        make.width.mas_equalTo([JNSHAutoSize width:200]);
        make.height.mas_equalTo([JNSHAutoSize height:20]);
    }];
    
    UILabel *agentDetailLab = [[UILabel alloc] init];
    agentDetailLab.textColor = ColorLightText;
    agentDetailLab.font = [UIFont systemFontOfSize:13];
    agentDetailLab.textAlignment = NSTextAlignmentLeft;
    agentDetailLab.numberOfLines = 0;
    agentDetailLab.text = @"代理商是代企业打理生意，是厂家给予商家佣金额度的 一种经营行为，一般是指赚取企业代理佣金的商业单位。";
    [FirstWhietBackImg addSubview:agentDetailLab];
    
    [agentDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(AgentLab.mas_bottom).offset([JNSHAutoSize height:5]);
        make.left.equalTo(AgentLab);
        make.right.equalTo(FirstWhietBackImg).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:50]);
    }];
    
    //有什么好处?
    UIImageView *SecondWhietBackImg = [[UIImageView alloc] init];
    SecondWhietBackImg.backgroundColor = [UIColor whiteColor];
    SecondWhietBackImg.userInteractionEnabled = YES;
    
    [whiteImg addSubview:SecondWhietBackImg];
    
    [SecondWhietBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(FirstWhietBackImg.mas_bottom).offset([JNSHAutoSize height:10]);
        make.height.mas_equalTo([JNSHAutoSize height:100]);
    }];
    
    UILabel *secondLab = [[UILabel alloc] init];
    secondLab.textAlignment = NSTextAlignmentLeft;
    secondLab.textColor = ColorTabBarBackColor;
    secondLab.text = @"有什么好处?";
    secondLab.font = [UIFont systemFontOfSize:15];
    
    [SecondWhietBackImg addSubview:secondLab];
    
    [secondLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(SecondWhietBackImg).offset([JNSHAutoSize height:15]);
        make.left.equalTo(SecondWhietBackImg).offset([JNSHAutoSize width:15]);
        make.width.mas_equalTo([JNSHAutoSize width:200]);
        make.height.mas_equalTo([JNSHAutoSize height:20]);
    }];
    
    UILabel *SecondDetailLab = [[UILabel alloc] init];
    SecondDetailLab.textColor = ColorLightText;
    SecondDetailLab.font = [UIFont systemFontOfSize:13];
    SecondDetailLab.textAlignment = NSTextAlignmentLeft;
    SecondDetailLab.numberOfLines = 0;
    SecondDetailLab.text = @"代理商是代企业打理生意，是厂家给予商家佣金额度的 一种经营行为，一般是指赚取企业代理佣金的商业单位。";
    [SecondWhietBackImg addSubview:SecondDetailLab];
    
    [SecondDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondLab.mas_bottom).offset([JNSHAutoSize height:5]);
        make.left.equalTo(secondLab);
        make.right.equalTo(SecondWhietBackImg).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:50]);
    }];
    
    //如何成为代理商?
    UIImageView *thridWhietImg = [[UIImageView alloc] init];
    thridWhietImg.backgroundColor = [UIColor whiteColor];
    [whiteImg addSubview:thridWhietImg];
    
    [thridWhietImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(SecondWhietBackImg.mas_bottom).offset([JNSHAutoSize height:10]);
        make.height.mas_equalTo([JNSHAutoSize height:100]);
    }];
    
    UILabel *thirdLab = [[UILabel alloc] init];
    thirdLab.textAlignment = NSTextAlignmentLeft;
    thirdLab.textColor = ColorTabBarBackColor;
    thirdLab.text = @"如何成为代理商?";
    thirdLab.font = [UIFont systemFontOfSize:15];
    
    [thridWhietImg addSubview:thirdLab];
    
    [thirdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thridWhietImg).offset([JNSHAutoSize height:15]);
        make.left.equalTo(thridWhietImg).offset([JNSHAutoSize width:15]);
        make.width.mas_equalTo([JNSHAutoSize width:200]);
        make.height.mas_equalTo([JNSHAutoSize height:20]);
    }];
    
    UILabel *thirdDetailLab = [[UILabel alloc] init];
    thirdDetailLab.textColor = ColorLightText;
    thirdDetailLab.font = [UIFont systemFontOfSize:13];
    thirdDetailLab.textAlignment = NSTextAlignmentLeft;
    thirdDetailLab.numberOfLines = 0;
    thirdDetailLab.text = @"代理商是代企业打理生意，是厂家给予商家佣金额度的 一种经营行为，一般是指赚取企业代理佣金的商业单位。";
    
    [thridWhietImg addSubview:thirdDetailLab];
    
    [thirdDetailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLab.mas_bottom).offset([JNSHAutoSize height:5]);
        make.left.equalTo(thirdLab);
        make.right.equalTo(thridWhietImg).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:50]);
    }];
    
    UIButton *becomeAgentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [becomeAgentBtn setBackgroundColor:ColorTabBarBackColor];
    [becomeAgentBtn setTitle:@"我要成为代理商" forState:UIControlStateNormal];
    [becomeAgentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    becomeAgentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [becomeAgentBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteImg addSubview:becomeAgentBtn];
    
    [becomeAgentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:51]);
    }];
    
    
    
    
}

- (void)next {
    
    NSLog(@"我要成为代理商");
    
    JNSHCommitEmailViewController *CommitVc = [[JNSHCommitEmailViewController alloc] init];
    CommitVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:CommitVc animated:YES];
    
//    JNSHAgentPayViewController *PayVc = [[JNSHAgentPayViewController alloc] init];
//    PayVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:PayVc animated:YES];
    
    
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
