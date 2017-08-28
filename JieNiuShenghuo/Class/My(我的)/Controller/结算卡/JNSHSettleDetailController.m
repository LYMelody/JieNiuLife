//
//  JNSHSettleDetailController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSettleDetailController.h"
#import "JNSHLabFldCell.h"
#import "JNSHCommonButton.h"
#import "JNSHSettlementCardController.h"
#import "JNSHDetailCardImgCell.h"
@interface JNSHSettleDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHSettleDetailController {
    
    
    UITableView *table;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"结算卡详情";
    
    self.view.backgroundColor = ColorTableBackColor;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    backImg.backgroundColor = ColorTabBarBackColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];

    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    //底部视图
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:80])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    JNSHCommonButton *bindBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:20], [JNSHAutoSize height:40],(KscreenWidth - [JNSHAutoSize width:15]*2) , [JNSHAutoSize height:41])];
    [bindBtn setTitle:@"更换" forState:UIControlStateNormal];
    [bindBtn addTarget:self action:@selector(changeCard) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:bindBtn];
    
    table.tableFooterView = footView;
    
    //禁止滑动延迟
    table.delaysContentTouches = NO;
    for(id view in table.subviews) {
        
        if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewWrapperView"]) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrrowView = (UIScrollView *)view;
                scrrowView.delaysContentTouches = NO;
            }
            break;
        }
    }
    
}

- (void)changeCard {
    
    NSLog(@"更换");
    
    JNSHSettlementCardController *subVc = [[JNSHSettlementCardController alloc] init];
    subVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:subVc animated:YES];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            cell.backgroundColor = ColorTableBackColor;
        }
        if (indexPath.row == 1) {
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"持 卡 人";
            Cell.textFiled.placeholder = @"请输入持卡人姓名";
            Cell.textFiled.text = @"张三";
            Cell.textFiled.enabled = NO;
            cell = Cell;
        }else if (indexPath.row == 2) {
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"卡      号";
            Cell.textFiled.placeholder = @"请输入卡号";
            Cell.textFiled.text = @"1232 **** **** **** 4566";
            Cell.textFiled.enabled = NO;
            cell = Cell;
        }else if (indexPath.row == 3) {
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"选择银行";
            Cell.textFiled.enabled = NO;
            Cell.textFiled.text = @"中国银行";
            cell = Cell;
           
        }else if (indexPath.row == 4) {
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"选择支行";
            Cell.textFiled.enabled = NO;
            Cell.textFiled.text = @"城北支行";
            cell = Cell;
        }else if(indexPath.row == 5) {
            cell.backgroundColor = ColorTableBackColor;
        }else if (indexPath.row == 6) {
            
            JNSHDetailCardImgCell *Cell = [[JNSHDetailCardImgCell alloc] init];
            
            cell = Cell;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 || indexPath.row == 5) {
        return [JNSHAutoSize height:10];
    }else if (indexPath.row == 6) {
        return [JNSHAutoSize height:247];
    }
    
    return 41;
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
