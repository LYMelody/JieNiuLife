//
//  JNSYNickNameViewController.m
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/5/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSYNickNameViewController.h"
#import "JNSHCommon.h"
#import "Masonry.h"
#import "JNSYUserInfo.h"
#import "JNSHAutoSize.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import "MBProgressHUD.h"

@interface JNSYNickNameViewController ()<UITextFieldDelegate>

@end

@implementation JNSYNickNameViewController {
    
    NSUserDefaults *User;
    UITextField *Text;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.title = @"昵称";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    User = [NSUserDefaults standardUserDefaults];
    
    UIButton *keepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    keepBtn.frame = CGRectMake(20, 0, 40, 30);
    [keepBtn setTitle:@"保存" forState:UIControlStateNormal];
    [keepBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [keepBtn setBackgroundColor:[UIColor clearColor]];
    keepBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [keepBtn addTarget:self action:@selector(KeepAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:keepBtn];
    
    
    
    UIImageView *BackImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    BackImg.backgroundColor = ColorTableBackColor;
    BackImg.userInteractionEnabled = YES;
    [self.view addSubview:BackImg];
    
    UILabel *lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(0, 0, 70, 30);
    lab.font = [UIFont systemFontOfSize:15];
    lab.text = @"昵称";
    lab.textAlignment = NSTextAlignmentCenter;
    
    Text = [[UITextField alloc] init];
    Text.backgroundColor = [UIColor whiteColor];
    Text.font = [UIFont systemFontOfSize:15];
    Text.placeholder = @"请输入昵称";
    Text.leftView = lab;
    Text.leftViewMode = UITextFieldViewModeAlways;
    Text.clearButtonMode = UITextFieldViewModeAlways;
    Text.delegate = self;
    
    NSString *NickName = [User objectForKey:@"NickName"];
    NickName = [JNSYUserInfo getUserInfo].userName;
    if (NickName) {
        Text.text = NickName;
    }else {
        Text.text = @"捷牛送药";
    }
    
    //[Text becomeFirstResponder];
    [BackImg addSubview:Text];
    
    [Text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10+64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    //顶部黑线
    UIImageView *topLine = [[UIImageView alloc] init];
    topLine.backgroundColor = ColorLineSeperate;
    
    [self.view addSubview:topLine];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(Text.mas_top);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    //底部黑线
    UIImageView *bottomline = [[UIImageView alloc] init];
    bottomline.backgroundColor = ColorLineSeperate;
    
    [self.view addSubview:bottomline];
    
    [bottomline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(Text.mas_bottom);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    
}

- (void)KeepAction {
    
    NSLog(@"keep");
    
    
    
    
    
    NSDictionary *dic =  @{
                           @"userNick":Text.text
                          };
    
    
    NSString *action = @"UserBaseDetailEditState";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"data":dic,
                                 @"token":[JNSYUserInfo getUserInfo].userToken
                                 };
    NSString *paramas = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:paramas success:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        if ([code isEqualToString:@"000000"]) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"修改成功";
            [hud hide:YES afterDelay:1];
            //[self performSelector:@selector(back) withObject:nil afterDelay:1];
            [JNSYUserInfo getUserInfo].userName = Text.text;
            
            if (_changeNickBlock) {
                _changeNickBlock();
            }
            
        }else {
            NSString *msg = dic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    
//    if (textField.text.length <= 0) {
//        
//        NSLog(@"没有输入昵称，请重新输入");
//    }else {
//        
//        
//        //[JNSYCommenMethods UpLoadUserPicHeader:nil userSex:nil birthday:nil userName:textField.text];
//        
//        [User setObject:textField.text forKey:@"NickName"];
//        [User synchronize];
//        
//        if (_changeNickBlock) {
//            _changeNickBlock();
//        }
//        
//        NSLog(@"昵称:%@",textField.text);
//    }
//    
//}

- (void)upDateUserNickName {
    
    
    
    
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
