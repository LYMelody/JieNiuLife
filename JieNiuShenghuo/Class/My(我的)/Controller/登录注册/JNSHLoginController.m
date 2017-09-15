//
//  JNSHLoginController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/24.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHLoginController.h"
#import "Masonry.h"
#import "JNSHCommonButton.h"
#import "JNSHResignViewController.h"
#import "JNSHForgetPwdViewController.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSHAutoSize.h"
#import "JNSYUserInfo.h"
#import "MBProgressHUD.h"
@interface JNSHLoginController ()<UITextFieldDelegate>

@end

@implementation JNSHLoginController {
    
    JNSHCommonButton *LogoInBtn;
    
    UITextField *pwdTextFiled;
    UITextField *accountFiled;
    MBProgressHUD *HUD;
    NSUserDefaults *User;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
   //self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    self.navigationController.navigationBar.subviews.firstObject.alpha = 0;
    
    self.navigationController.navigationBar.barTintColor = ColorTabBarBackColor;
    //设置导航栏标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
     //self.navigationController.navigationBar.hidden = YES;
    
    User = [NSUserDefaults standardUserDefaults];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *backimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    backimg.image = [UIImage imageNamed:@"thumb-1920-438689"];
    backimg.userInteractionEnabled = YES;
    [self.view addSubview:backimg];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setImage:[UIImage imageNamed:@"payment_delete"] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    
    [backimg addSubview:cancleBtn];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backimg).offset([JNSHAutoSize height:30]);
        make.left.equalTo(backimg).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:20]));
    }];
    
    UIImageView *logoImgView = [[UIImageView alloc] init];
    logoImgView.image = [UIImage imageNamed:@"捷牛生活-logo-"];
    [backimg addSubview:logoImgView];
    
    [logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backimg);
        make.top.equalTo(backimg).offset([JNSHAutoSize height:129]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:170], [JNSHAutoSize height:60]));
    }];
    
    UIImageView *logoBackImage = [[UIImageView alloc] init];
    logoBackImage.backgroundColor = [UIColor whiteColor];
    logoBackImage.layer.cornerRadius = 3;
    logoBackImage.layer.masksToBounds = YES;
    logoBackImage.userInteractionEnabled = YES;
    [backimg addSubview:logoBackImage];
    
    [logoBackImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImgView.mas_bottom).offset([JNSHAutoSize width:90]);
        make.left.equalTo(backimg).offset([JNSHAutoSize width:50]);
        make.right.equalTo(backimg).offset(-[JNSHAutoSize width:50]);
        make.height.mas_equalTo([JNSHAutoSize height:94]);
    }];
    
    UIImageView *midImg = [[UIImageView alloc] init];
    midImg.image = [UIImage imageNamed:@"登录"];
    [logoBackImage addSubview:midImg];
    
    [midImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(logoBackImage);
        make.left.right.equalTo(logoBackImage);
        make.height.mas_equalTo([JNSHAutoSize height:2]);
    }];
    
    //账户
    accountFiled = [[UITextField alloc] init];
    accountFiled.font = [UIFont systemFontOfSize:15];
    accountFiled.textColor = ColorText;
    accountFiled.textAlignment = NSTextAlignmentLeft;
    accountFiled.placeholder = @"请输入11位手机号码";
    accountFiled.keyboardType = UIKeyboardTypeNumberPad;
    accountFiled.delegate = self;
    accountFiled.tag = 100;
    //accountFiled.text = @"18868825142";
    //用登录过的账户登录
    if ([User objectForKey:@"UserAccount"]) {
        accountFiled.text = [User objectForKey:@"UserAccount"];
    }
    
    accountFiled.clearButtonMode = UITextFieldViewModeAlways;
    UIImageView *accountLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [JNSHAutoSize width:60], [JNSHAutoSize height:50])];
   
    UIImageView *accountLogoImg = [[UIImageView alloc] init];
    accountLogoImg.image = [UIImage imageNamed:@"account"];
    [accountLeftView addSubview:accountLogoImg];
    
    [accountLogoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(accountLeftView);
        make.left.equalTo(accountLeftView).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:23]));
    }];
    
    UIImageView *rightLine = [[UIImageView alloc] init];
    rightLine.backgroundColor = linebackColor;
    
    [accountLeftView addSubview:rightLine];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(accountLeftView);
        make.right.equalTo(accountLeftView).offset(-[JNSHAutoSize width:10]);
        make.width.mas_equalTo([JNSHAutoSize width:1]);
    }];
    
    accountFiled.leftViewMode = UITextFieldViewModeAlways;
    accountFiled.leftView = accountLeftView;
    
    [logoBackImage addSubview:accountFiled];
    
    [accountFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(logoBackImage);
        make.top.equalTo(logoBackImage);
        make.bottom.equalTo(midImg.mas_top);
    }];
    
    //密码
    pwdTextFiled = [[UITextField alloc] init];
    pwdTextFiled.font = [UIFont systemFontOfSize:15];
    pwdTextFiled.textColor = ColorText;
    pwdTextFiled.textAlignment = NSTextAlignmentLeft;
    pwdTextFiled.placeholder = @"请输入登录密码";
    pwdTextFiled.delegate = self;
    pwdTextFiled.tag = 101;
    pwdTextFiled.secureTextEntry = YES;
    //pwdTextFiled.text = @"123456";
    pwdTextFiled.clearButtonMode = UITextFieldViewModeAlways;
    
    //记住密码
    NSLog(@"bool:%d",[User boolForKey:@"PwdRem"]);
    
    NSLog(@"account:%@,pwd:%@",[User objectForKey:@"UserAccount"],[User objectForKey:@"UserPwd"]);
    
    if ([User boolForKey:@"PwdRem"]) {
        
        if ([User objectForKey:@"UserPwd"]) {
            pwdTextFiled.text = [User objectForKey:@"UserPwd"];
        }
        
    }
    
    UIImageView *pwdLeftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [JNSHAutoSize width:60], [JNSHAutoSize height:50])];
    UIImageView *pwdLogoImg = [[UIImageView alloc] init];
    pwdLogoImg.image = [UIImage imageNamed:@"key"];
    [pwdLeftView addSubview:pwdLogoImg];
    
    [pwdLogoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(pwdLeftView);
        make.left.equalTo(pwdLeftView).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:23]));
    }];
    
    UIImageView *pwdLine = [[UIImageView alloc] init];
    pwdLine.backgroundColor = linebackColor;
    
    [pwdLeftView addSubview:pwdLine];
    
    [pwdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(pwdLeftView);
        make.right.equalTo(pwdLeftView).offset(-[JNSHAutoSize width:10]);
        make.width.mas_equalTo([JNSHAutoSize width:1]);
    }];
    
    pwdTextFiled.leftViewMode = UITextFieldViewModeAlways;
    pwdTextFiled.leftView = pwdLeftView;
    
    [logoBackImage addSubview:pwdTextFiled];
    
    [pwdTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(logoBackImage);
        make.top.equalTo(midImg.mas_bottom);
        make.bottom.equalTo(logoBackImage);
    }];
    
    //登录
    LogoInBtn = [[JNSHCommonButton alloc] init];
    LogoInBtn.enabled =  NO;
    [LogoInBtn setTitle:@"登录" forState:UIControlStateNormal];
    [LogoInBtn addTarget:self action:@selector(logIn) forControlEvents:UIControlEventTouchUpInside];
    [backimg addSubview:LogoInBtn];
    
    [LogoInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backimg);
        make.top.equalTo(logoBackImage.mas_bottom).offset([JNSHAutoSize height:15]);
        make.left.right.equalTo(logoBackImage);
        make.height.mas_equalTo([JNSHAutoSize height:41]);
    }];
    
    if (![accountFiled.text isEqualToString:@""] && ![pwdTextFiled.text isEqualToString:@""]) {
        LogoInBtn.enabled = YES;
    }
    
    //记住密码
    UIButton *remberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [remberBtn setImage:[UIImage imageNamed:@"---checkmark"] forState:UIControlStateNormal];
    [remberBtn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateSelected];
    [remberBtn addTarget:self action:@selector(rember:) forControlEvents:UIControlEventTouchUpInside];
    [backimg addSubview:remberBtn];
    
    [remberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(LogoInBtn);
        make.top.equalTo(LogoInBtn.mas_bottom).offset([JNSHAutoSize height:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:14], [JNSHAutoSize height:15]));
    }];
    
    if ([User boolForKey:@"PwdRem"]) {
        remberBtn.selected = NO;
    }else {
        remberBtn.selected = YES;
    }
    
//    //记住密码
//    [User setBool:YES forKey:@"PwdRem"];
//    [User setObject:pwdTextFiled.text forKey:@"UserPwd"];
//    [User synchronize];
    

    UILabel *rightLab = [[UILabel alloc] init];
    rightLab.text = @"记住密码";
    rightLab.font = [UIFont systemFontOfSize:13];
    rightLab.textColor = ColorTabBarBackColor;
    rightLab.textAlignment = NSTextAlignmentLeft;
    [backimg addSubview:rightLab];
    
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(remberBtn);
        make.left.equalTo(remberBtn.mas_right).offset([JNSHAutoSize width:5]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
    //忘记密码
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn setBackgroundColor:[UIColor clearColor]];
    [forgetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetBtn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    
    [backimg addSubview:forgetBtn];
    
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(LogoInBtn);
        make.centerY.equalTo(remberBtn);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
    //注册
    UIButton *resignBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resignBtn setTitle:@"没有账号？立即注册>>" forState:UIControlStateNormal];
    [resignBtn setTitleColor:blueColor forState:UIControlStateNormal];
    resignBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    resignBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [resignBtn addTarget:self action:@selector(resign) forControlEvents:UIControlEventTouchUpInside];
    [backimg addSubview:resignBtn];
    
    [resignBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backimg);
        make.bottom.equalTo(backimg).offset(-[JNSHAutoSize height:45]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:20]));
    }];
    
}

//记住密码
- (void)rember:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        //记住密码
        [User setBool:NO forKey:@"PwdRem"];
        [User setObject:@"" forKey:@"UserPwd"];
        [User synchronize];
    }else {
        //记住密码
        [User setBool:YES forKey:@"PwdRem"];
        [User setObject:pwdTextFiled.text forKey:@"UserPwd"];
        [User synchronize];
    }
    
    
}

//忘记密码，
- (void)forget {
    
    NSLog(@"忘记密码");
    
    JNSHForgetPwdViewController *forgetVc = [[JNSHForgetPwdViewController alloc] init];
    forgetVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:forgetVc animated:YES];
    
}

//登录
- (void)logIn {
    
    NSLog(@"登录");
    
    if ([accountFiled.text isEqualToString:@""] ) {
        [JNSHAutoSize showMsg:@"账户名为空!"];
        return;
    }
    if ([pwdTextFiled.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"密码为空"];
        return;
    }
    
    
   
    
    NSDictionary *dic = @{
                          @"phone":accountFiled.text,
                          @"pass":pwdTextFiled.text,
                          @"os":@"IOS",
                          @"soft":@"JNSH",
                          @"version":AppVersion,
                          @"imei":[JNSHAutoSize getDiviceIMEI]
                          };
    NSString *action = @"UserLoginState";
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":TOKEN,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        
       
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        
        //NSLog(@"%@,%@",resultdic,code);
        if([code isEqualToString:@"000000"]) {
            
            //HUD
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            [self.view addSubview:HUD];
            HUD.labelText = @"登录中...";
            [HUD show:YES];
            
            [HUD hide:YES afterDelay:1.5];
            
            [JNSYUserInfo getUserInfo].isLoggedIn = YES;
            [JNSYUserInfo getUserInfo].userCode = resultdic[@"userCode"];
            [JNSYUserInfo getUserInfo].userPhone = resultdic[@"userPhone"];
            [JNSYUserInfo getUserInfo].userName = resultdic[@"userName"];                 //用户昵称
            [JNSYUserInfo getUserInfo].shopStates = resultdic[@"shopStates"];
            [JNSYUserInfo getUserInfo].userToken = resultdic[@"userToken"];
            [JNSYUserInfo getUserInfo].userKey = resultdic[@"userKey"];
            [JNSYUserInfo getUserInfo].noticeFlg = resultdic[@"noticeFlg"];
            [JNSYUserInfo getUserInfo].noticeTitle = resultdic[@"noticeTitle"];
            [JNSYUserInfo getUserInfo].noticeText = resultdic[@"noticeText"];
            [JNSYUserInfo getUserInfo].userNick = resultdic[@"userNick"];
            //获取广告图片
           // [self getadvertiseImage];
            
            
            //保存用户账号
            [User setObject:accountFiled.text forKey:@"UserAccount"];
            [User setObject:pwdTextFiled.text forKey:@"UserPwd"];
            [User synchronize];
            //登录环信
            
            //[self loginHXIM];
            
            [self performSelector:@selector(BackToLogin) withObject:nil afterDelay:1.5];
            
        }else {
           
            [HUD hide:YES];
          
            NSString *msg = resultdic[@"msg"];
            [JNSHAutoSize showMsg:msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

}

- (void)BackToLogin {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//注册
- (void)resign {
    
    
    NSLog(@"注册");
    JNSHResignViewController *ResignVc = [[JNSHResignViewController alloc] init];
    ResignVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ResignVc animated:YES];
    
}

//取消
- (void)cancle {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#define mark textfiledDeleage

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger length = (textField.text.length == range.location) ? range.location : (range.location - 1);
    
    if (textField.tag == 101) {
        if (![accountFiled.text isEqualToString:@""] && (length >= 0)) {
            LogoInBtn.enabled = YES;
        }else {
            LogoInBtn.enabled = NO;
        }
    }else if (textField.tag == 100) {
        
        if(![pwdTextFiled.text isEqualToString:@""] && (length >= 0)){
            LogoInBtn.enabled = YES;
        }else {
            LogoInBtn.enabled = NO;
        }
        
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x,  - [JNSHAutoSize height:100], KscreenWidth, KscreenHeight);
    }];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(self.view.frame.origin.x,  0, KscreenWidth, KscreenHeight);
    }];
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    
    LogoInBtn.enabled = NO;
    
    return YES;
    
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
