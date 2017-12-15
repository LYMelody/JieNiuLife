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
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSYUserInfo.h"

@interface JNSHUserSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITextField *Fld;

@property(nonatomic,strong)NSArray *orderList;

@end

@implementation JNSHUserSearchViewController {
    
    UITableView *table;
    UILabel *tipsLab;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"商户搜索";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = ColorTableBackColor;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backImg];
    
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:41]);
    }];
    
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
    
    _Fld = [[UITextField alloc] init];
    _Fld.textAlignment = NSTextAlignmentLeft;
    _Fld.font = [UIFont systemFontOfSize:14];
    _Fld.backgroundColor = [UIColor whiteColor];
    _Fld.placeholder = @"请输入商户名称进行搜索";
    _Fld.textColor = ColorText;
    [self.view addSubview:_Fld];
    
    [_Fld mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(_Fld.mas_bottom);
        make.height.mas_equalTo([JNSHAutoSize height:2]);
    }];
    
    self.orderList = [[NSArray alloc] init];
    
    //列表
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:43], KscreenWidth, KscreenHeight - [JNSHAutoSize height:41]) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor =ColorTableBackColor;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:table];
    
    tipsLab = [[UILabel alloc] init];
    tipsLab.textColor = ColorText;
    tipsLab.font = [UIFont systemFontOfSize:14];
    tipsLab.text = @"找不到该商户，请确认信息后重试！";
    tipsLab.textAlignment = NSTextAlignmentCenter;
    tipsLab.hidden = YES;
    tipsLab.backgroundColor = ColorTableBackColor;
    [self.view addSubview:tipsLab];
    
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.Fld.mas_bottom).offset([JNSHAutoSize height:40]);
        make.height.mas_equalTo([JNSHAutoSize height:30]);
    }];
    
}

//搜索
- (void)search {
    
    NSLog(@"搜索");
    
    [self searchForUserInfo:@"" usrAccount:self.Fld.text startTime:self.startTime endTime:self.endTime page:0];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.orderList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHUserManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHUserManagerCell alloc] init];
        cell.UserNameLab.text = self.orderList[indexPath.row][@"userAccount"];
        cell.ResignTimeLab.text = self.orderList[indexPath.row][@"regDate"];
        cell.NumPhoneLab.text = self.orderList[indexPath.row][@"userPhone"];
        NSString *status = [NSString stringWithFormat:@"%@",self.orderList[indexPath.row][@"userStatus"]];
        if([status isEqualToString:@"10"]) {
            cell.ResignStatusLab.text = @"初始化";
            cell.ResignStatusLab.textColor = [UIColor orangeColor];
        }else if ([status isEqualToString:@"20"]) {
            cell.ResignStatusLab.text = @"审核通过";
            cell.ResignStatusLab.textColor = GreenColor;
        }else {
            cell.ResignStatusLab.text = @"审核失败";
            cell.ResignStatusLab.textColor = [UIColor redColor];
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65;
    
}

- (void)searchForUserInfo:(NSString *)status usrAccount:(NSString *)userAccount startTime:(NSString *)startTime endTime:(NSString *)endTime page:(NSInteger)page {
    
    NSDictionary *dic = @{
                          @"userStatus":status,
                          @"userAccount":userAccount,
                          @"ts":startTime,
                          @"te":endTime,
                          @"page":[NSString stringWithFormat:@"%ld",page],
                          @"limit":[NSString stringWithFormat:@"%d",10]
                          };
    
    NSString *action = @"OrgChildUser";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSLog(@"%@",resultDic);
        if ([resultDic[@"records"] isKindOfClass:[NSArray class]]) {
            self.orderList = resultDic[@"records"];
            if (self.orderList.count > 0) {
                table.hidden = NO;
                tipsLab.hidden = YES;
                [table reloadData];
            }else {
                table.hidden = YES;
                tipsLab.hidden = NO;
            }
            
        }else {
            
            table.hidden = YES;
            tipsLab.hidden = NO;
        }
    } failure:^(NSError *error) {
        NSLog(@"error :%@",error);
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
