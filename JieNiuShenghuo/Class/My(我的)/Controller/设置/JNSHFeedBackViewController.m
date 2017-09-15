//
//  JNSHFeedBackViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/8.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHFeedBackViewController.h"
#import "Masonry.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSYUserInfo.h"
#import "MBProgressHUD.h"

@interface JNSHFeedBackViewController ()<UITextViewDelegate>

@end

@implementation JNSHFeedBackViewController{
    
    UILabel *placeholderLab;
    UIButton *CommitBtn;
    UITextView *textView;
    UITextField *textFiled;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"意见反馈";
    self.view.backgroundColor = ColorTableBackColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"问题和意见";
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.textColor = ColorText;
    
    [self.view addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(15);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth - 20, 30));
    }];
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.backgroundColor = [UIColor whiteColor];
    backImg.userInteractionEnabled = YES;
    
    [self.view addSubview:backImg];
    
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLab.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    
    textView = [[UITextView alloc] init];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.delegate = self;
    [backImg addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImg);
        make.left.equalTo(backImg).offset(15);
        make.right.equalTo(backImg).offset(-15);
        make.height.mas_equalTo(100);
    }];
    
    //textView placeholder
    placeholderLab = [[UILabel alloc] init];
    placeholderLab.text = @"请输入您宝贵的意见";
    placeholderLab.textAlignment = NSTextAlignmentLeft;
    placeholderLab.textColor = [UIColor lightGrayColor];
    placeholderLab.font = [UIFont systemFontOfSize:13];
    placeholderLab.backgroundColor = [UIColor whiteColor];
    [textView addSubview:placeholderLab];
    [placeholderLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView).offset(10);
        make.left.equalTo(textView).offset(6);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth - 40, 13));
    }];
    
    textFiled = [[UITextField alloc] init];
    textFiled.backgroundColor = [UIColor whiteColor];
    textFiled.placeholder = @"请留下您的联系方式，可不填。";
    textFiled.font = [UIFont systemFontOfSize:13];
    textFiled.textColor = ColorText;
    textFiled.keyboardType = UIKeyboardTypeNumberPad;
    textFiled.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *leftView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    textFiled.leftView = leftView;
    textFiled.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:textFiled];
    
    [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(36);
    }];
    
    
    CommitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [CommitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [CommitBtn setBackgroundImage:[UIImage imageNamed:@"btn_non-clickable"] forState:UIControlStateNormal];
    [CommitBtn setBackgroundImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateSelected];
    [CommitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [CommitBtn addTarget:self action:@selector(Commit) forControlEvents:UIControlEventTouchUpInside];
    CommitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    CommitBtn.enabled = NO;
    [self.view addSubview:CommitBtn];
    
    [CommitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textFiled.mas_bottom).offset(40);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(41);
    }];
    
    
}

- (void)Commit {
    
    
    NSLog(@"提交");
    
    NSString *context;
    
    if ([textView.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"请输入您的宝贵意见!"];
        return;
    }else if ([textFiled.text isEqualToString:@""]) {
        context = @"1";
    }else {
        context = textFiled.text;
    }
    
    NSDictionary *dic = @{
                          @"content":textView.text,
                          @"contact":context
                          };
    
    NSString *action = @"UserFeedbackState";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSString *code = resultDic[@"code"];
        NSString *msg = resultDic[@"msg"];
        if ([code isEqualToString:@"000000"]) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"提交成功";
            [hud hide:YES afterDelay:1.5];
            [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)back {
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    if (![text isEqualToString:@""]) {
        
        
        placeholderLab.hidden = YES;
        
        [CommitBtn setBackgroundImage:[UIImage imageNamed:@"btn_nor"] forState:UIControlStateNormal];
        CommitBtn.enabled = YES;
        
    }
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
        placeholderLab.hidden = NO;
        [CommitBtn setBackgroundImage:[UIImage imageNamed:@"btn_non-clickable"] forState:UIControlStateNormal];
        CommitBtn.enabled = NO;
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
