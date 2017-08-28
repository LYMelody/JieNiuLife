//
//  JNSHPayResultViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/23.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHPayResultViewController.h"
#import "JNSHCommonButton.h"
#import "Masonry.h"
#import "JNSHTitleCell.h"
@interface JNSHPayResultViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHPayResultViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"支付结果";
    
    self.view.backgroundColor = ColorTabBarBackColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];

    //headerView
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:[JNSHAutoSize height:151]])];
    headerView.backgroundColor = ColorTableBackColor;
    
    UIImageView *logoImg = [[UIImageView alloc] init];
    logoImg.image = [UIImage imageNamed:@"pay-success"];
    
    [headerView addSubview:logoImg];
    
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(headerView).offset([JNSHAutoSize height:30]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:53], [JNSHAutoSize height:53]));
    }];
    
    UILabel *messageLab = [[UILabel alloc] init];
    messageLab.font = [UIFont systemFontOfSize:14];
    messageLab.textColor = ColorText;
    messageLab.textAlignment = NSTextAlignmentCenter;
    messageLab.text = @"交易成功!";
    [headerView addSubview:messageLab];
    
    [messageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.equalTo(logoImg.mas_bottom).offset([JNSHAutoSize height:13]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth, [JNSHAutoSize height:20]));
    }];
    
    table.tableHeaderView = headerView;
    
    //tablefootView
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:100])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    JNSHCommonButton *CommitBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:40], (KscreenWidth - [JNSHAutoSize width:30]), [JNSHAutoSize height:41])];
    [CommitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [CommitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [footView addSubview:CommitBtn];
    
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

//确定
- (void)commit{
    
    NSLog(@"确定");
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHTitleCell alloc] init];
        if (indexPath.row == 0) {
            cell.leftLab.text = @"交易金额";
            cell.rightLab.text = @"￥10000.00";
            cell.rightLab.textColor = [UIColor redColor];
        }else if (indexPath.row == 1) {
            cell.leftLab.text = @"交易名称";
            cell.rightLab.text = @"收款";
        }else if (indexPath.row == 2) {
            cell.leftLab.text = @"交易银行";
            cell.rightLab.text = @"中信银行";
        }else if (indexPath.row == 3) {
            cell.leftLab.text = @"交易账户";
            cell.rightLab.text = @"4033475112451245";
        }else if (indexPath.row == 4) {
            cell.leftLab.text = @"订单编号";
            cell.rightLab.text = @"10120270707121210001";
        }else if (indexPath.row == 5) {
            cell.leftLab.text = @"交易时间";
            cell.rightLab.text = @"2017-05-20 12:20:12";
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
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
