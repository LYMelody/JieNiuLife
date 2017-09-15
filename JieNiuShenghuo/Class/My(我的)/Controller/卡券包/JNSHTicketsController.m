//
//  JNSHTicketsController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/17.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHTicketsController.h"
#import "JNSHTicketsCell.h"
#import "Masonry.h"
#import "JNSHAutoSize.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"

@interface JNSHTicketsController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHTicketsController {
    
    UITableView *table;
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"卡券包";
    
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:ColorTabBarBackColor
     
                                                                      }];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.tintColor = ColorTabBarBackColor;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    
//    UIImageView *backimg = self.navigationController.navigationBar.subviews.firstObject;
//    backimg.alpha = 0;
    self.navBarBgAlpha = @"1.0";
    self.navigationController.navigationBar.translucent = NO;
    
    if (self.tag == 2) {
        [self requestForTickets:YES];
    }else {
        [self requestForTickets:NO];
    }
    
    
    //[self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    self.navigationController.navigationBar.barTintColor = ColorTabBarBackColor;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      
                                                                      }];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    //UIImageView *backimg = self.navigationController.navigationBar.subviews.firstObject;
    //backimg.alpha = 1;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *navImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, -64, KscreenWidth, 64)];
    navImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navImg];
    
    if (!self.listArray) {
        self.listArray = [[NSArray alloc] init];
    }
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    UIImageView *footImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:80])];
    footImageView.backgroundColor = ColorTableBackColor;
    footImageView.userInteractionEnabled = YES;
    
    UILabel *footLab = [[UILabel alloc] init];
    footLab.text = @"查看已使用或已过期的刷卡金>>";
    footLab.font = [UIFont systemFontOfSize:13];
    footLab.textAlignment = NSTextAlignmentCenter;
    footLab.textColor = ColorText;
    
    [footImageView addSubview:footLab];
    
    [footLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footImageView);
        make.size.equalTo(footImageView);
    }];
    
    table.tableFooterView = footImageView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.numberOfTapsRequired = 1;
    
    [footImageView addGestureRecognizer:tap];
    if (self.tag == 2) {
        table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64)];
    backImg.backgroundColor = ColorTableBackColor;
    [self.view addSubview:backImg];
    
    UIImageView *headImg = [[UIImageView alloc] init];
    headImg.image = [UIImage imageNamed:@"coupon_"];
    [backImg addSubview:headImg];
    
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImg).offset([JNSHAutoSize height:65]);
        make.centerX.equalTo(backImg);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:70]));
    }];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = @"没有刷卡金哦!";
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = ColorText;
    titleLab.textAlignment = NSTextAlignmentCenter;
    [backImg  addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImg);
        make.top.equalTo(headImg.mas_bottom).offset([JNSHAutoSize height:20]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:15]));
    }];
    
    UILabel *subTitleLab = [[UILabel alloc] init];
    subTitleLab.text = @"每天10点、14点可领取";
    subTitleLab.font = [UIFont systemFontOfSize:13];
    subTitleLab.textColor = ColorTabBarBackColor;
    subTitleLab.textAlignment = NSTextAlignmentCenter;
    
    [backImg addSubview:subTitleLab];
    
    [subTitleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backImg);
        make.top.equalTo(titleLab.mas_bottom).offset([JNSHAutoSize height:45]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:15]));
    }];
    
    table.hidden = NO;
    backImg.hidden = YES;
    
}

//过期刷卡金
- (void)tap {
    
    JNSHTicketsController *Tickets = [[JNSHTicketsController alloc] init];
    Tickets.hidesBottomBarWhenPushed = YES;
    Tickets.tag = 2;
    [self.navigationController pushViewController:Tickets animated:YES];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.listArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHTicketsCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHTicketsCell alloc] init];
        
        
        cell.timeLab.text = [NSString stringWithFormat:@"有效期至 %@",self.listArray[indexPath.row][@"expireTime"]];
        cell.titleLab = self.listArray[indexPath.row][@"vouchersName"];
        
        if (self.tag == 2) {
            if (indexPath.row == 3) {
                cell.isUsed = YES;
            }else if (indexPath.row == 4) {
                cell.titleLab.text = @"生日刷卡抵用券";
                cell.isUpDate = YES;
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [JNSHAutoSize height:91];
    
}

//获取卡券包
- (void)requestForTickets:(BOOL)isUse {
    
    NSDictionary *dic = @{
                          @"isUse":isUse?@"1":@"0",
                          @"size":@"10",
                          @"page":@"0"
                          };
    NSString *action = @"UserVouchersList";
    
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
            
            if ([resultdic[@"records"] isKindOfClass:[NSArray class]]) {
                self.listArray = resultdic[@"records"];
            }
            
            [table reloadData];
            
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
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
