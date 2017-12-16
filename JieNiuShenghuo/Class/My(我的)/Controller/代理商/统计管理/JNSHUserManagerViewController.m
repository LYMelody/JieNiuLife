//
//  JNSHUserManagerViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/23.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHUserManagerViewController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "JNSYHighLightImageView.h"
#import "Masonry.h"
#import "JNSHUserManagerCell.h"
#import "JNSHCalendarView.h"
#import "JNSHOrderStatusView.h"
#import "JNSHUserSearchViewController.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import "JNSYUserInfo.h"

@interface JNSHUserManagerViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIImageView *dateArrow;

@property(nonatomic,strong)UIImageView *statusArrow;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,strong)UILabel *statusLab;

@property(nonatomic,strong)NSArray *orderList;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endtime;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *userAccount;

@property(nonatomic,assign)NSInteger currentPage;

@end

@implementation JNSHUserManagerViewController {
    
    JNSHOrderStatusView *orderView;
    JNSHCalendarView *calendar;
    UITableView *table;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"商户管理";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = ColorTableBackColor;
    
}

//获取当时日期
- (NSString*)getToday
{
    NSDate *today = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [df stringFromDate:today];
    //NSString *dateStr = [dateString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return dateString;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //顶部日期和状态选择视图
    [self setPickView];
    
    self.orderList = [[NSArray alloc] init];
    
    //列表
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:43], KscreenWidth, KscreenHeight - [JNSHAutoSize height:41]) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor =ColorTableBackColor;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:table];
    

    
    //获取今天的订单
    _startTime = [NSString stringWithFormat:@"%@ %@",[self getToday],@"00:00:00"];
    _endtime = [NSString stringWithFormat:@"%@ %@",[self getToday],@"23:59:59"];
    _status = @"";
    _userAccount = @"";
    
    [self searchForUserInfo:_status usrAccount:_userAccount startTime:_startTime endTime:_endtime page:0];
    
    
}

- (void)setPickView {
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(Search) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchBtn];
    
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:75], [JNSHAutoSize height:41]));
    }];
    
    JNSYHighLightImageView *dateImg = [[JNSYHighLightImageView alloc] init];
    dateImg.userInteractionEnabled = YES;
    dateImg.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateSelect)];
    dateTap.numberOfTapsRequired = 1;
    [dateImg addGestureRecognizer:dateTap];
    
    UILabel *dateLab = [[UILabel alloc] init];
    dateLab.text = @"日期";
    dateLab.font = [UIFont systemFontOfSize:15];
    dateLab.textColor = ColorText;
    dateLab.textAlignment = NSTextAlignmentCenter;
    [dateImg addSubview:dateLab];
    
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(dateImg);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:40], [JNSHAutoSize height:15]));
    }];
    
    _dateArrow = [[UIImageView alloc] init];
    _dateArrow.image = [UIImage imageNamed:@"order_arror_down"];
    [dateImg addSubview:_dateArrow];
    
    [_dateArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateImg);
        make.left.equalTo(dateLab.mas_right).offset([JNSHAutoSize width:2]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:16], [JNSHAutoSize height:10]));
    }];
    
    [self.view addSubview:dateImg];
    
    [dateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake((KscreenWidth - 75)/2.0, [JNSHAutoSize height:41]));
    }];
    
    //状态选择
    JNSYHighLightImageView *statusImg = [[JNSYHighLightImageView alloc] init];
    statusImg.userInteractionEnabled = YES;
    statusImg.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:statusImg];
    
    UITapGestureRecognizer *statusTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(statusTapG)];
    statusTap.numberOfTapsRequired = 1;
    [statusImg addGestureRecognizer:statusTap];
    
    _statusLab = [[UILabel alloc] init];
    _statusLab.text = @"全部";
    _statusLab.textColor = ColorText;
    _statusLab.textAlignment = NSTextAlignmentCenter;
    _statusLab.font = [UIFont systemFontOfSize:15];
    [statusImg addSubview:_statusLab];
    
    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(statusImg);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
    UIImageView *statusArrow = [[UIImageView alloc] init];
    statusArrow.image = [UIImage imageNamed:@"order_arror_down"];
    [statusImg addSubview:statusArrow];
    [statusArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(statusImg);
        make.left.equalTo(_statusLab.mas_right).offset([JNSHAutoSize width:2]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:16], [JNSHAutoSize height:10]));
    }];
    
    [self.view addSubview:statusImg];
    
    [statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(dateImg.mas_right).offset([JNSHAutoSize width:1]);
        make.right.equalTo(searchBtn.mas_left).offset(-[JNSHAutoSize width:1]);
        make.height.mas_equalTo([JNSHAutoSize height:41]);
    }];
    
}

//搜索
- (void)Search {
    
    NSLog(@"搜索");
    
    JNSHUserSearchViewController *searchVc = [[JNSHUserSearchViewController alloc] init];
    searchVc.startTime = _startTime;
    searchVc.endTime = _endtime;
    searchVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVc animated:YES];
    
}

//日期选择
- (void)dateSelect {
    
    if (orderView.alpha > 0) {
        _statusArrow.image = [UIImage imageNamed:@"order_arror_down"];
        [orderView dismiss];
    }
    
    if (calendar.alpha > 0) {
        _dateArrow.image = [UIImage imageNamed:@"order_arror_down"];
        [calendar dismiss];
    }else {
        
        calendar = [[JNSHCalendarView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, KscreenHeight)];
        calendar.userInteractionEnabled = YES;
        
        __weak typeof(self) weakSelf = self;
        
        //日历消失
        calendar.dismissblock = ^{
            __strong typeof(self) stongSelf = weakSelf;
            stongSelf.dateArrow.image = [UIImage imageNamed:@"order_arror_down"];
        };
        
        //确定日期
        calendar.datechoseblock = ^(NSString *startime, NSString *Endtime) {

            __strong typeof(self) stongSelf = weakSelf;

            //startime = [startime stringByReplacingOccurrencesOfString:@"-" withString:@""];
            startime = [startime stringByAppendingString:@" 00:00:00"];
            //Endtime = [Endtime stringByReplacingOccurrencesOfString:@"-" withString:@""];
            Endtime = [Endtime stringByAppendingString:@" 23:59:59"];

            stongSelf.startTime = startime;
            stongSelf.endtime = Endtime;
            //更新当前页
            stongSelf.currentPage = 0;

            //获取新的订单
            [stongSelf searchForUserInfo:stongSelf.status usrAccount:stongSelf.userAccount startTime:stongSelf.startTime endTime:stongSelf.endtime page:stongSelf.currentPage];

            //NSLog(@"start:%@ end:%@",startime,Endtime);
        };
        
        _dateArrow.image = [UIImage imageNamed:@"order_arror_up"];
        
        [calendar showInView:self.view];
        
    }
}

//状态选择
- (void)statusTapG {
    
    //NSLog(@"状态选择");
    
    NSArray *array = @[@"全部",@"初始化",@"审核通过",@"审核失败"];
    
    if (calendar.alpha > 0) {
        _dateArrow.image = [UIImage imageNamed:@"order_arror_down"];
        [calendar dismiss];
    }
    
    if (orderView.alpha > 0) {
        _statusArrow.image = [UIImage imageNamed:@"order_arror_down"];
        [orderView dismiss];
    } else {
        orderView = [[JNSHOrderStatusView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, KscreenHeight)];
        orderView.selectIndex = self.selectIndex;
        orderView.array = array;
        __weak typeof(self) weakSelf = self;
        
        orderView.selectblock = ^(NSIndexPath *index) {  //类型选择
            __strong typeof(self) strongSelf = weakSelf;
            
            strongSelf.selectIndex = index.row;
            strongSelf.statusLab.text = array[index.row];
            strongSelf.statusArrow.image = [UIImage imageNamed:@"order_arror_down"];
            //判断当前类型
            if (strongSelf.selectIndex == 0) {
                strongSelf.status = @"";
            }else if (strongSelf.selectIndex == 1) {
                strongSelf.status = @"10";
            }else if (strongSelf.selectIndex == 2) {
                strongSelf.status = @"20";
            }else if (strongSelf.selectIndex == 3) {
                strongSelf.status = @"12";
            }
            //跟新当前页
            strongSelf.currentPage = 0;
            [strongSelf searchForUserInfo:strongSelf.status usrAccount:strongSelf.userAccount startTime:strongSelf.startTime endTime:strongSelf.endtime page:strongSelf.currentPage];
            
        };
        
        orderView.dismissBlock = ^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.statusArrow.image = [UIImage imageNamed:@"order_arror_down"];
        };
        
        self.statusArrow.image = [UIImage imageNamed:@"order_arror_up"];
        //orderView.selectIndex = 0;
        [orderView showinView:self.view];
        
    }
}

//获取商户列表
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
            [table reloadData];
        }else {
            [table reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"error :%@",error);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"%ld",self.orderList.count);
    
    return self.orderList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHUserManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHUserManagerCell alloc] init];
        cell.UserNameLab.text = [NSString stringWithFormat:@"%@",self.orderList[indexPath.row][@"userAccount"]];
        cell.ResignTimeLab.text = [NSString stringWithFormat:@"%@",self.orderList[indexPath.row][@"regDate"]];
        cell.NumPhoneLab.text = [NSString stringWithFormat:@"%@",self.orderList[indexPath.row][@"userPhone"]];
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
