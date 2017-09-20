//
//  JNSHOrderViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHOrderViewController.h"
#import "Masonry.h"
#import "JNSHOrderCell.h"
#import "JNSYHighLightImageView.h"
#import "JNSHOrderStatusView.h"
#import "DAYCalendarView.h"
#import "JNSHCalendarView.h"
#import "JNSHOrderDetailController.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSYUserInfo.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"
#import "JNSHOrderModel.h"

@interface JNSHOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,strong)UILabel *statusLab;

@property(nonatomic,strong)UIImageView *rightArrow;

@property(nonatomic,strong)UIImageView *arrawImg;

@property(nonatomic,strong)NSMutableDictionary *orderDic;

@property(nonatomic,strong)NSArray *orderList;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endtime;

@property(nonatomic,copy)NSString *currentType;

@property(nonatomic,assign)NSInteger currentPage;

@end

@implementation JNSHOrderViewController {
    
    UITableView *table;
    BOOL showStatus;
    JNSHOrderStatusView *orderView;
    JNSYHighLightImageView *dateImg;
    JNSHCalendarView *calendar;
    //UIImageView *rightArrow;
//    NSString *startTime;
//    NSString *endtime;
    
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

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.title = @"订单中心";
    self.view.backgroundColor = ColorTableBackColor;
    self.navBarBgAlpha = @"1.0";
   
    if (!self.orderList) {
        self.orderList = [[NSArray alloc] init];
    }
    
    [table reloadData];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setPickViews];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, KscreenHeight - [JNSHAutoSize height:46] - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.sectionHeaderHeight = [JNSHAutoSize height:41];
    table.sectionFooterHeight = [JNSHAutoSize height:5];
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:table];
    
    //下拉刷新
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _currentPage = 0;
        [self requestForOrderList:_startTime endtime:_endtime product:_currentType page:_currentPage];
    }];
    //上拉加载
    table.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
        //翻页
        _currentPage ++;
        
        [self requestForOrderList:_startTime endtime:_endtime product:_currentType page:_currentPage];
    }];
    
    //获取今天的订单
    _startTime = [NSString stringWithFormat:@"%@ %@",[self getToday],@"00:00:00"];
    _endtime = [NSString stringWithFormat:@"%@ %@",[self getToday],@"23:59:59"];
    //当前类型为全部
    _currentType = @"";
    //初始化当前页
    _currentPage = 0;
    [self requestForOrderList:_startTime endtime:_endtime product:_currentType page:_currentPage];
    
}

//日期选择器
- (void)setPickViews{
    
    //日期
    dateImg = [[JNSYHighLightImageView alloc] init];
    dateImg.backgroundColor = [UIColor whiteColor];
    dateImg.userInteractionEnabled = YES;
    
    [self.view addSubview:dateImg];
    
    [dateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake((KscreenWidth - 1)/2.0, [JNSHAutoSize height:41]));
    }];
    
    
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dateTap)];
    dateTap.numberOfTapsRequired = 1;
    
    [dateImg addGestureRecognizer:dateTap];
    
    UILabel *dateLab = [[UILabel alloc] init];
    dateLab.font = [UIFont systemFontOfSize:15];
    dateLab.textColor = ColorText;
    dateLab.textAlignment = NSTextAlignmentRight;
    dateLab.text = @"日期";
    [dateImg addSubview:dateLab];
    
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(dateImg);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:40], [JNSHAutoSize height:15]));
    }];
    
    self.arrawImg = [[UIImageView alloc] init];
    _arrawImg.image = [UIImage imageNamed:@"order_arror_down"];
    
    [dateImg addSubview:_arrawImg];
    
    [_arrawImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateImg);
        make.left.equalTo(dateLab.mas_right).offset([JNSHAutoSize width:2]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:16], [JNSHAutoSize height:10]));
    }];
    
    //订单类型
    JNSYHighLightImageView *statusImg = [[JNSYHighLightImageView alloc] init];
    statusImg.backgroundColor = [UIColor whiteColor];
    statusImg.userInteractionEnabled = YES;
    
    [self.view addSubview:statusImg];
    
    [statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateImg.mas_right).offset([JNSHAutoSize width:1]);
        make.top.bottom.equalTo(dateImg);
        make.right.equalTo(self.view);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapType)];
    tap.numberOfTapsRequired = 1;
    
    [statusImg addGestureRecognizer:tap];
    
    _statusLab = [[UILabel alloc] init];
    _statusLab.font = [UIFont systemFontOfSize:15];
    _statusLab.textColor = ColorText;
    _statusLab.textAlignment = NSTextAlignmentCenter;
    _statusLab.text = @"全部";
    [statusImg addSubview:_statusLab];
    
    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(statusImg);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:12]));
    }];
    
    _rightArrow = [[UIImageView alloc] init];
    _rightArrow.image = [UIImage imageNamed:@"order_arror_down"];
    [statusImg addSubview:_rightArrow];
    
    [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(statusImg);
        make.left.equalTo(_statusLab.mas_right).offset([JNSHAutoSize width:2]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:16], [JNSHAutoSize height:10]));
    }];

    //
    showStatus = NO;
}

//获取订单数据
- (void)requestForOrderList:(NSString *)startime endtime:(NSString *)endTime product:(NSString *)pro page:(NSInteger)page{
    
    
    NSLog(@"#########当前页:%ld",page);
    
    NSDictionary *dic = @{
                          @"ts":startime,
                          @"te":endTime,
                          @"page":[NSString stringWithFormat:@"%ld",page],
                          @"product":pro
                          };
    NSString *action = @"PayOrderList";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSString *code = resultDic[@"code"];
        //NSLog(@"%@",resultDic);
        if ([code isEqualToString:@"000000"]) {
            
            if ([resultDic[@"records"] isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *dic = resultDic[@"records"];
                if (page > 0) {
                    
                    //NSLog(@"keysCount:%ld",dic.allKeys.count);
                    
                    if (dic.allKeys.count > 0) {
                    
                        NSString *lastTitle = self.orderList.lastObject;
                        NSString *firstTitle = dic.allKeys.firstObject;
                        if ([lastTitle isEqualToString:firstTitle]) { //上一页月份和下一页首月相同
                            
                            //去除第一个月份
                            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:dic.allKeys];
                            [array removeObjectAtIndex:0];
                            //添加到月份数组
                            [self.orderList arrayByAddingObjectsFromArray:array];
                            
                            //设置字典数据
                            NSArray *lastArray = self.orderDic[lastTitle];
                            NSArray *firstArray = dic[lastTitle];
                            NSMutableArray *finalArray = [[NSMutableArray alloc] initWithArray:lastArray];
                            [finalArray addObjectsFromArray:firstArray];
                            [self.orderDic setObject:finalArray forKey:lastTitle];
                            //NSLog(@"%@",self.orderDic);
                            
                        }else {
                            
                            [self.orderDic addEntriesFromDictionary:dic];
                            
                            [self.orderList arrayByAddingObjectsFromArray:dic.allKeys];
                        }
                        
                        
                    }else {
                        //如果没有数据 page减1
                        _currentPage --;
                        
                        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                        hud.mode = MBProgressHUDModeText;
                        hud.labelText = @"没有更多数据了";
                        [hud hide:YES afterDelay:1];
                    }
                    
                }else {
                    
                    self.orderDic = dic;
                    self.orderList = dic.allKeys;
                    
                }
                
                [table reloadData];
                
                [table.mj_header endRefreshing];
                [table.mj_footer endRefreshing];
                
            } else {  //没有数据
                //如果页数大于1 则减去1
                _currentPage --;
                
            }

        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//选择日期
- (void)dateTap {
    
    if (orderView.alpha > 0) {
        _rightArrow.image = [UIImage imageNamed:@"order_arror_down"];
        [orderView dismiss];
    }
    
    if (calendar.alpha > 0) {
        self.arrawImg.image = [UIImage imageNamed:@"order_arror_down"];
        [calendar dismiss];
    }else {
        
        calendar = [[JNSHCalendarView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, KscreenHeight)];
        calendar.userInteractionEnabled = YES;
        
        __weak typeof(self) weakSelf = self;
        
        //日历消失
        calendar.dismissblock = ^{
            __strong typeof(self) stongSelf = weakSelf;
            stongSelf.arrawImg.image = [UIImage imageNamed:@"order_arror_down"];
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
            [stongSelf requestForOrderList:stongSelf.startTime endtime:stongSelf.endtime product:stongSelf.currentType page:stongSelf.currentPage];
            
            NSLog(@"start:%@ end:%@",startime,Endtime);
        };
        
        self.arrawImg.image = [UIImage imageNamed:@"order_arror_up"];
        
        [calendar showInView:self.view];
        
    }
}

//选择收款类型
- (void)tapType {
    
    NSArray *array = @[@"全部",@"收款",@"会员购买",@"后台管理费"];
    
    if (calendar.alpha > 0) {
        self.arrawImg.image = [UIImage imageNamed:@"order_arror_down"];
        [calendar dismiss];
    }
    
    if (orderView.alpha > 0) {
        _rightArrow.image = [UIImage imageNamed:@"order_arror_down"];
        [orderView dismiss];
    } else {
        orderView = [[JNSHOrderStatusView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, KscreenHeight)];
        orderView.selectIndex = self.selectIndex;
        __weak typeof(self) weakSelf = self;
        
        orderView.selectblock = ^(NSIndexPath *index) {  //类型选择
            __strong typeof(self) strongSelf = weakSelf;
            
            strongSelf.selectIndex = index.row;
            strongSelf.statusLab.text = array[index.row];
            strongSelf.rightArrow.image = [UIImage imageNamed:@"order_arror_down"];
            //判断当前类型
            if (strongSelf.selectIndex == 0) {
                strongSelf.currentType = @"";
            }else if (strongSelf.selectIndex == 1) {
                strongSelf.currentType = @"1000";
            }else if (strongSelf.selectIndex == 2) {
                strongSelf.currentType = @"1001";
            }else if (strongSelf.selectIndex == 3) {
                strongSelf.currentType = @"1002";
            }
            //跟新当前页
            strongSelf.currentPage = 0;
            //获取新的订单
            [strongSelf requestForOrderList:strongSelf.startTime endtime:strongSelf.endtime product:strongSelf.currentType page:strongSelf.currentPage];
            
            
        };
        
        orderView.dismissBlock = ^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.rightArrow.image = [UIImage imageNamed:@"order_arror_down"];
        };
        
        self.rightArrow.image = [UIImage imageNamed:@"order_arror_up"];
        //orderView.selectIndex = 0;
        [orderView showinView:self.view];
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return self.orderList.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *orderMouthList = [[NSArray alloc] init];
    
    if (self.orderList.count > 0) {
        orderMouthList = [self.orderDic objectForKey:self.orderList[section]];
    }else {
        
    }

    return orderMouthList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHOrderCell alloc] init];
        if (self.orderList.count > 0) {
            NSArray *orderMouthList = [self.orderDic objectForKey:self.orderList[indexPath.section]];
            NSString *time = [orderMouthList[indexPath.row][@"orderPayTime"] substringFromIndex:5];
            NSString *money = orderMouthList[indexPath.row][@"orderPrice"];
            NSString *goodsName = [NSString stringWithFormat:@"%@",orderMouthList[indexPath.row][@"product"]];
            NSString *statusName = orderMouthList[indexPath.row][@"orderStatusName"];
            if ([goodsName isEqualToString:@"1000"]) {
                goodsName = @"商户收款";
            }else if ([goodsName isEqualToString:@"1001"]) {
                goodsName = @"会员购买";
            }else {
                goodsName = @"代理商升级";
            }
            [cell settype:goodsName time:time money:[NSString stringWithFormat:@"￥%@",money] status:statusName];
        }
        
    }
    
    return cell;
}

//
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    JNSHOrderCell *cell = [table cellForRowAtIndexPath:indexPath];
//    cell.selected = NO;
    
    JNSHOrderModel *model = [[JNSHOrderModel alloc] init];
    NSArray *orderMouthList = [self.orderDic objectForKey:self.orderList[indexPath.section]];
    model.orderPrice = [NSString stringWithFormat:@"%@",orderMouthList[indexPath.row][@"orderPrice"]];
    model.orderStatus = orderMouthList[indexPath.row][@"orderStatusName"];
    model.product = [NSString stringWithFormat:@"%@",orderMouthList[indexPath.row][@"product"]];
    model.cardBank = orderMouthList[indexPath.row][@"cardBank"];
    model.cardNo = orderMouthList[indexPath.row][@"cardNo"];
    model.orderNo = orderMouthList[indexPath.row][@"orderNo"];
    model.orderReqTime = orderMouthList[indexPath.row][@"orderReqTime"];
    JNSHOrderDetailController *OrderDetailView = [[JNSHOrderDetailController alloc] init];
    OrderDetailView.model = model;
    OrderDetailView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:OrderDetailView animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:41])];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = ColorText;
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.text = [NSString stringWithFormat:@"%@年%@月",[self.orderList[section] substringToIndex:4],[self.orderList[section] substringWithRange:NSMakeRange(5, 2)]];
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

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:5])];
//    view.backgroundColor = ColorTableBackColor;
//    
//    return view;
//    
//}

- ( CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [JNSHAutoSize height:46];
    
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    
//    return [JNSHAutoSize height:5];
//}


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
