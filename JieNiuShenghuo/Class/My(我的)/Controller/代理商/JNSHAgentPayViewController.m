//
//  JNSHAgentPayViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAgentPayViewController.h"
#import "Masonry.h"
#import "JNSHCommonButton.h"
#import "JNSHAgentDetailViewController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "JNSHVipOrderViewController.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"

@interface JNSHAgentPayViewController ()

@end

@implementation JNSHAgentPayViewController {
    
    NSString *type;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"代理商";
    self.view.backgroundColor = ColorTabBarBackColor;
    
    self.navBarBgAlpha = @"1.0";
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = ColorTabBarBackColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    UIImageView *lightBackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    lightBackImg.backgroundColor = ColorTableBackColor;
    lightBackImg.userInteractionEnabled = YES;
    [backImg addSubview:lightBackImg];
    
    UIImageView *modelBackImg = [[UIImageView alloc] init];
    modelBackImg.backgroundColor = lightYellow;
    
    [lightBackImg addSubview:modelBackImg];
    
    [modelBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lightBackImg).offset([JNSHAutoSize height:20]);
        make.left.right.equalTo(lightBackImg);
        make.height.mas_equalTo([JNSHAutoSize height:151]);
    }];
    
    UIImageView *ModelOneImg = [[UIImageView alloc] init];
    ModelOneImg.image = [UIImage imageNamed:@"medal"];
    
    UIImageView *ModelTwoImg = [[UIImageView alloc] init];
    ModelTwoImg.image = [UIImage imageNamed:@"medal"];
    
    UIImageView *ModelThreeImg = [[UIImageView alloc] init];
    ModelThreeImg.image = [UIImage imageNamed:@"medal"];
    
    UILabel *bottomLab = [[UILabel alloc] init];
    bottomLab.textColor = ColorText;
    bottomLab.font = [UIFont systemFontOfSize:15];
    bottomLab.textAlignment = NSTextAlignmentCenter;
    [modelBackImg addSubview:bottomLab];
    
    [bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(modelBackImg).offset([JNSHAutoSize height:110]);
        make.left.right.equalTo(modelBackImg);
        make.height.mas_equalTo([JNSHAutoSize height:20]);
    }];
    
    if ([self.orgType isEqualToString:@"L32"]) { //特约代理
        [modelBackImg addSubview:ModelOneImg];
        [ModelOneImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(modelBackImg);
            make.top.equalTo(modelBackImg).offset([JNSHAutoSize height:30]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:41], [JNSHAutoSize height:54]));
        }];
        bottomLab.text = @"恭喜您成为特约代理商!";
    }else if ([self.orgType isEqualToString:@"L31"]) { //一级代理
        [modelBackImg addSubview:ModelOneImg];
        [modelBackImg addSubview:ModelTwoImg];
        
        [ModelOneImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(modelBackImg).offset([JNSHAutoSize height:30]);
            make.centerX.equalTo(modelBackImg).offset(-[JNSHAutoSize width:29]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:41], [JNSHAutoSize height:54]));
        }];
        
        [ModelTwoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(modelBackImg).offset([JNSHAutoSize height:30]);
            make.centerX.equalTo(modelBackImg).offset([JNSHAutoSize width:29]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:41], [JNSHAutoSize height:54]));
        }];
        bottomLab.text = @"恭喜您成为一级代理商!";
    }else if ([self.orgType isEqualToString:@"L30"]) { //办事处
        [modelBackImg addSubview:ModelOneImg];
        [modelBackImg addSubview:ModelTwoImg];
        [modelBackImg addSubview:ModelThreeImg];
        [ModelOneImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(modelBackImg);
            make.top.equalTo(modelBackImg).offset([JNSHAutoSize height:30]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:41], [JNSHAutoSize height:54]));
        }];
        
        [ModelTwoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ModelOneImg);
            make.right.equalTo(ModelOneImg.mas_left).offset(-[JNSHAutoSize width:17]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:41], [JNSHAutoSize height:54]));
        }];
        
        [ModelThreeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ModelOneImg);
            make.left.equalTo(ModelOneImg.mas_right).offset([JNSHAutoSize width:17]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:41], [JNSHAutoSize height:54]));
        }];
        bottomLab.text = @"恭喜您成为办事处级别代理商!";
    }
    
    UIImageView *whiteBack = [[UIImageView alloc] init];
    whiteBack.backgroundColor = [UIColor whiteColor];
    
    [lightBackImg addSubview:whiteBack];
    
    [whiteBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lightBackImg);
        make.top.equalTo(modelBackImg.mas_bottom).offset([JNSHAutoSize height:10]);
        make.height.mas_equalTo([JNSHAutoSize height:101]);
    }];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.text = @"请支付后台管理费";
    lab.textColor = ColorText;
    lab.font = [UIFont systemFontOfSize:15];
    lab.textAlignment = NSTextAlignmentLeft;
    [whiteBack addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteBack).offset([JNSHAutoSize height:10]);
        make.left.equalTo(whiteBack).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:20]));
    }];
    
    UILabel *leftLab = [[UILabel alloc] init];
    leftLab.textAlignment = NSTextAlignmentLeft;
    leftLab.text = @"￥";
    leftLab.textColor = ColorText;
    leftLab.font = [UIFont fontWithName:@"ArialMT" size:24];
    [whiteBack addSubview:leftLab];
    
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lab.mas_bottom).offset([JNSHAutoSize height:28]);
        make.left.equalTo(whiteBack).offset([JNSHAutoSize width:100]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:20]));
    }];
    
    UILabel *moneyLab = [[UILabel alloc] init];
    moneyLab.textColor = ColorTabBarBackColor;
    moneyLab.textAlignment = NSTextAlignmentLeft;
    moneyLab.font  = [UIFont fontWithName:@"Arial-BoldMT" size:30];
    moneyLab.text = [NSString stringWithFormat:@"%.2f",[self.payPrice  integerValue]/100.0];
    [whiteBack addSubview:moneyLab];
    
    [moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(leftLab.mas_right).offset([JNSHAutoSize width:18]);
        make.bottom.equalTo(leftLab).offset([JNSHAutoSize height:2]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth - [JNSHAutoSize width:60], [JNSHAutoSize height:27]));
    }];
    
    JNSHCommonButton *PayBtn = [[JNSHCommonButton alloc] init];
    [PayBtn setTitle:@"去支付" forState:UIControlStateNormal];
    [PayBtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    
    [lightBackImg addSubview:PayBtn];
    
    [PayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteBack.mas_bottom).offset([JNSHAutoSize height:40]);
        make.left.equalTo(self.view).offset([JNSHAutoSize width:15]);
        make.right.equalTo(self.view).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:41]);
    }];
    
}

- (void)pay {
    
    NSLog(@"支付");

    [self beAgent];
    

    
}


//跳转订单
- (void)beAgent {
    
    //代理商消费下单
    
    NSString *time = [JNSHAutoSize getTimeNow];
    //NSString *goodsName = @"商户会员购买";

    NSString *MinMoney = [NSString stringWithFormat:@"%@",self.payPrice];
    
    NSDictionary *dic = @{
                          @"payType":@"1",
                          @"orderType":@"10",
                          @"amount":MinMoney ,
                          @"goodsName":self.taskId,
                          @"linkId":time,
                          @"product":@"1002"
                          };
    NSString *action = @"PayOrderCreate";
    
    NSDictionary *requstDic = @{
                                @"action":action,
                                @"data":dic,
                                @"token":[JNSYUserInfo getUserInfo].userToken
                                };
    
    NSString *params = [requstDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        //NSLog(@"%@",resultdic);
        NSString *msg = resultdic[@"msg"];
        if ([code isEqualToString:@"000000"]) {
            
            JNSHVipOrderViewController *vipOrder = [[JNSHVipOrderViewController alloc] init];
            vipOrder.money = [NSString stringWithFormat:@"%ld",[self.payPrice integerValue]/100];
            vipOrder.orderNo = resultdic[@"orderNo"];
            vipOrder.orderTime = resultdic[@"orderTime"];
            vipOrder.productName = @"后台管理费";
            NSArray *arrar = [[NSArray alloc] init];
            //判断绑定卡数组是否有数据
            if ([resultdic[@"bindCards"] isKindOfClass:[NSArray class]]) {
                arrar = resultdic[@"bindCards"];
                
                
                
            }
            
            vipOrder.cardsArray = arrar;
            vipOrder.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vipOrder animated:YES];
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
