//
//  JNSYBornDateViewController.m
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/5/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSYBornDateViewController.h"
#import "JNSHCommon.h"
#import "Masonry.h"
//#import "JNSYCommenMethods.h"
@interface JNSYBornDateViewController ()

@end

@implementation JNSYBornDateViewController {
    
    UIDatePicker *Picker;
    NSUserDefaults *User;
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.title = @"出生年月";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLocale *ch_zh_locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_Hans_CN"];
    
    Picker = [[UIDatePicker alloc] init];
    Picker.datePickerMode = UIDatePickerModeDate;
    Picker.layer.borderWidth = 0.5;
    Picker.layer.borderColor = [UIColor blackColor].CGColor;
    Picker.layer.cornerRadius = 5;
    Picker.layer.masksToBounds = YES;
    Picker.locale = ch_zh_locale;
    [self.view addSubview:Picker];
    
    [Picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.left.equalTo(self.view).offset(30);
        make.right.equalTo(self.view).offset(-30);
    }];
    
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setTitle:@"确定" forState:UIControlStateNormal];
    [Btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Btn setBackgroundColor:[UIColor whiteColor]];
    Btn.layer.borderWidth = 0.5;
    Btn.layer.cornerRadius = 5;
    Btn.layer.masksToBounds = YES;
    [Btn addTarget:self action:@selector(Sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Btn];
    
    [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(Picker.mas_bottom);
        make.left.right.equalTo(Picker);
        make.height.mas_equalTo(36);
    }];
    
    User = [NSUserDefaults standardUserDefaults];
}

- (void)Sure {
    
    NSLog(@"确定");
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    NSString *datestr = [dateformatter stringFromDate:Picker.date];
    NSLog(@"%@",datestr);
    
    //上传修改日期信息
    //[JNSYCommenMethods UpLoadUserPicHeader:nil userSex:nil birthday:datestr userName:nil];
    
    [User setObject:datestr forKey:@"BirthDay"];
    [User synchronize];
    
    if (_changeBirthBlock) {
        _changeBirthBlock();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
