//
//  JNSHHomeViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/2.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHHomeViewController.h"
#import "Masonry.h"
#import "JNSHAutoSize.h"
#import "JNSYHighLightImageView.h"
#import "JNSHProgressView.h"
#import "JNSHTimeCountDownView.h"
#import "JNSHCashDeskViewController.h"
@interface JNSHHomeViewController ()

@end

@implementation JNSHHomeViewController {
    
    UIImageView *barImage;
    JNSHProgressView *ProgressView;
    UILabel *progressLab;
    NSTimer *timer;
    JNSHTimeCountDownView *ConutDownView;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"捷牛生活";
    self.navigationController.navigationBar.barTintColor = ColorTabBarBackColor;
    //设置导航栏标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = ColorTableBackColor;
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //右侧消息按钮
    UIButton *MessageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    MessageBtn.frame = CGRectMake(0, 0, 38, 38);
    [MessageBtn setImage:[UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
    [MessageBtn addTarget:self action:@selector(messageTap) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:MessageBtn];
    
    //广告轮播
    UIImageView *ADimgView = [[UIImageView alloc] init];
    ADimgView.backgroundColor = [UIColor grayColor];
    ADimgView.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight*0.37);
    [self.view addSubview:ADimgView];
    
    //四个功能按钮
    
     //收银台
    JNSYHighLightImageView *CashBackImg = [[JNSYHighLightImageView alloc] init];
    CashBackImg.userInteractionEnabled = YES;
    CashBackImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:CashBackImg];
    [CashBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(ADimgView.mas_bottom);
        make.size.mas_offset(CGSizeMake((KscreenWidth - 2)/2.0, [JNSHAutoSize height:72]));
    }];
    
    //tap
    UITapGestureRecognizer *CashTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(CashTapAction)];
    CashTap.numberOfTapsRequired = 1;
    [CashBackImg addGestureRecognizer:CashTap];
    
    
    UIImageView *CashLogo = [[UIImageView alloc] init];
    CashLogo.image = [UIImage imageNamed:@"home_grid_1_1"];
    CashLogo.highlightedImage = [UIImage imageNamed:@"home_grid_1_1"];
    CashLogo.highlighted = YES;
    [CashBackImg addSubview:CashLogo];
    
    [CashLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(CashBackImg);
        make.left.equalTo(CashBackImg).offset([JNSHAutoSize width:33]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:40], [JNSHAutoSize height:40]));
    }];
    
    UILabel *CashLab = [[UILabel alloc] init];
    CashLab.font = [UIFont systemFontOfSize:15];
    CashLab.textColor = ColorText;
    CashLab.textAlignment = NSTextAlignmentLeft;
    CashLab.text = @"收银台";
    [CashBackImg addSubview:CashLab];
    [CashLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(CashBackImg);
        make.left.equalTo(CashLogo.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:20]));
    }];
    
    
     //开通会员
    JNSYHighLightImageView *VipBackImg = [[JNSYHighLightImageView alloc] init];
    VipBackImg.userInteractionEnabled = YES;
    VipBackImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:VipBackImg];
    
    [VipBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CashBackImg);
        make.left.equalTo(CashBackImg.mas_right).offset(2.0);
        make.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:72]);
    }];
    
    UIImageView *VipLogoImg = [[UIImageView alloc] init];
    VipLogoImg.image = [UIImage imageNamed:@"home_grid_1_2"];
    [VipBackImg addSubview:VipLogoImg];
    
    [VipLogoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(VipBackImg);
        make.left.equalTo(VipBackImg).offset([JNSHAutoSize width:33]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:40], [JNSHAutoSize height:40]));
    }];
    
    UILabel *VipLab = [[UILabel alloc] init];
    VipLab.text = @"开通会员";
    VipLab.textColor = ColorText;
    VipLab.font = [UIFont systemFontOfSize:15];
    VipLab.textAlignment = NSTextAlignmentLeft;
    [VipBackImg addSubview:VipLab];
    
    [VipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(VipBackImg);
        make.left.equalTo(VipLogoImg.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:20]));
    }];
    
     //办信用卡
    JNSYHighLightImageView *CardBackImg = [[JNSYHighLightImageView alloc] init];
    CardBackImg.backgroundColor = [UIColor whiteColor];
    CardBackImg.userInteractionEnabled = YES;
    [self.view addSubview:CardBackImg];
    
    [CardBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(CashBackImg.mas_bottom).offset(2);
        make.size.mas_equalTo(CGSizeMake((KscreenWidth - 2)/2.0, [JNSHAutoSize height:72]));
    }];
    
    UIImageView *CardLogoImg = [[UIImageView alloc] init];
    CardLogoImg.image = [UIImage imageNamed:@"home_grid_2_1"];
    [CardBackImg addSubview:CardLogoImg];
    
    [CardLogoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(CardBackImg);
        make.left.equalTo(CardBackImg).offset([JNSHAutoSize width:33]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:40], [JNSHAutoSize height:40]));
    }];
    
    UILabel *CardLab = [[UILabel alloc] init];
    CardLab.text = @"办信用卡";
    CardLab.textColor = ColorText;
    CardLab.textAlignment = NSTextAlignmentLeft;
    CardLab.font = [UIFont systemFontOfSize:15];
    [CardBackImg addSubview:CardLab];
    [CardLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(CardBackImg);
        make.left.equalTo(CardLogoImg.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:20]));
    }];
    
     //快递助手
    JNSYHighLightImageView *ExpressBackImg = [[JNSYHighLightImageView alloc] init];
    ExpressBackImg.backgroundColor = [UIColor whiteColor];
    ExpressBackImg.userInteractionEnabled = YES;
    [self.view addSubview:ExpressBackImg];
    
    [ExpressBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CardBackImg);
        make.left.equalTo(CardBackImg.mas_right).offset(2);
        make.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:72]);
    }];
    
    UIImageView *ExpressLogoImg = [[UIImageView alloc] init];
    ExpressLogoImg.image = [UIImage imageNamed:@"home_grid_2_2-1"];
    [ExpressBackImg addSubview:ExpressLogoImg];
    
    [ExpressLogoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ExpressBackImg);
        make.left.equalTo(ExpressBackImg).offset([JNSHAutoSize width:33]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:43], [JNSHAutoSize height:43]));
    }];
    
    UILabel *ExpressLab = [[UILabel alloc] init];
    ExpressLab.text = @"我要贷款";
    ExpressLab.textAlignment = NSTextAlignmentLeft;
    ExpressLab.font = [UIFont systemFontOfSize:15];
    ExpressLab.textColor = ColorText;
    [ExpressBackImg addSubview:ExpressLab];
    
    [ExpressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ExpressLogoImg);
        make.left.equalTo(ExpressLogoImg.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:20]));
    }];
    
    //抢券
    UIImageView *titleBackImg = [[UIImageView alloc] init];
    titleBackImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:titleBackImg];
    
    [titleBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(CardBackImg.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:36]);
    }];
    
    UILabel *TitleLabOne = [[UILabel alloc] init];
    TitleLabOne.textColor = ColorText;
    TitleLabOne.font = [UIFont systemFontOfSize:15];
    TitleLabOne.text = @"抢券";
    TitleLabOne.textAlignment = NSTextAlignmentLeft;
    [titleBackImg addSubview:TitleLabOne];
    
    [TitleLabOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleBackImg);
        make.left.equalTo(titleBackImg).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:40], [JNSHAutoSize height:30]));
    }];
    
    UILabel *SubTitleLab = [[UILabel alloc] init];
    SubTitleLab.text = @"每天10点、14点准时开抢!";
    SubTitleLab.textColor = ColorLightText;
    SubTitleLab.font = [UIFont systemFontOfSize:11];
    SubTitleLab.textAlignment = NSTextAlignmentLeft;
    
    [titleBackImg addSubview:SubTitleLab];
    
    [SubTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBackImg).offset(11);
        make.left.equalTo(TitleLabOne.mas_right).offset([JNSHAutoSize width:2]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth/2.0, [JNSHAutoSize height:20]));
    }];
    
    
    
    ConutDownView = [[JNSHTimeCountDownView alloc] initWithFrame:CGRectMake(KscreenWidth - [JNSHAutoSize width:80], [JNSHAutoSize height:10], [JNSHAutoSize width:65], [JNSHAutoSize height:20])];
    ConutDownView.time = 1000;
    
    [titleBackImg addSubview:ConutDownView];
    
    //timeLab
    UILabel *timeLab = [[UILabel alloc] init];
    timeLab.text = @"距本场结束";
    timeLab.textColor = ColorLightText;
    timeLab.font = [UIFont systemFontOfSize:11];
    timeLab.textAlignment = NSTextAlignmentRight;
    [titleBackImg addSubview:timeLab];
    
    [timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleBackImg).offset([JNSHAutoSize height:3]);
        make.right.equalTo(ConutDownView.mas_left).offset(-[JNSHAutoSize width:5]);
        make.width.mas_equalTo([JNSHAutoSize width:100]);
        make.height.mas_equalTo([JNSHAutoSize height:15]);
    }];
    
    //试手气
    UIImageView *ticketBackImg = [[UIImageView alloc] init];
    ticketBackImg.backgroundColor = [UIColor whiteColor];
    ticketBackImg.userInteractionEnabled = YES;
    [self.view addSubview:ticketBackImg];
    
    [ticketBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBackImg.mas_bottom).offset([JNSHAutoSize height:1]);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:74]);
    }];
    
    UIImageView *ticketImg = [[UIImageView alloc] init];
    ticketImg.image = [UIImage imageNamed:@"home_¥"];
    [ticketBackImg addSubview:ticketImg];
    
    [ticketImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ticketBackImg);
        make.left.equalTo(ticketBackImg).offset([JNSHAutoSize width:46]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:45], [JNSHAutoSize height:45]));
    }];
    
    UILabel *ticketLabOne = [[UILabel alloc] init];
    ticketLabOne.text = @"刷卡抵用券";
    ticketLabOne.textAlignment = NSTextAlignmentLeft;
    ticketLabOne.font = [UIFont systemFontOfSize:13];
    ticketLabOne.textColor = ColorText;
    [ticketBackImg addSubview:ticketLabOne];
    [ticketLabOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ticketImg);
        make.left.equalTo(ticketImg.mas_right).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:20]));
    }];
    UILabel *ticketLabTwo = [[UILabel alloc] init];
    ticketLabTwo.text = @"可抵扣刷卡手续费";
    ticketLabTwo.textColor = ColorLightText;
    ticketLabTwo.font = [UIFont systemFontOfSize:10];
    ticketLabTwo.textAlignment = NSTextAlignmentLeft;
    [ticketBackImg addSubview:ticketLabTwo];
    
    [ticketLabTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ticketLabOne.mas_bottom).offset([JNSHAutoSize height:2]);
        make.left.equalTo(ticketLabOne);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:20]));
    }];
    
    UIButton *TestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [TestBtn setTitle:@"试手气" forState:UIControlStateNormal];
    [TestBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [TestBtn setBackgroundColor:[UIColor redColor]];
    TestBtn.titleLabel.font = [UIFont systemFontOfSize:11];
    TestBtn.layer.cornerRadius = 3;
    [TestBtn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
    [ticketBackImg addSubview:TestBtn];
    
    [TestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ticketImg);
        make.right.equalTo(self.view).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:20]));
    }];
    
    //进度
    ProgressView = [[JNSHProgressView alloc] initWithFrame:CGRectMake(KscreenWidth - [JNSHAutoSize width:75], [JNSHAutoSize height:48], [JNSHAutoSize width:60], [JNSHAutoSize height:6])];
    ProgressView.progress = 0.5;
    [ticketBackImg addSubview:ProgressView];
    
    progressLab = [[UILabel alloc] init];
    progressLab.text = [NSString stringWithFormat:@"已抢%.0f%%",ProgressView.progress*100];
    progressLab.font = [UIFont systemFontOfSize:10];
    progressLab.textAlignment = NSTextAlignmentRight;
    progressLab.textColor = ColorLightText;
    [ticketBackImg addSubview:progressLab];
    
    [progressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ProgressView);
        make.right.equalTo(ProgressView.mas_left).offset(-[JNSHAutoSize width:5]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:12]));
    }];
    
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    
}

//
- (void)countDown {
    
    NSInteger time = ConutDownView.time;
    time = time - 1;
    
    ConutDownView.time = time;
    
    if (time <= 0) {
        [timer invalidate];
    }

}

//试手气
- (void)test{
    
    NSLog(@"试手气");
    
    ProgressView.progress = 0.8;
    
    progressLab.text = [NSString stringWithFormat:@"已抢%.0f%%",ProgressView.progress*100];
    
}

//消息按钮
- (void)messageTap {
    
    
    
    
}

//收银台
- (void)CashTapAction {
    
    NSLog(@"收银台");
    
    JNSHCashDeskViewController *jnshCashDeskVc = [[JNSHCashDeskViewController alloc] init];
    jnshCashDeskVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:jnshCashDeskVc animated:YES];
    
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
