//
//  JNSHUserSearchViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/27.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHUserSearchViewController.h"
#import "UINavigationController+Cloudox.h"
#import "UIViewController+Cloudox.h"
#import "JNSHUserManagerCell.h"
#import "Masonry.h"

@interface JNSHUserSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHUserSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"商户搜索";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 3;
    searchBtn.layer.masksToBounds = YES;
    searchBtn.backgroundColor = BlueColor;
    [searchBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset([JNSHAutoSize height:10]);
        make.right.equalTo(self.view).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:51], [JNSHAutoSize height:21]));
    }];
    
    UITextField *Fld = [[UITextField alloc] init];
    Fld.textAlignment = NSTextAlignmentLeft;
    Fld.font = [UIFont systemFontOfSize:14];
    Fld.backgroundColor = [UIColor whiteColor];
    Fld.placeholder = @"请输入商户名称进行搜索";
    Fld.textColor = ColorText;
    [self.view addSubview:Fld];
    
    [Fld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view).offset([JNSHAutoSize width:15]);
        make.right.equalTo(searchBtn.mas_left).offset(-[JNSHAutoSize width:10]);
        make.height.mas_equalTo([JNSHAutoSize height:41]);
    }];
    
    //横线
    UIImageView *LineImg = [[UIImageView alloc] init];
    LineImg.backgroundColor = ColorLineSeperate;
    [self.view addSubview:LineImg];
    
    [LineImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(Fld.mas_bottom);
        make.height.mas_equalTo([JNSHAutoSize height:2]);
    }];
    
    //列表
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:43], KscreenWidth, KscreenHeight - [JNSHAutoSize height:41]) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor =ColorTableBackColor;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:table];
    
}

//搜索
- (void)search {
    
    NSLog(@"搜索");
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHUserManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHUserManagerCell alloc] init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
    
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
