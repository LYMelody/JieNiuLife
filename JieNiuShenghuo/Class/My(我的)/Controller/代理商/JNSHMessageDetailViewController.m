//
//  JNSHMessageDetailViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/10/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHMessageDetailViewController.h"
#import "Masonry.h"
#import "SBJSON.h"
#import "IBHttpTool.h"

@interface JNSHMessageDetailViewController ()

@end

@implementation JNSHMessageDetailViewController {
    
    NSString *phone;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.backgroundColor = ColorTableBackColor;
    backImg.userInteractionEnabled = YES;
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    [self.view addSubview:backImg];
    
    UIImageView *headerImg = [[UIImageView alloc] init];
    if ([self.AgentType isEqualToString:@"2"]) {
        headerImg.image = [UIImage imageNamed:@"Congratulations"];
    }else {
        headerImg.image = [UIImage imageNamed:@"feilv"];
    }
    
    [backImg addSubview:headerImg];
    
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset([JNSHAutoSize height:63]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:82], [JNSHAutoSize width:82]));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.numberOfLines = 0;
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = ColorText;
    titleLab.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPhone)];
    tap.numberOfTapsRequired = 1;
    
    [titleLab addGestureRecognizer:tap];
    
    if([self.AgentType isEqualToString:@"2"]) { //签约
        
        NSArray *array = [self.AgentName componentsSeparatedByString:@"在"];
        if (array.count == 2) {
            NSString *name = [array[0] substringFromIndex:6];
            //NSLog(@"name:%@",name);
            NSArray *datePhoneArray = [array[1] componentsSeparatedByString:@","];
            NSString *date = [datePhoneArray[0] substringToIndex:11];
            NSString *agent = [datePhoneArray[0] substringFromIndex:13];
            phone = datePhoneArray[1];
            NSString *finalStr = [NSString stringWithFormat:@"恭喜您名下的%@在%@\n成为%@,\n%@",name,date,agent,phone];
            //NSLog(@"name:%@,date:%@,agent:%@,phone:%@,final:%@",name,date,agent,phone,finalStr);
            
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:finalStr];
            
            [attrStr addAttribute:NSForegroundColorAttributeName value:ColorTabBarBackColor range:NSMakeRange(6, name.length)];
            [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(6, name.length)];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(6, name.length)];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldMT" size:18] range:NSMakeRange(21+name.length, agent.length)];
            [attrStr addAttribute:NSForegroundColorAttributeName value:ColorTabBarBackColor range:NSMakeRange(21+name.length, agent.length)];
            [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(21+name.length, agent.length)];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            style.lineSpacing = 10;
            //[attrStr addAttribute:NSKernAttributeName value:@2 range:NSMakeRange(0, finalStr.length)];
            //[attrStr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, finalStr.length)];
            titleLab.attributedText = attrStr;
            
        }else {
            titleLab.text = self.AgentName;
        }
    }else {
        
        NSArray *array = [self.AgentName componentsSeparatedByString:@","];
        if (array.count > 2) {
            NSArray *nameArray = [array[0] componentsSeparatedByString:@"正在申请"];
            NSString *name = [nameArray[0] substringFromIndex:6];
            NSString *agent =nameArray[1];
            NSString *str = array[1];
            phone = array[2];
            NSString *finalStr = [NSString stringWithFormat:@"恭喜您名下的%@正在申请%@,\n%@,\n%@",name,agent,str,phone];
            
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:finalStr];
            [attrStr addAttribute:NSForegroundColorAttributeName value:ColorTabBarBackColor range:NSMakeRange(6, name.length)];
            [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(6, name.length)];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(6, name.length)];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldMT" size:18] range:NSMakeRange(10+name.length, agent.length)];
            [attrStr addAttribute:NSForegroundColorAttributeName value:ColorTabBarBackColor range:NSMakeRange(10+name.length, agent.length)];
            [attrStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(10+name.length, agent.length)];
            titleLab.attributedText = attrStr;
        }else {
    
            titleLab.text = self.AgentName;
            
        }

    }
    
    [backImg addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerImg.mas_bottom).offset([JNSHAutoSize height:48]);
        make.right.left.equalTo(backImg);
        make.height.mas_equalTo([JNSHAutoSize height:68]);
    }];
    
    
}

//打电话
- (void)tapPhone {
    
    NSString *telphone = [phone substringFromIndex:5];
    
    NSLog(@"72384729347");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",[NSString stringWithFormat:@"%@",telphone]]]];
    
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
