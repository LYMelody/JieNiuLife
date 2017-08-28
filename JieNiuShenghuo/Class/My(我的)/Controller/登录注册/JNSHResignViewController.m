//
//  JNSHResignViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/24.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHResignViewController.h"
#import "JNSHGetCodeCell.h"
#import "JNSHLabFldCell.h"
#import "Masonry.h"
#import "JNSHCommonButton.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSHAutoSize.h"
#import "MBProgressHUD.h"
@interface JNSHResignViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation JNSHResignViewController {
    
    NSTimer *timer;
    NSInteger index;
    JNSHGetCodeCell *CodeCell;
    UITableView *table;
    JNSHLabFldCell *PwdCell;
    JNSHLabFldCell *NumCell;
    JNSHLabFldCell *OrgCell;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"账户注册";
    self.view.backgroundColor = ColorTabBarBackColor;
    
    //self.navigationController.navigationBar.hidden = NO;
    
    self.navigationController.navigationBar.barTintColor = ColorTabBarBackColor;
    //设置导航栏标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *tabbarBackimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, 64)];
    tabbarBackimg.backgroundColor = ColorTabBarBackColor;
    [self.view addSubview:tabbarBackimg];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight-64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.scrollEnabled = NO;
    
    [self.view addSubview:table];
    
    //headerView
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:15])];
    headerView.backgroundColor = ColorTableBackColor;
    
    table.tableHeaderView = headerView;
    
    //footView
    
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:120])];
    footView.userInteractionEnabled = YES;
    //记住密码
    UIButton *remberBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [remberBtn setImage:[UIImage imageNamed:@"---checkmark"] forState:UIControlStateNormal];
    [remberBtn setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateSelected];
    [remberBtn addTarget:self action:@selector(rember:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:remberBtn];
    
    [remberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset([JNSHAutoSize width:16]);
        make.top.equalTo(footView).offset([JNSHAutoSize height:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:14], [JNSHAutoSize height:15]));
    }];
    
    UILabel *rightLab = [[UILabel alloc] init];
    rightLab.text = @"同意用户协议";
    rightLab.font = [UIFont systemFontOfSize:13];
    rightLab.textColor = ColorTabBarBackColor;
    rightLab.textAlignment = NSTextAlignmentLeft;
    [footView addSubview:rightLab];
    
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(remberBtn);
        make.left.equalTo(remberBtn.mas_right).offset([JNSHAutoSize width:5]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:15]));
    }];
    
    JNSHCommonButton *ResignBtn = [[JNSHCommonButton alloc] init];
    [ResignBtn setTitle:@"注册" forState:UIControlStateNormal];
    [ResignBtn addTarget:self action:@selector(resign) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:ResignBtn];
    
    [ResignBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remberBtn.mas_bottom).offset([JNSHAutoSize height:60]);
        make.left.equalTo(footView).offset([JNSHAutoSize width:15]);
        make.right.equalTo(footView).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:41]);
    }];
    
    
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

    
    //客服电话
    
    UILabel *lab = [[UILabel alloc] init];
    lab.font = [UIFont systemFontOfSize:14];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = ColorTabBarBackColor;
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:@"客服电话：400-1200-1200"];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 5)];
    
    lab.attributedText = attr;
    
    [table addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-[JNSHAutoSize height:40]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:20]));
    }];

}
//注册
- (void)resign {
    
    NSLog(@"注册");
    
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
    
    if ([OrgCell.textFiled.text isEqualToString:@""] || OrgCell.textFiled == nil) {
        [JNSHAutoSize showMsg:@"邀请码为空!"];
        return;
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.labelText = @"注册中...";
    [self.view addSubview:hud];
    [hud show:YES];
    
    NSDictionary *dic = @{
                          @"phone":CodeCell.textFiled.text,
                          @"code":NumCell.textFiled.text,
                          @"pass":PwdCell.textFiled.text,
                          @"org":OrgCell.textFiled.text,
                          };
    NSString *action = @"UserRegisterState";
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":TOKEN,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        
        NSLog(@"%@",result);
        
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        
        NSLog(@"%@,%@",resultdic,code);
        if([code isEqualToString:@"000000"]) {
            
            [JNSHAutoSize showMsg:@"注册成功!"];
            
            [self performSelector:@selector(BackToLogin) withObject:nil afterDelay:2];
            
        }else {
            NSString *msg = resultdic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
        [hud hide:YES];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
        [hud hide:YES];
        
    }];
    
}

- (void)BackToLogin {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


//同意
- (void)rember:(UIButton *)btn {
    
    btn.selected = !btn.selected;
    
    NSLog(@"同意");
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
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
            CodeCell.showBottom = YES;
            CodeCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            
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
            cell.backgroundColor = ColorTableBackColor;
            
        }else if (indexPath.row == 3) {
            NumCell = [[JNSHLabFldCell alloc] init];
            NumCell.leftLab.text = @"验证码";
            NumCell.textFiled.placeholder = @"请输入验证码";
            NumCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            cell = NumCell;
        }else if (indexPath.row == 4) {
            OrgCell = [[JNSHLabFldCell alloc] init];
            OrgCell.leftLab.text = @"邀请码";
            OrgCell.textFiled.placeholder = @"邀请码为11位手机号码";
            OrgCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            cell = OrgCell;
        }
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        return 15;
    }
    
    return 41;
    
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
    
    NSString *action = @"UserRegisterStateSms";
    NSDictionary *RequestDic = @{
                                 @"action":action,
                                 @"token":TOKEN,
                                 @"data":dic,
                                 };
    NSString *params = [RequestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSLog(@"%@",result);
        
        NSDictionary *resultDic = [result JSONValue];
        NSString *code = resultDic[@"code"];
        NSString *msg = resultDic[@"respMsg"];
        if ([code isEqualToString:@"000000"]) {
            
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
            index = 60;
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
        
        [CodeCell.codeBtn setTitle:[NSString stringWithFormat:@"重新获取%lds",(long)index] forState:UIControlStateNormal];
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
