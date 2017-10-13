//
//  JNSHUsageDetailViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/10/11.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHUsageDetailViewController.h"
#import "Masonry.h"

@interface JNSHUsageDetailViewController ()

@end

@implementation JNSHUsageDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"操作说明";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    scrollView.contentSize = CGSizeMake(KscreenWidth, KscreenHeight+50);
    
    [self.view addSubview:scrollView];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = ColorText;
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.text = @"一、实名认证";
    titleLab.textAlignment = NSTextAlignmentLeft;
    [scrollView addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView).offset([JNSHAutoSize height:18]);
        make.left.equalTo(scrollView).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth - 15, [JNSHAutoSize height:15]));
    }];
    
    UIImageView *ImageOne = [[UIImageView alloc] init];
    ImageOne.image = [UIImage imageNamed:@"Certification_1"];
    [scrollView addSubview:ImageOne];
    
    [ImageOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollView).offset([JNSHAutoSize width:15]);
        make.top.equalTo(titleLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:159], [JNSHAutoSize height:284]));
    }];
    
    UIImageView *ImageTwo = [[UIImageView alloc] init];
    ImageTwo.image = [UIImage imageNamed:@"Certification_2"];
    [scrollView addSubview:ImageTwo];
    
    [ImageTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-[JNSHAutoSize width:15]);
        make.top.equalTo(ImageOne);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:159], [JNSHAutoSize height:284]));
    }];
    
    UILabel *labeOne = [[UILabel alloc] init];
    labeOne.font = [UIFont systemFontOfSize:13];
    labeOne.textAlignment = NSTextAlignmentLeft;
    labeOne.textColor = ColorText;
    labeOne.text = @"1.进行实名认证";
    [scrollView addSubview:labeOne];
    
    [labeOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ImageOne.mas_bottom).offset([JNSHAutoSize height:17]);
        make.left.equalTo(ImageOne);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:159], [JNSHAutoSize height:30]));
    }];
    
    UILabel *labeTwo = [[UILabel alloc] init];
    labeTwo.font = [UIFont systemFontOfSize:13];
    labeTwo.textAlignment = NSTextAlignmentLeft;
    labeTwo.textColor = ColorText;
    labeTwo.text = @"2.按要求提交信息";
    [scrollView addSubview:labeTwo];
    
    [labeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labeOne);
        make.left.equalTo(ImageTwo);
        make.size.equalTo(labeOne);
    }];
    
    UIImageView *ImageThree = [[UIImageView alloc] init];
    ImageThree.image = [UIImage imageNamed:@"Certification_3"];
    [scrollView addSubview:ImageThree];
    
    [ImageThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labeOne.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(ImageOne);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:159], [JNSHAutoSize height:160]));
    }];
    
    UIImageView *ImageFour = [[UIImageView alloc] init];
    ImageFour.image = [UIImage imageNamed:@"Certification_4"];
    [scrollView addSubview:ImageFour];
    
    [ImageFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ImageThree);
        make.left.equalTo(ImageTwo);
        make.right.equalTo(scrollView).offset(-[JNSHAutoSize width:15]);
        make.height.equalTo(ImageThree);
    }];
    
    UILabel *labFour = [[UILabel alloc] init];
    labFour.font = [UIFont systemFontOfSize:13];
    labFour.text = @"3.审核结果";
    labFour.textAlignment = NSTextAlignmentLeft;
    labFour.textColor = ColorText;
    labFour.numberOfLines = 0;
    [scrollView addSubview:labFour];
    
    [labFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(labeOne);
        make.top.equalTo(ImageThree.mas_bottom).offset([JNSHAutoSize height:20]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:159], [JNSHAutoSize height:35]));
    }];
    
    UILabel *labFive = [[UILabel alloc] init];
    labFive.font = [UIFont systemFontOfSize:13];
    labFive.text = @"4.实名认证认证流程完成";
    labFive.textColor = ColorText;
    labFive.textAlignment = NSTextAlignmentLeft;
    
    [scrollView addSubview:labFive];
    
    [labFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(labFour);
        make.left.equalTo(ImageFour);
        make.size.equalTo(labFour);
    }];
    
    if (self.typetag == 2) { //绑定结算卡
        titleLab.text = @"二、绑定结算卡";
        ImageOne.image = [UIImage imageNamed:@"card_1"];
        ImageTwo.image = [UIImage imageNamed:@"card_2"];
        ImageThree.image = [UIImage imageNamed:@"card_3"];
        ImageFour.image = [UIImage imageNamed:@"card_4"];
        labeOne.text = @"1.进行结算卡绑定";
        labeTwo.text = @"2.按要求提交信息";
        labFour.text = @"3.选择支行信息时请允许捷牛生活访问您的位置";
        labFive.text = @"4.绑定结果";
    }else if (self.typetag == 3) {
        titleLab.text = @"三、收款";
        ImageOne.image = [UIImage imageNamed:@"cash_1"];
        ImageTwo.image = [UIImage imageNamed:@"cash_2"];
        ImageThree.image = [UIImage imageNamed:@"cash_3"];
        ImageFour.image = [UIImage imageNamed:@"cash_4"];
        labeOne.text = @"1.进行收款操作";
        labeTwo.text = @"2.输入金额";
        labFour.text = @"3.确认订单信息";
        labFive.text = @"4.交易结果";
    }
    
    
    
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
