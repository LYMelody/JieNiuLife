//
//  JNSHFenRunDetailSearchViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHFenRunDetailSearchViewController.h"
#import "Masonry.h"
#import "JNSHFenRunDetailCell.h"
#import "UIViewController+Cloudox.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"

@interface JNSHFenRunDetailSearchViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *orderList;

@end

@implementation JNSHFenRunDetailSearchViewController {
    
    UITableView *table;
    UILabel *FenRunLab;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"分润明细搜索";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = ColorTableBackColor;
    
    [self requestForOrderList:self.startTime endTime:self.endTime page:0];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *headerImg = [[UIImageView alloc] init];
    headerImg.backgroundColor = [UIColor whiteColor];
    headerImg.userInteractionEnabled = YES;
    [self.view addSubview:headerImg];
    
    [headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:51]);
    }];
    
    FenRunLab = [[UILabel alloc] init];
    FenRunLab.text = @"当前共888笔交易，合计分润￥8888.00";
    FenRunLab.textColor = ColorText;
    FenRunLab.textAlignment = NSTextAlignmentLeft;
    FenRunLab.font = [UIFont systemFontOfSize:14];
    [headerImg addSubview:FenRunLab];
    
    [FenRunLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerImg);
        make.left.equalTo(headerImg).offset([JNSHAutoSize width:15]);
        make.right.equalTo(headerImg);
        make.height.mas_equalTo([JNSHAutoSize height:20]);
    }];
    
    self.orderList = [[NSArray alloc] init];
    
    //tableview
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:51], KscreenWidth, KscreenHeight - [JNSHAutoSize height:51+64]) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:table];
    
}

- (void)requestForOrderList:(NSString *)startTime endTime:(NSString *)endTime page:(NSInteger)page {
    
    NSDictionary *dic = @{
                          @"ts":startTime,
                          @"te":endTime,
                          @"page":[NSString stringWithFormat:@"%ld",page],
                          @"limit":[NSString stringWithFormat:@"%d",10]
                          };
    
    NSString *action = @"OrgProfitRecord";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        
        NSString *code = resultDic[@"code"];
        if ([code isEqualToString:@"000000"]) {
            if ([resultDic[@"records"] isKindOfClass:[NSArray class]]) {
                self.orderList = resultDic[@"records"];
                
                NSString *allcount = resultDic[@"allCount"];
                NSString *allPrice = resultDic[@"allPrice"];
            
                FenRunLab.text = [NSString stringWithFormat:@"当前共交易%@笔，合计分润￥%.2f",allcount,[allPrice intValue]/100.0];
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
    
    JNSHFenRunDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[JNSHFenRunDetailCell alloc] init];
        cell.orderNumLab.text = [NSString stringWithFormat:@"￥%.2f",[self.orderList[indexPath.row][@"profitPrice"] intValue]/100.0];
        cell.fenRunCashLab.text = [NSString stringWithFormat:@"￥%.2f",[self.orderList[indexPath.row][@"amountPrice"] intValue]/100.0];
        cell.saleTimeLab.text = [NSString stringWithFormat:@"%@",self.orderList[indexPath.row][@"orderTime"]];
        NSString *payType = [NSString stringWithFormat:@"%@",self.orderList[indexPath.row][@"payType"]];
        if ([payType isEqualToString:@"1"]) {
            cell.orderTypeLab.text = @"无卡快捷";
        }else if ([payType isEqualToString:@"11"]) {
            cell.orderTypeLab.text = @"银联H5";
        }else if ([payType isEqualToString:@"7"]) {
            cell.orderTypeLab.text = @"银联扫码";
        }else {
            cell.orderTypeLab.text = @"蓝牙卡头";
        }
        cell.orderNoLab.text = [NSString stringWithFormat:@"%@",self.orderList[indexPath.row][@"orderNo"]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
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
