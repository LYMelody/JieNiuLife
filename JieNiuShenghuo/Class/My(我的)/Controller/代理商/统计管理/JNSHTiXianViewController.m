//
//  JNSHTiXianViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/12/13.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHTiXianViewController.h"
#import "UIViewController+Cloudox.h"
#import "Masonry.h"
#import "JNSHDalyFenRunCell.h"
#import "JNSHTiXianAlertView.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSHPreTiXianModel.h"
#import "MBProgressHUD.h"


@interface JNSHTiXianViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endtime;

@property(nonatomic,strong)NSArray *orderList;

@property(nonatomic,copy)NSString *avaiableCash;  //可提现金额

@property(nonatomic,strong)UITextField *TextFld;

@property(nonatomic,strong)MBProgressHUD *HUD;

@property(nonatomic,strong)JNSHTiXianAlertView *TiXianAlertView;

@end

@implementation JNSHTiXianViewController {
    
    UITableView *table;
    UILabel *TipsLab;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"分润提现";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = ColorTableBackColor;
 
    //获取可提现金额
    [self requestSettleAmount];
    
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
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.backgroundColor = [UIColor whiteColor];
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:101]);
    }];
    
    UILabel *leftLab = [[UILabel alloc] init];
    leftLab.text = @"￥";
    leftLab.font = [UIFont systemFontOfSize:18];
    leftLab.textColor = ColorText;
    leftLab.textAlignment = NSTextAlignmentLeft;
    [backImg addSubview:leftLab];
    
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImg).offset([JNSHAutoSize height:39]);
        make.left.equalTo(backImg).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:13]));
    }];
    
    //提现按钮
    UIButton *TiXianBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [TiXianBtn setTitle:@"提现" forState:UIControlStateNormal];
    TiXianBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [TiXianBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [TiXianBtn setBackgroundColor:BlueColor];
    TiXianBtn.layer.cornerRadius = 2;
    [TiXianBtn addTarget:self action:@selector(TiXian) forControlEvents:UIControlEventTouchUpInside];
    [backImg addSubview:TiXianBtn];
    
    [TiXianBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(leftLab);
        make.right.equalTo(backImg).offset(-[JNSHAutoSize width:17]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:71], [JNSHAutoSize height:26]));
    }];
    
    //金额输入框
    self.TextFld = [[UITextField alloc] init];
    self.TextFld.placeholder = @"可提现金额￥0.0";
    self.TextFld.font = [UIFont systemFontOfSize:14];
    self.TextFld.textAlignment = NSTextAlignmentLeft;
    self.TextFld.textColor = ColorText;
    self.TextFld.keyboardType = UIKeyboardTypeNumberPad;
    
    [backImg addSubview:self.TextFld];
    
    [self.TextFld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImg).offset([JNSHAutoSize height:38]);
        make.left.equalTo(leftLab.mas_right).offset([JNSHAutoSize width:10]);
        make.right.equalTo(TiXianBtn.mas_left).offset(-[JNSHAutoSize width:60]);
    }];
    
    //温馨提示
    UILabel *tipsLab = [[UILabel alloc] init];
    tipsLab.font = [UIFont systemFontOfSize:12];
    tipsLab.textColor = ColorText;
    tipsLab.textAlignment = NSTextAlignmentLeft;
    tipsLab.text = @"温馨提示：提现时间为工作日10:00-17:00。";
    [backImg addSubview:tipsLab];
    
    [tipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backImg).offset(-[JNSHAutoSize height:5]);
        make.left.equalTo(backImg).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth - 20, [JNSHAutoSize height:15]));
    }];
    
    //分割线
    UIImageView *bottomLine = [[UIImageView alloc] init];
    bottomLine.backgroundColor = ColorLineSeperate;
    [backImg addSubview:bottomLine];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tipsLab.mas_top).offset(-[JNSHAutoSize height:5]);
        make.left.equalTo(backImg).offset([JNSHAutoSize width:15]);
        make.right.equalTo(backImg).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:SeperateLineWidth]);
    }];
    
    TipsLab = [[UILabel alloc] init];
    TipsLab.textColor = ColorText;
    TipsLab.font = [UIFont systemFontOfSize:14];
    TipsLab.text = @"没有提现记录!";
    TipsLab.textAlignment = NSTextAlignmentCenter;
    TipsLab.hidden = YES;
    TipsLab.backgroundColor = ColorTableBackColor;
    TipsLab.hidden = YES;
    [self.view addSubview:TipsLab];
    
    [TipsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(backImg.mas_bottom).offset([JNSHAutoSize height:40]);
        make.height.mas_equalTo([JNSHAutoSize height:30]);
    }];
    
    //初始化数组
    self.orderList = [[NSArray alloc] init];
    
    //table
    table = [[UITableView alloc] init];
    table.delegate = self;
    table.dataSource = self;
    //table.separatorStyle = ui
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.backgroundColor = ColorTableBackColor;
    [self.view addSubview:table];
    
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backImg.mas_bottom).offset([JNSHAutoSize height:5]);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    //获取今天的订单
    _startTime = [NSString stringWithFormat:@"%@ %@",[self getToday],@"00:00:00"];
    _endtime = [NSString stringWithFormat:@"%@ %@",[self getToday],@"23:59:59"];
    
    [self requestForSettleRecord:_startTime endtime:_endtime page:0];
    
    self.avaiableCash = @"";
    
    [self addObserver:self forKeyPath:@"avaiableCash" options:NSKeyValueObservingOptionNew context:nil];
    
}

//kvo回调
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    id oldName = [change objectForKey:NSKeyValueChangeOldKey];
    id newName = [change objectForKey:NSKeyValueChangeNewKey];
    
    self.TextFld.placeholder = [NSString stringWithFormat:@"可提现金额￥%@",newName];
    
    NSLog(@"oldName:%@,newName:%@",oldName,newName);

}

//提现
- (void)TiXian {
    
    NSLog(@"提现");
    
    if ([self.TextFld.text isEqualToString:@""]) {
        [JNSHAutoSize showMsg:@"请输入金额"];
        return;
    }else if ([self.TextFld.text integerValue] < 5) {
        [JNSHAutoSize showMsg:@"最低金额大于等于5元"];
    }else if ([self.TextFld.text integerValue] > [self.avaiableCash integerValue]) {
        [JNSHAutoSize showMsg:@"不能超过可提现金额"];
    }
    else {
        //隐藏键盘
        [self.TextFld resignFirstResponder];
        //请求数据
        [self preSettleDisplayInfo:self.TextFld.text settleType:@"0"];
        
    }
}

//获取代理商余额提现列表
- (void)requestForSettleRecord:(NSString *)startTime endtime:(NSString *)endTime page:(NSInteger)page {
    
    NSDictionary *dic = @{
                          @"ts":startTime,
                          @"te":endTime,
                          @"page":[NSString stringWithFormat:@"%ld",page],
                          @"limit":[NSString stringWithFormat:@"%d",10]
                          };
    NSString *action = @"OrgBalanceSettleRecord";
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultdic = [result JSONValue];
        
        NSLog(@"%@",resultdic);
        
        if ([resultdic[@"records"] isKindOfClass:[NSArray class]]) {
            NSArray *array = resultdic[@"records"];
            if (array.count > 0) {  //有数据显示table
                
                self.orderList = array;
                
                table.hidden = NO;
                TipsLab.hidden = YES;
                [table reloadData];
                
            }else {                 //没有数据隐藏label，展示提示
                table.hidden = YES;
                TipsLab.hidden = NO;
            }
        }else {
            table.hidden = YES;
            TipsLab.hidden = NO;
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//获取代理商余额信息
- (void)requestSettleAmount {
    
    NSDictionary *dic =@{
                         @"timestamp":[JNSHAutoSize getTimeNow]
                         };
    NSString *action = @"OrgBalance";
    NSDictionary *requestdic =  @{
                        @"action":action,
                        @"token":[JNSYUserInfo getUserInfo].userToken,
                        @"data":dic
                        };
    NSString *params = [requestdic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSLog(@"%@",resultDic);
        NSString *code = resultDic[@"code"];
        if ([code isEqualToString:@"000000"]) {
            self.avaiableCash = [NSString stringWithFormat:@"%.2f",[resultDic[@"residuePrice"] integerValue]/100.0];
        }else {
            NSString *msg = resultDic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//预提现、提现
- (void)preSettleDisplayInfo:(NSString *)amount settleType:(NSString *)settleType {
    
    NSDictionary *dic = @{
                          @"amount":[NSString stringWithFormat:@"%ld",[amount integerValue]*100],
                          @"preview":settleType
                          };
    NSString *action = @"OrgBalanceSettle";
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSLog(@"%@",resultDic);
        NSString *code = resultDic[@"code"];
        if ([code isEqualToString:@"000000"]) {
            if ([settleType isEqualToString:@"0"]) {
                JNSHPreTiXianModel *model = [[JNSHPreTiXianModel alloc] init];
                model.totalAmount = [resultDic[@"amount"] floatValue]/100.0;
                model.rateTax = [resultDic[@"rateTax"] floatValue]/100.0;
                model.ratefree = [resultDic[@"rateFree"] floatValue]/100.0;
                model.settleReal = [resultDic[@"settleReal"] floatValue]/100.0;
                
                self.TiXianAlertView = [[JNSHTiXianAlertView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
                __weak typeof(self) weakSelf = self;
                self.TiXianAlertView.sureTiXianBlock = ^{
                    __strong typeof(self) strongSelf = weakSelf;
                    strongSelf.HUD = [MBProgressHUD showHUDAddedTo:strongSelf.view animated:YES];
                    [strongSelf preSettleDisplayInfo:strongSelf.TextFld.text settleType:@"1"];
                };
                
                self.TiXianAlertView.model = model;
                
                [self.TiXianAlertView showInView:self.view];
                
            }else {
                
                //隐藏提现视图
                if (self.TiXianAlertView) {
                    [self.TiXianAlertView dismiss];
                }
                //提示提现状态
                self.HUD.mode = MBProgressHUDModeText;
                self.HUD.labelText = @"提现成功!";
                [self.HUD hide:YES afterDelay:1.5];
                //更新可提现金额
                [self requestSettleAmount];
                //更新提现记录
                 [self requestForSettleRecord:_startTime endtime:_endtime page:0];
                
            }
        }else {
            NSString *msg = resultDic[@"msg"];
            [JNSHAutoSize showMsg:msg];
            if (self.HUD) {
                [self.HUD hide:YES];
            }
        }
        
    } failure:^(NSError *error) {
        
        if (self.HUD) {
            [self.HUD hide:YES];
        }
        
        [JNSHAutoSize showMsg:NetInAvaiable];
        
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.orderList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    JNSHDalyFenRunCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        
        cell = [[JNSHDalyFenRunCell alloc] init];
        cell.timeLab.text = @"提现时间";
        cell.statusLab.text = @"出款状态";
        cell.moneyLab.text = @"提现金额";
        cell.fenRunTimeLab.text = self.orderList[indexPath.row][@"orderPayTime"];
        NSString *status = [NSString stringWithFormat:@"%@",self.orderList[indexPath.row][@"orderStatus"]];
        if ([status isEqualToString:@"20"]) {
            cell.cashStatusLab.text = @"处理成功";
            cell.cashStatusLab.textColor = GreenColor;
        }else if ([status isEqualToString:@"21"]) {
            cell.cashStatusLab.text = @"处理失败";
            cell.cashStatusLab.textColor = [UIColor redColor];
        }else {
            cell.cashStatusLab.text = @"处理中";
            cell.cashStatusLab.textColor = [UIColor orangeColor];
        }
        cell.amountLab.text = [NSString stringWithFormat:@"￥%.2f",[self.orderList[indexPath.row][@"orderPrice"] floatValue]/100.0];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 71;
    
}

//重写dealloc方法
- (void)dealloc {

    [self removeObserver:self forKeyPath:@"avaiableCash"];
    NSLog(@"dealloc");
    
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
