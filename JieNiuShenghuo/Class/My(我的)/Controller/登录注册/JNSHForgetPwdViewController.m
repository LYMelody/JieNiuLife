//
//  JNSHForgetPwdViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/24.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHForgetPwdViewController.h"
#import "JNSHGetCodeCell.h"
#import "JNSHLabFldCell.h"
#import "JNSHCommonButton.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSHAutoSize.h"
#import "JNSYUserInfo.h"
#import "MBProgressHUD.h"
@interface JNSHForgetPwdViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation JNSHForgetPwdViewController {
    
    NSTimer *timer;
    NSInteger index;
    JNSHGetCodeCell *CodeCell;
    UITableView *table;
    JNSHLabFldCell *PwdCell;
    JNSHLabFldCell *NumCell;
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"忘记密码";
    self.view.backgroundColor = ColorTabBarBackColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 64)];
    backImg.backgroundColor = ColorTabBarBackColor;
    
    [self.view addSubview:backImg];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.scrollEnabled = NO;
    [self.view addSubview:table];
    
    //headerView
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:15])];
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor = ColorTableBackColor;
    
    table.tableHeaderView = headerView;
    
    //tablefootView
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:100])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    JNSHCommonButton *CommitBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:40], (KscreenWidth - [JNSHAutoSize width:30]), [JNSHAutoSize height:41])];
    [CommitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [CommitBtn setTitle:@"保存" forState:UIControlStateNormal];
    [footView addSubview:CommitBtn];
    
    table.tableFooterView = footView;
    
    //禁止滑动延迟
    table.delaysContentTouches = NO;
    for(id view in table.subviews) {
        
        if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewWrapperView"]) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrrowView = (UIScrollView *)view;
                scrrowView.delaysContentTouches = NO;
            }
            break;
        }
    }
    
}

- (void)commit {
    
    NSLog(@"保存");
    
    //发送注册请求
    if ([CodeCell.textFiled.text isEqualToString:@""] || CodeCell.textFiled == nil) {
        [JNSHAutoSize showMsg:@"手机号为空!"];
        return;
    }
    if(PwdCell.textFiled.text.length <= 12 && PwdCell.textFiled.text.length >= 6) {
        
    }else {
        [JNSHAutoSize showMsg:@"请输入6-12位密码!"];
        return;
    }
    
    if (NumCell.textFiled.text == nil || [NumCell.textFiled.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"验证码为空!"];
        return;
    }
    
    
    
    NSDictionary *dic = @{
                          @"phone":CodeCell.textFiled.text,
                          @"code":NumCell.textFiled.text,
                          @"pass":PwdCell.textFiled.text
                          
                          };
    NSString *action = @"UserFindPassState";
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
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"修改成功!";
            [hud hide:YES afterDelay:1.5];
            [self performSelector:@selector(BackToLogin) withObject:nil afterDelay:1.5];
            
        }else {
            NSString *msg = resultdic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
        //[hud hide:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
        //[hud hide:YES];
        
    }];
}

- (void)BackToLogin {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 3;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            
            CodeCell = [[JNSHGetCodeCell alloc] init];
            CodeCell.leftLab.text = @"手机号码";
            CodeCell.textFiled.placeholder = @"请输入手机号码";
            CodeCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            CodeCell.showBottom = YES;
            __weak typeof(self) weakSelf = self;
            CodeCell.getcodeBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf getcode];
            };
            cell = CodeCell;
        }else if (indexPath.row == 1) {
            PwdCell = [[JNSHLabFldCell alloc] init];
            PwdCell.leftLab.text = @"设置密码";
            PwdCell.textFiled.placeholder = @"由6-20位字母、数字或符号组成";
            PwdCell.textFiled.delegate = self;
            PwdCell.textFiled.secureTextEntry = YES;
            PwdCell.rightImg.hidden = NO;
            cell = PwdCell;
            
        }else if (indexPath.row == 2) {
            NumCell = [[JNSHLabFldCell alloc] init];
            NumCell.leftLab.text = @"验证码";
            NumCell.textFiled.placeholder = @"请输入验证码";
            NumCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            cell = NumCell;
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

//获取验证码
- (void)getcode {
    
    CodeCell.codeBtn.enabled = NO;

    if ([CodeCell.textFiled.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"手机号为空！"];
        CodeCell.codeBtn.enabled = YES;
        return;
    }
    
    NSDictionary *dic = @{
                          @"phone":CodeCell.textFiled.text
                          };
    
    NSString *action = @"UserFindPassStateSms";
    NSDictionary *RequestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic,
                                 };
    NSString *params = [RequestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *resultDic = [result JSONValue];
        NSString *code = resultDic[@"code"];
        NSString *msg = resultDic[@"respMsg"];
        if ([code isEqualToString:@"000000"]) {
            
            index = 59;
            [CodeCell.codeBtn setTitle:[NSString stringWithFormat:@"重新获取%lds",index] forState:UIControlStateNormal];
            [CodeCell.codeBtn setBackgroundColor:GrayColor];
            CodeCell.codeBtn.enabled = NO;
            
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        CodeCell.codeBtn.enabled = YES;
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        CodeCell.codeBtn.enabled = YES;
    }];
    
    
}

- (void)countDown {
    
    index--;
    
    if (index < 0) {
        [CodeCell.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [CodeCell.codeBtn setBackgroundColor:ColorTabBarBackColor];
        CodeCell.codeBtn.enabled = YES;
        [timer invalidate];
    }else {
        
        [CodeCell.codeBtn setTitle:[NSString stringWithFormat:@"重新获取%lds",index] forState:UIControlStateNormal];
        [CodeCell.codeBtn setBackgroundColor:GrayColor];
        CodeCell.codeBtn.enabled = NO;
        
    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    
    JNSHLabFldCell *cell = [table cellForRowAtIndexPath:indexPath];
    
    
    NSInteger length = (textField.text.length == range.location) ? range.location : (range.location - 1);
    
    if (length >= 5) {
        cell.rightImg.image = [UIImage imageNamed:@"password_checkmark"];
    }else {
        cell.rightImg.image = [UIImage imageNamed:@"password_checkmark_grey"];
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
