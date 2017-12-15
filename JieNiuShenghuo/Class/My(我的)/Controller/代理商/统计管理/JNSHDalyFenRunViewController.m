//
//  JNSHDalyFenRunViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHDalyFenRunViewController.h"
#import "UIViewController+Cloudox.h"
#import "JNSYHighLightImageView.h"
#import "Masonry.h"
#import "JNSHCalendarView.h"
#import "JNSHOrderStatusView.h"
#import "JNSHAgentOrderCell.h"
#import "JNSHDalyFenRunCell.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"

@interface JNSHDalyFenRunViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *dateArrow;

@property(nonatomic,strong)UIImageView *statusArrow;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,strong)UILabel *statusLab;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,strong)NSArray *orderList;

@property(nonatomic,assign)NSInteger currentPage;

@property(nonatomic,copy)NSString *status;

@property(nonatomic,copy)NSString *headerMsg;

@end

@implementation JNSHDalyFenRunViewController {
    
    JNSHOrderStatusView *orderView;
    JNSHCalendarView *calendar;
    UITableView *table;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"日分润汇总";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = ColorTableBackColor;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
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
        make.top.equalTo(self.view).offset(1);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake((KscreenWidth - 1)/2.0, [JNSHAutoSize height:41]));
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
    
    _statusArrow = [[UIImageView alloc] init];
    _statusArrow.image = [UIImage imageNamed:@"order_arror_down"];
    [statusImg addSubview:_statusArrow];
    [_statusArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(statusImg);
        make.left.equalTo(_statusLab.mas_right).offset([JNSHAutoSize width:2]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:16], [JNSHAutoSize height:10]));
    }];
    
    [self.view addSubview:statusImg];
    
    [statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(1);
        make.left.equalTo(dateImg.mas_right).offset([JNSHAutoSize width:1]);
        make.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:41]);
    }];
    
    self.orderList = [[NSArray alloc] init];
    
    //列表
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:43], KscreenWidth, KscreenHeight - [JNSHAutoSize height:41+64+64-20]) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor =ColorTableBackColor;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.sectionHeaderHeight = [JNSHAutoSize height:41];
    table.sectionFooterHeight = [JNSHAutoSize height:5];
    [self.view addSubview:table];
    
    //获取今天的订单
    _startTime = [NSString stringWithFormat:@"%@",[self getToday]];
    _endTime = [NSString stringWithFormat:@"%@",[self getToday]];
    _status = @"";
    self.currentPage = 0;
    
    [self requestForInfo:_status statrtime:self.startTime endTime:self.endTime page:self.currentPage];
    
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
            startime = [startime stringByAppendingString:@""];
            //Endtime = [Endtime stringByReplacingOccurrencesOfString:@"-" withString:@""];
            Endtime = [Endtime stringByAppendingString:@""];

            stongSelf.startTime = startime;
            stongSelf.endTime = Endtime;
            //更新当前页
            stongSelf.currentPage = 0;

            //获取新的订单
            [stongSelf requestForInfo:stongSelf.status statrtime:stongSelf.startTime endTime:stongSelf.endTime page:stongSelf.currentPage];

            
        };
        
        _dateArrow.image = [UIImage imageNamed:@"order_arror_up"];
        
        [calendar showInView:self.view];
        
    }
}

//状态选择
- (void)statusTapG {
    
    //NSLog(@"状态选择");
    
    NSArray *array = @[@"全部",@"已入账",@"未入账"];
    
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
                    strongSelf.status = @"2";
                }else if (strongSelf.selectIndex == 2) {
                    strongSelf.status = @"0";
                }
                //跟新当前页
                strongSelf.currentPage = 0;
           
            [strongSelf requestForInfo:strongSelf.status statrtime:strongSelf.startTime endTime:strongSelf.endTime page:strongSelf.currentPage];
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

- (void)requestForInfo:(NSString *)status statrtime:(NSString *)startTime endTime:(NSString *)endTime page:(NSInteger)page {
    
    NSDictionary *dic = @{
                          @"stsStatus":status,
                          @"ts":startTime,
                          @"te":endTime,
                          @"page":[NSString stringWithFormat:@"%ld",page],
                          @"limit":[NSString stringWithFormat:@"%d",10]
                          };
    NSString *action = @"OrgProfitDay";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSString *code = resultDic[@"code"];
        NSLog(@"%@",resultDic);
        if ([code isEqualToString:@"000000"]) {
            NSString *allPrice = resultDic[@"allProfit"];
            _headerMsg = [NSString stringWithFormat:@"当前分润汇总:￥%.2f",[allPrice intValue]/100.0];
            
            if ([resultDic[@"records"] isKindOfClass:[NSArray class]]) {
                self.orderList = resultDic[@"records"];
                [table reloadData];
            }
        }else {
            NSString *msg = resultDic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.orderList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHDalyFenRunCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHDalyFenRunCell alloc] init];
        cell.fenRunTimeLab.text = self.orderList[indexPath.row][@"profitDay"];
        NSString *status = [NSString stringWithFormat:@"%@",self.orderList[indexPath.row][@"stsStatus"]];
        if ([status isEqualToString:@"0"]) {
            cell.cashStatusLab.text = @"未入账";
            cell.cashStatusLab.textColor = [UIColor redColor];
        }else {
            cell.cashStatusLab.text = @"已入账";
            cell.cashStatusLab.textColor = GreenColor;
        }
        
        cell.amountLab.text = [NSString stringWithFormat:@"￥%.2f",[self.orderList[indexPath.row][@"profitPrice"] intValue]/100.0];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 71;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:41])];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = ColorText;
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.text = _headerMsg;
    [view addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:41]));
    }];
    
    UIImageView *BottomLine = [[UIImageView alloc] init];
    BottomLine.backgroundColor = ColorLineSeperate;
    [view addSubview:BottomLine];
    
    [BottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(view);
        make.height.mas_equalTo([JNSHAutoSize height:SeperateLineWidth]);
    }];
    
    return view;
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
