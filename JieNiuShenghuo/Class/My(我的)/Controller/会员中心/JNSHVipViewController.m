//
//  JNSHVipViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/4.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHVipViewController.h"
#import "JNSHAutoSize.h"
#import "Masonry.h"
#import "JNSYHighLightImageView.h"
#import "JNSHVipOrderViewController.h"
#import "JNSHAutoSize.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "JNSHOrderSureViewController.h"

@interface JNSHVipViewController ()

@end

@implementation JNSHVipViewController {
    
    UIImageView *nityImg;
    UIImageView *halfYearImg;
    UILabel *totalPriceLab;
    NSString *totalPrice;
    BOOL isVip;
    UILabel *ratingSubLab;
    UILabel *birthSubLab;
    UIImageView *diamondImg;
    UILabel *VipLab;
    UILabel *rightLab;
    UILabel *leftLab;
    UILabel *NityrightLab;
    UILabel *halfYearLab;
    UILabel *halfLab;
    NSArray *mealDic;
    NSString *vipcode;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"会员中心";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = ColorTabBarBackColor;
   
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];

//    //设置导航栏背景色为透明
//    UIImageView *backImg = self.navigationController.navigationBar.subviews.firstObject;
//    backImg.alpha = 0;
    
    self.navBarBgAlpha = @"1.0";
    //隐藏黑线
    self.navigationController.navigationBar.subviews[0].subviews[0].hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    [self RequsetVipInfo];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
   
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 51)];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.backgroundColor = ColorTableBackColor;
    scrollView.userInteractionEnabled = YES;
    scrollView.contentSize = CGSizeMake(KscreenWidth, KscreenHeight - 20);
    [self.view addSubview:scrollView];
    
//    //顶部背景色
    UIImageView *headImageView = [[UIImageView alloc] init];
    headImageView.frame = CGRectMake(0, -500, KscreenWidth, 500);
    headImageView.backgroundColor = ColorTabBarBackColor;
    [scrollView addSubview:headImageView];
    
    //头像
    UIImageView *headerBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:101])];
    headerBackView.backgroundColor = ColorTabBarBackColor;
    headerBackView.userInteractionEnabled = YES;
    [scrollView addSubview:headerBackView];
    
    UIImageView *headImg = [[UIImageView alloc] init];
    headImg.image = [UIImage imageNamed:@"my_head_portrait"];
    [headerBackView addSubview:headImg];
    
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerBackView);
        make.top.equalTo(headerBackView).offset([JNSHAutoSize height:14]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:51], [JNSHAutoSize height:51]));
    }];
    
    diamondImg = [[UIImageView alloc] init];
    diamondImg.image = [UIImage imageNamed:@"my_head_vip"];
    if (!isVip) {
        diamondImg.image = [UIImage imageNamed:@"vip_head_vip_grey"];
    }
    [headImg addSubview:diamondImg];
    
    [diamondImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headImg.mas_right).offset([JNSHAutoSize width:1]);
        make.centerY.equalTo(headImg.mas_bottom).offset(-[JNSHAutoSize height:5]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:20]));
    }];
    
    VipLab = [[UILabel alloc] init];
    VipLab.text = @"会员未开通";
    if (isVip) {
        VipLab.text = @"60天后会员到期";
    }
    VipLab.font = [UIFont systemFontOfSize:12];
    VipLab.textColor = [UIColor whiteColor];
    VipLab.textAlignment = NSTextAlignmentCenter;
    [headerBackView addSubview:VipLab];
    
    [VipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImg.mas_bottom).offset([JNSHAutoSize height:10]);
        make.centerX.equalTo(headerBackView);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, 15));
    }];
    
    rightLab = [[UILabel alloc] init];
    rightLab.text = @"开通会员，享受专属特权";
    rightLab.textColor = ColorText;
    rightLab.textAlignment = NSTextAlignmentCenter;
    rightLab.font = [UIFont systemFontOfSize:13];
    
    [scrollView addSubview:rightLab];
    
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headerBackView.mas_bottom).offset(10);
        make.centerX.equalTo(scrollView);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, 15));
    }];
    
    /*   特权    */
     //专属费率
    JNSYHighLightImageView *ratingBackImg = [[JNSYHighLightImageView alloc] init];
    ratingBackImg.backgroundColor = [UIColor whiteColor];
    ratingBackImg.userInteractionEnabled = YES;
    [scrollView addSubview:ratingBackImg];
    
    [ratingBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(scrollView);
        make.size.mas_equalTo(CGSizeMake((KscreenWidth-2)/2.0, [JNSHAutoSize height:72]));
    }];
    
    UIImageView *ratingImg = [[UIImageView alloc] init];
    ratingImg.image = [UIImage imageNamed:@"vip_rate"];
    
    [ratingBackImg addSubview:ratingImg];
    
    [ratingImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ratingBackImg);
        make.left.equalTo(ratingBackImg).offset([JNSHAutoSize width:30]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:28], [JNSHAutoSize height:28]));
    }];
    
    UILabel *ratingLab = [[UILabel alloc] init];
    ratingLab.text = @"专属费率";
    ratingLab.font = [UIFont systemFontOfSize:12];
    ratingLab.textAlignment = NSTextAlignmentLeft;
    ratingLab.textColor = ColorText;
    
    [ratingBackImg addSubview:ratingLab];
    
    [ratingLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ratingImg);
        make.left.equalTo(ratingImg.mas_right).offset([JNSHAutoSize width:11]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    ratingSubLab = [[UILabel alloc] init];
    ratingSubLab.font = [UIFont systemFontOfSize:11];
    ratingSubLab.textColor = ColorLightText;
    ratingSubLab.textAlignment = NSTextAlignmentLeft;
    ratingSubLab.text = @"0.39%+3";
    
    [ratingBackImg addSubview:ratingSubLab];
    
    [ratingSubLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ratingLab.mas_bottom).offset([JNSHAutoSize height:2]);
        make.left.equalTo(ratingLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    //安全保险
    JNSYHighLightImageView *safeBackImg = [[JNSYHighLightImageView alloc] init];
    safeBackImg.backgroundColor = [UIColor whiteColor];
    safeBackImg.userInteractionEnabled = YES;
    [scrollView addSubview:safeBackImg];
    
    [safeBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ratingBackImg);
        make.left.equalTo(ratingBackImg.mas_right).offset([JNSHAutoSize height:2]);
        make.size.mas_equalTo(CGSizeMake(((KscreenWidth-2)/2.0), [JNSHAutoSize height:72]));
    }];
    
    UIImageView *safeImg = [[UIImageView alloc] init];
    safeImg.image = [UIImage imageNamed:@"vip_picc_logo"];
    
    [safeBackImg addSubview:safeImg];
    
    [safeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(safeBackImg);
        make.left.equalTo(safeBackImg).offset([JNSHAutoSize width:25]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:35],[JNSHAutoSize height:(35/75.0*32)]));
    }];
    
    UILabel *safeLab = [[UILabel alloc] init];
    safeLab.text = @"安全保障";
    safeLab.font = [UIFont systemFontOfSize:12];
    safeLab.textAlignment = NSTextAlignmentLeft;
    safeLab.textColor = ColorText;
    [safeBackImg addSubview:safeLab];
    
    [safeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ratingImg);
        make.left.equalTo(safeImg.mas_right).offset([JNSHAutoSize width:11]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    UILabel *safeSubLab = [[UILabel alloc] init];
    safeSubLab.font = [UIFont systemFontOfSize:11];
    safeSubLab.textColor = ColorLightText;
    safeSubLab.textAlignment = NSTextAlignmentLeft;
    safeSubLab.text = @"赠人身意外险";
    
    [safeBackImg addSubview:safeSubLab];
    
    [safeSubLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(safeLab.mas_bottom).offset([JNSHAutoSize height:2]);
        make.left.equalTo(safeLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:15]));
    }];
    
    
    //生日特权
    JNSYHighLightImageView *birthdayBackImg = [[JNSYHighLightImageView alloc] init];
    birthdayBackImg.backgroundColor = [UIColor whiteColor];
    birthdayBackImg.userInteractionEnabled = YES;
    [scrollView addSubview:birthdayBackImg];
    
    [birthdayBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ratingBackImg.mas_bottom).offset([JNSHAutoSize height:2]);
        make.left.equalTo(scrollView);
        make.size.mas_equalTo(CGSizeMake(((KscreenWidth-2)/2.0), [JNSHAutoSize height:72]));
    }];
    
    UIImageView *birthImg = [[UIImageView alloc] init];
    birthImg.image = [UIImage imageNamed:@"vip_cake"];
    
    [birthdayBackImg addSubview:birthImg];
    
    [birthImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(birthdayBackImg);
        make.left.equalTo(birthdayBackImg).offset([JNSHAutoSize width:30]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:28], [JNSHAutoSize height:28]));
    }];
    
    UILabel *birthLab = [[UILabel alloc] init];
    birthLab.text = @"生日特权";
    birthLab.font = [UIFont systemFontOfSize:12];
    birthLab.textAlignment = NSTextAlignmentLeft;
    birthLab.textColor = ColorText;
    [birthdayBackImg addSubview:birthLab];
    
    [birthLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(birthImg);
        make.left.equalTo(birthImg.mas_right).offset([JNSHAutoSize width:11]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    birthSubLab = [[UILabel alloc] init];
    birthSubLab.font = [UIFont systemFontOfSize:11];
    birthSubLab.textColor = ColorLightText;
    birthSubLab.textAlignment = NSTextAlignmentLeft;
    birthSubLab.text = @"送5张抵用券";
    [birthdayBackImg addSubview:birthSubLab];
    
    [birthSubLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(birthLab.mas_bottom).offset([JNSHAutoSize height:2]);
        make.left.equalTo(birthLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:15]));
    }];
    
    //专属身份
    JNSYHighLightImageView *cerfityBackImg = [[JNSYHighLightImageView alloc] init];
    cerfityBackImg.backgroundColor = [UIColor whiteColor];
    cerfityBackImg.userInteractionEnabled =YES;
    [scrollView addSubview:cerfityBackImg];
    
    [cerfityBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(birthdayBackImg);
        make.left.equalTo(birthdayBackImg.mas_right).offset([JNSHAutoSize width:2]);
        make.size.mas_equalTo(CGSizeMake(((KscreenWidth-2)/2.0), [JNSHAutoSize height:72]));
    }];
    
    UIImageView *cerImg = [[UIImageView alloc] init];
    cerImg.image = [UIImage imageNamed:@"vip_vip"];
    
    [cerfityBackImg addSubview:cerImg];
    
    [cerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cerfityBackImg);
        make.left.equalTo(cerfityBackImg).offset([JNSHAutoSize width:30]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:28], [JNSHAutoSize height:28]));
    }];
    
    UILabel *cerLab = [[UILabel alloc] init];
    cerLab.text = @"专属身份";
    cerLab.font = [UIFont systemFontOfSize:12];
    cerLab.textAlignment = NSTextAlignmentLeft;
    cerLab.textColor = ColorText;
    [cerfityBackImg addSubview:cerLab];
    
    [cerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(birthLab);
        make.left.equalTo(cerImg.mas_right).offset([JNSHAutoSize width:11]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:15]));
    }];
    
    UILabel *cerSubLab = [[UILabel alloc] init];
    cerSubLab.font = [UIFont systemFontOfSize:11];
    cerSubLab.textColor = ColorLightText;
    cerSubLab.textAlignment = NSTextAlignmentLeft;
    cerSubLab.text = @"点亮会员标识";
    [cerfityBackImg addSubview:cerSubLab];
    
    [cerSubLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cerLab.mas_bottom).offset([JNSHAutoSize height:2]);
        make.left.equalTo(cerLab);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:15]));
    }];
    
    
    //套餐lab
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.text = @"套餐选择";
    tipsLab.font = [UIFont systemFontOfSize:13];
    tipsLab.textColor = ColorText;
    tipsLab.textAlignment = NSTextAlignmentCenter;
    [scrollView addSubview:tipsLab];
    
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cerfityBackImg.mas_bottom).offset([JNSHAutoSize height:10]);
        make.centerX.equalTo(scrollView);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:15]));
    }];
    
    //会员选择
    
    nityImg = [[UIImageView alloc] init];
    nityImg.backgroundColor = lightOrgeron;
    nityImg.userInteractionEnabled = YES;
    
    [scrollView addSubview:nityImg];
    
    [nityImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsLab.mas_bottom).offset([JNSHAutoSize height:10]);
        make.left.equalTo(scrollView);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:46]));
    }];
   
    leftLab = [[UILabel alloc] init];
    leftLab.text = @"季度会员（90天）";
    leftLab.font = [UIFont systemFontOfSize:14];
    leftLab.textColor = ColorText;
    leftLab.textAlignment = NSTextAlignmentLeft;
    
    [nityImg addSubview:leftLab];
    
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nityImg);
        make.left.equalTo(nityImg).offset([JNSHAutoSize width:30]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth / 2.0, [JNSHAutoSize height:20]));
    }];
    
    NityrightLab = [[UILabel alloc] init];
    NityrightLab.text = @"￥55";
    NityrightLab.textColor = [UIColor redColor];
    NityrightLab.font = [UIFont systemFontOfSize:14];
    NityrightLab.textAlignment = NSTextAlignmentRight;
    
    [nityImg addSubview:NityrightLab];
    
    [NityrightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nityImg);
        make.right.equalTo(nityImg).offset(-[JNSHAutoSize width:45]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize width:  20]));
    }];
    
    UIImageView *midLine = [[UIImageView alloc] init];
    midLine.backgroundColor = ColorLineSeperate;
    
    [nityImg addSubview:midLine];
    
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(nityImg);
        make.right.equalTo(nityImg);
        make.left.equalTo(nityImg).offset([JNSHAutoSize width:15]);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    //半年会员
    halfYearImg = [[UIImageView alloc] init];
    halfYearImg.backgroundColor = [UIColor whiteColor];
    halfYearImg.userInteractionEnabled = YES;
    
    [scrollView addSubview:halfYearImg];
    
    [halfYearImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nityImg.mas_bottom);
        make.left.equalTo(scrollView);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:46]));
    }];
    
    halfYearLab = [[UILabel alloc] init];
    halfYearLab.font = [UIFont systemFontOfSize:14];
    halfYearLab.text = @"半年会员（180天）";
    halfYearLab.textColor = ColorText;
    halfYearLab.textAlignment = NSTextAlignmentLeft;
    
    [halfYearImg addSubview:halfYearLab];
    
    [halfYearLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(halfYearImg);
        make.left.equalTo(halfYearImg).offset([JNSHAutoSize width:30]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth/2.0, [JNSHAutoSize height:20]));
    }];
    
    halfLab = [[UILabel alloc] init];
    halfLab.font = [UIFont systemFontOfSize:14];
    halfLab.textAlignment = NSTextAlignmentRight;
    halfLab.textColor = [UIColor redColor];
    halfLab.text = @"￥105";
    
    [halfYearImg addSubview:halfLab];
    
    [halfLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(halfYearImg);
        make.right.equalTo(halfYearImg).offset([JNSHAutoSize width:-45]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:20]));
    }];
    
    //点击手势
    UITapGestureRecognizer *tapSelect = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(select:)];
    tapSelect.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(select:)];
    tap.numberOfTapsRequired = 1;
    
    [nityImg addGestureRecognizer:tapSelect];
    [halfYearImg addGestureRecognizer:tap];
    
    UIImageView *bottomBackImg = [[UIImageView alloc] init];
    bottomBackImg.backgroundColor = [UIColor whiteColor];
    bottomBackImg.userInteractionEnabled = YES;
    [self.view addSubview:bottomBackImg];
    
    [bottomBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(KscreenHeight - CGRectGetMaxY(scrollView.frame));
    }];
    
    totalPriceLab = [[UILabel alloc] init];
    totalPriceLab.font = [UIFont systemFontOfSize:15];
    totalPriceLab.textAlignment = NSTextAlignmentLeft;
    NSString *str = @"总价：￥55";
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, (str.length - 3))];
    totalPriceLab.attributedText = attri;
    
    [bottomBackImg addSubview:totalPriceLab];
    
    [totalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomBackImg);
        make.left.equalTo(bottomBackImg).offset([JNSHAutoSize width:30]);
        make.size.mas_equalTo(CGSizeMake(([JNSHAutoSize width:120]), [JNSHAutoSize height:20]));
    }];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setBackgroundColor:ColorTabBarBackColor];
    [confirmBtn setTitle:@"立即开通" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(beVip) forControlEvents:UIControlEventTouchUpInside];
    if (isVip) {
        [confirmBtn setTitle:@"立即续费" forState:UIControlStateNormal];
    }
    
    [bottomBackImg addSubview:confirmBtn];
    
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottomBackImg);
        make.right.equalTo(bottomBackImg);
        make.width.mas_equalTo([JNSHAutoSize width:151]);
        make.height.mas_equalTo(KscreenHeight - CGRectGetMaxY(scrollView.frame));
    }];
    
    //totalPrice = @"55";
    vipcode = @"Vip1";
    if (!mealDic) {
        mealDic = [[NSArray alloc] init];
    }

}

//跳转订单
- (void)beVip {
    
    //购买会员消费下单
    
    NSString *time = [JNSHAutoSize getTimeNow];
    //NSString *goodsName = @"商户会员购买";
    
    
    NSString *MinMoney = [NSString stringWithFormat:@"%ld",[totalPrice integerValue]*100];
    
    NSDictionary *dic = @{
                          @"payType":@"1",
                          @"orderType":@"10",
                          @"amount":MinMoney ,
                          @"goodsName":vipcode,
                          @"linkId":time,
                          @"product":@"1001"
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
            vipOrder.money = totalPrice;
            vipOrder.orderNo = resultdic[@"orderNo"];
            vipOrder.orderTime = resultdic[@"orderTime"];
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


- (void)select:(UITapGestureRecognizer *)sender {
    
    UIView *selectView = sender.view;
    
    NSString *str = [NSString stringWithFormat:@"总价：￥%ld",[mealDic[0][@"price"] integerValue]/100];;
    
    if (selectView == nityImg) {
        
        nityImg.backgroundColor = lightOrgeron;
        halfYearImg.backgroundColor = [UIColor whiteColor];
        totalPrice = [NSString stringWithFormat:@"%ld",[mealDic[0][@"price"] integerValue]/100];
        vipcode = mealDic[0][@"code"];
                   
    }else if (selectView == halfYearImg) {
        
        nityImg.backgroundColor = [UIColor whiteColor];
        
        halfYearImg.backgroundColor = lightOrgeron;
        //设置总价
        str = [NSString stringWithFormat:@"总价：￥%ld",[mealDic[1][@"price"] integerValue]/100];
        totalPrice = [NSString stringWithFormat:@"%ld",[mealDic[1][@"price"] integerValue]/100];
        vipcode = mealDic[1][@"code"];
    }
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(3, (str.length - 3))];
    //设置总价
    totalPriceLab.attributedText = attri;
}

//获取会员信息
- (void)RequsetVipInfo {
    
    NSDictionary *dic = @{
                          @"timestamp":[JNSHAutoSize getTimeNow]
                          };
    NSString *action = @"UserVipInfo";
    
    NSDictionary *requstDic = @{
                                @"action":action,
                                @"data":dic,
                                @"token":[JNSYUserInfo getUserInfo].userToken
                                };
    
    NSString *params = [requstDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        NSLog(@"%@",resultdic);
        NSString *msg = resultdic[@"msg"];
        if ([code isEqualToString:@"000000"]) {
            NSString *rate = resultdic[@"vipRate"];
            NSString *birthdayCount = resultdic[@"birthdayCount"];
            NSString *Vip = [NSString stringWithFormat:@"%@",resultdic[@"isVip"]];
            if ([Vip isEqualToString:@"1"]) {
                NSString *expireDay = resultdic[@"expireDay"];
                diamondImg.image = [UIImage imageNamed:@"my_head_vip"];
                VipLab.text = [NSString stringWithFormat:@"%@天后会员到期",expireDay];
                rightLab.text = @"会员专属特权";
            }
            mealDic = resultdic[@"meal"];
            if([resultdic[@"meal"] isKindOfClass:[NSArray class]]) {
                
                totalPrice = [NSString stringWithFormat:@"%ld",[mealDic[0][@"price"] integerValue]/100];
                leftLab.text = mealDic[0][@"title"];
                NityrightLab.text = [NSString stringWithFormat:@"￥%ld",[mealDic[0][@"price"] integerValue]/100];
                halfYearLab.text = mealDic[1][@"title"];
                halfLab.text = [NSString stringWithFormat:@"￥%ld",[mealDic[1][@"price"] integerValue]/100];
            }
            
            ratingSubLab.text = rate;
            birthSubLab.text = [NSString stringWithFormat:@"送%@张抵用券",birthdayCount];
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    //self.navigationController.navigationBar.translucent = YES;
    //隐藏黑线
    self.navigationController.navigationBar.subviews[0].subviews[0].hidden = NO;
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
