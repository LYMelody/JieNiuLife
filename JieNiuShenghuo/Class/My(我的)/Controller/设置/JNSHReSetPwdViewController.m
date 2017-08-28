//
//  JNSHReSetPwdViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/8.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHReSetPwdViewController.h"
#import "Masonry.h"
#import "JNSHAutoSize.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "MBProgressHUD.h"
#import "JNSHForgetPwdViewController.h"
@interface JNSHR_eSetPwdViewController ()<UITextFieldDelegate>

@end

@implementation JNSHR_eSetPwdViewController {
    
    UIImageView *correctImg;
    UIButton *SureBtn;
    UITextField *OldFld;
    UITextField *NewFld;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"修改密码";
    
    self.view.backgroundColor = ColorTableBackColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //视图布局
    [self setUpViews];
    
    
}

- (void)setUpViews{
    
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *whiteBackImgOne = [[UIImageView alloc] init];
    whiteBackImgOne.backgroundColor = [UIColor whiteColor];
    whiteBackImgOne.userInteractionEnabled = YES;
    
    [self.view addSubview:whiteBackImgOne];
    
    [whiteBackImgOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(20 + 64);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *OldPwdLab = [[UILabel alloc] init];
    OldPwdLab.textColor = ColorText;
    OldPwdLab.font = [UIFont systemFontOfSize:15];
    OldPwdLab.textAlignment = NSTextAlignmentLeft;
    OldPwdLab.text = @"原密码";
    
    [whiteBackImgOne addSubview:OldPwdLab];
    
    [OldPwdLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(whiteBackImgOne);
        make.left.equalTo(whiteBackImgOne).offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 44));
    }];
    
    OldFld = [[UITextField alloc] init];
    OldFld.tag = 100;
    OldFld.placeholder = @"请输入原密码";
    OldFld.textAlignment = NSTextAlignmentLeft;
    OldFld.font = [UIFont systemFontOfSize:13];
    OldFld.secureTextEntry = YES;
    OldFld.delegate = self;
    [whiteBackImgOne addSubview:OldFld];
    
    [OldFld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(whiteBackImgOne);
        make.left.equalTo(OldPwdLab.mas_right).offset(5);
        make.width.mas_equalTo(KscreenWidth - 160);
    }];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:blueColor forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forgetBtn addTarget:self action:@selector(forget) forControlEvents:UIControlEventTouchUpInside];
    [whiteBackImgOne addSubview:forgetBtn];
    
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(whiteBackImgOne);
        
        make.right.equalTo(whiteBackImgOne).offset(-6);
        make.width.mas_equalTo(80);
    }];
    
    UIImageView *whietBackTwo = [[UIImageView alloc] init];
    whietBackTwo.backgroundColor = [UIColor whiteColor];
    whietBackTwo.userInteractionEnabled = YES;
    [self.view addSubview:whietBackTwo];
    
    [whietBackTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whiteBackImgOne.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *NewLab = [[UILabel alloc] init];
    NewLab.text = @"新密码";
    NewLab.font = [UIFont systemFontOfSize:15];
    NewLab.textColor = ColorText;
    NewLab .textAlignment = NSTextAlignmentLeft;
    [whietBackTwo addSubview:NewLab];
    
    [NewLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(whietBackTwo);
        make.left.equalTo(whietBackTwo).offset(15);
        make.size.mas_equalTo(CGSizeMake(60, 44));
    }];
    
    NewFld = [[UITextField alloc] init];
    NewFld.tag = 101;
    NewFld.placeholder = @"请输入新密码";
    NewFld.font =  [UIFont systemFontOfSize:13];
    NewFld.secureTextEntry = YES;
    NewFld.textAlignment = NSTextAlignmentLeft;
    NewFld.delegate = self;
    [whietBackTwo addSubview:NewFld];
    
    [NewFld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(whietBackTwo);
        make.left.equalTo(NewLab.mas_right).offset(5);
        make.width.mas_equalTo(KscreenWidth - 160);
    }];
    
    correctImg = [[UIImageView alloc] init];
    correctImg.image = [UIImage imageNamed:@"password_checkmark"];
    correctImg.contentMode = UIViewContentModeScaleAspectFill;
    correctImg.hidden = YES;
    [whietBackTwo addSubview:correctImg];
    
    [correctImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(whietBackTwo);
        make.centerX.equalTo(forgetBtn);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.text = @"密码由6-20位字母、数字或符号组成";
    tipsLab.font = [UIFont systemFontOfSize:12];
    tipsLab.textColor = GrayColor;
    tipsLab.textAlignment = NSTextAlignmentLeft;
    
    [self.view addSubview:tipsLab];
    
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(whietBackTwo.mas_bottom).offset(5);
        make.left.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth - 20, 13));
    }];
    
    SureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [SureBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [SureBtn setBackgroundImage:[UIImage imageNamed:@"btn_non-clickable"] forState:UIControlStateNormal];
    [SureBtn setBackgroundImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateSelected];
    [SureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [SureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    SureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    SureBtn.enabled = NO;
    SureBtn.layer.cornerRadius = 3;
    SureBtn.layer.masksToBounds = YES;
    
    [self.view addSubview:SureBtn];
    
    
    [SureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipsLab.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(36);
    }];
    
    //三条线
    UIImageView *topLine = [[UIImageView alloc] init];
    topLine.backgroundColor = ColorLineSeperate;
    [whiteBackImgOne addSubview:topLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(whiteBackImgOne);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    UIImageView *midLine = [[UIImageView alloc] init];
    midLine.backgroundColor = ColorLineSeperate;
    [whiteBackImgOne addSubview:midLine];
    
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(whiteBackImgOne);
        make.left.equalTo(whiteBackImgOne).offset(15);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    UIImageView *bottomLine = [[UIImageView alloc] init];
    bottomLine.backgroundColor = ColorLineSeperate;
    [whietBackTwo addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(whietBackTwo);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
}

- (void)sure {
    
    NSLog(@"确认");
    
    
    NSDictionary *dic = @{
                          
                          @"oldPass":OldFld.text,
                          @"newPass":NewFld.text
                          };
    NSString *action = @"UserLoginPassModifyState";
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        
        NSLog(@"%@,%@",resultdic,code);
        if([code isEqualToString:@"000000"]) {
            
            
            MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            HUD.mode = MBProgressHUDModeText;
            HUD.labelText = @"修改密码成功!";
            // [HUD hideAnimated:YES afterDelay:1.5];
            [HUD hide:YES afterDelay:1.5];
            [self performSelector:@selector(BackToLogin) withObject:nil afterDelay:1.5];
            
        }else {
            NSString *msg = resultdic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)BackToLogin
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)forget {
    
    NSLog(@"忘记密码");
    
    JNSHForgetPwdViewController *ForgetVc = [[JNSHForgetPwdViewController alloc] init];
    ForgetVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:ForgetVc animated:YES];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
   
    if (textField.tag == 101) {
        NSInteger length = (textField.text.length == range.location) ? range.location : (range.location - 1);
        
        if (length >= 5) {
            correctImg.hidden = NO;
            SureBtn.enabled = YES;
            [SureBtn setBackgroundImage:[UIImage imageNamed:@"btn_nor"] forState:UIControlStateNormal];
        }else {
            correctImg.hidden = YES;
            SureBtn.enabled = NO;
            [SureBtn setBackgroundImage:[UIImage imageNamed:@"btn_non-clickable"] forState:UIControlStateNormal];
        }
    }
    
    if (range.location > 19) {
        return NO;
    }
    
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
