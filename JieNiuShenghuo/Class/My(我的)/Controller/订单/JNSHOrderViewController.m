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

@interface JNSHOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,strong)UILabel *statusLab;

@property(nonatomic,strong)UIImageView *rightArrow;

@property(nonatomic,strong)UIImageView *arrawImg;


@end

@implementation JNSHOrderViewController {
    
    UITableView *table;
    BOOL showStatus;
    JNSHOrderStatusView *orderView;
    JNSYHighLightImageView *dateImg;
    JNSHCalendarView *calendar;
    //UIImageView *rightArrow;
    NSString *startTime;
    NSString *endtime;
    
}

//获取当时日期
- (NSString*)getToday
{
    NSDate *today = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [df stringFromDate:today];
    NSString *dateStr = [dateString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    return dateStr;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.title = @"订单中心";
    self.view.backgroundColor = ColorTableBackColor;
    self.navBarBgAlpha = @"1.0";
    startTime = [NSString stringWithFormat:@"%@%@",[self getToday],@"000000"];
    endtime = [NSString stringWithFormat:@"%@%@",[self getToday],@"235959"];
    //获取今天的订单
    [self requestForOrderList:startTime endtime:endtime product:@"1000"];
    
    
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
    
    [self.view addSubview:table];
    
}

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

- (void)requestForOrderList:(NSString *)startTime endtime:(NSString *)endtime product:(NSString *)pro{
    
    NSDictionary *dic = @{
                          @"ts":startTime,
                          @"te":endtime,
                          @"page":@"0",
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
        NSLog(@"%@",resultDic);
        if ([code isEqualToString:@"000000"]) {
            [table reloadData];
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
        calendar.datechoseblock = ^{
            //__strong typeof(self) strongSelf = weakSelf;
           
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
        
        orderView.selectblock = ^(NSIndexPath *index) {
            __strong typeof(self) strongSelf = weakSelf;
            
            strongSelf.selectIndex = index.row;
            strongSelf.statusLab.text = array[index.row];
            strongSelf.rightArrow.image = [UIImage imageNamed:@"order_arror_down"];
            
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

- (void)layoutLab {
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 5;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHOrderCell alloc] init];
        [cell settype:@"会员购买" time:@"07-20  15:20:20" money:@"￥45" status:@"支付成功"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JNSHOrderDetailController *OrderDetailView = [[JNSHOrderDetailController alloc] init];
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
    titleLab.text = @"2017年8月";
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:5])];
    view.backgroundColor = ColorTableBackColor;
    
    return view;
    
}

- ( CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [JNSHAutoSize height:46];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return [JNSHAutoSize height:5];
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
