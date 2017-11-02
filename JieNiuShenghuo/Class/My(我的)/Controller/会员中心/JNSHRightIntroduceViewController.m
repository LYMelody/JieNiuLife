//
//  JNSHRightIntroduceViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHRightIntroduceViewController.h"
#import "Masonry.h"

@interface JNSHRightIntroduceViewController ()

@end

@implementation JNSHRightIntroduceViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorTableBackColor;

    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textColor = SmothYellow;
    titleLab.font = [UIFont fontWithName:@"Arial-BoldMT" size:15];
    NSLog(@"%@",[UIFont familyNames]);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset([JNSHAutoSize height:25]);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:15]));
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom).offset([JNSHAutoSize height:16]);
        make.left.equalTo(self.view).offset([JNSHAutoSize width:15]);
        make.right.equalTo(self.view).offset(-[JNSHAutoSize width:15]);
    }];
    
    UILabel *detailLab = [[UILabel alloc] init];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
    detailLab.textAlignment = NSTextAlignmentLeft;
    detailLab.numberOfLines = 0;
    if (self.typetag == 100){ //会员费率介绍
        self.title = @"会员费率介绍";
        titleLab.text = @"费率一览（交易2万/笔对比）";
        img.image = [UIImage imageNamed:@"rate"];
        
        attr = [[NSMutableAttributedString alloc] initWithString:@"说明：\n以交易2万/笔为例，[捷牛生活App]会员用户最高可节约76元/笔，非会员用户最高可节约48元/笔，一年节约成本数千至上万元！费率优势巨大！"];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:ColorText range:NSMakeRange(3, attr.length- 3)];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(3, attr.length - 3)];
        detailLab.attributedText = attr;
        
    } else { //PICC人保介绍
        self.title = @"PICC人保介绍";
        titleLab.text = @"综合交通意外保障计划";
        img.image = [UIImage imageNamed:@"picc"];
        detailLab.font = [UIFont systemFontOfSize:13];
        detailLab.text = @"保障对象：购买会员专享（兑换会员除外）";
        detailLab.textColor = ColorText;
        
    }
    [detailLab sizeToFit];
    [self.view addSubview:detailLab];
    
    [detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_bottom).offset([JNSHAutoSize height:17]);
        make.left.equalTo(self.view).offset([JNSHAutoSize width:15]);
        make.right.equalTo(self.view).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:71]);
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
