//
//  JNSHSaleStatisticViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSaleStatisticViewController.h"
#import "UINavigationController+Cloudox.h"
#import "UIViewController+Cloudox.h"
#import "Masonry.h"
#import "JNSHSingleCalendarView.h"
#import "JNSHSaleStatisticCell.h"
@interface JNSHSaleStatisticViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIImageView *bottomLine;

@property(nonatomic,strong)UIButton *startBtn;

@property(nonatomic,strong)UIButton *EndBtn;

@end

@implementation JNSHSaleStatisticViewController {
    
//    UIButton *startBtn;
//    UIButton *EndBtn;
    NSInteger _currentTag;
    JNSHSingleCalendarView *SingleCader;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"销售统计";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = ColorTableBackColor;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //上部白色背景
    UIImageView *dateImageView = [[UIImageView alloc] init];
    dateImageView.backgroundColor = [UIColor whiteColor];
    dateImageView.userInteractionEnabled = YES;
    
    //黑线
    UIImageView *LineOne = [[UIImageView alloc] init];
    LineOne.backgroundColor = ColorLineSeperate;
    [dateImageView addSubview:LineOne];
    
    [LineOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateImageView);
        make.left.equalTo(dateImageView).offset([JNSHAutoSize width:15]);
        make.right.equalTo(dateImageView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *LineTwo = [[UIImageView alloc] init];
    LineTwo.backgroundColor =ColorLineSeperate;
    [dateImageView addSubview:LineTwo];
    
    [LineTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateImageView).offset([JNSHAutoSize width:0]);
        make.right.bottom.equalTo(dateImageView);
        make.height.mas_equalTo(SeperateLineWidth);
    }];
    
    //日期
    UILabel *dateLab = [[UILabel alloc] init];
    dateLab.font = [UIFont systemFontOfSize:15];
    dateLab.text = @"日期";
    dateLab.textAlignment = NSTextAlignmentLeft;
    dateLab.textColor = ColorText;
    [dateImageView addSubview:dateLab];
    [dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateImageView).offset([JNSHAutoSize width:15]);
        make.top.equalTo(dateImageView).offset([JNSHAutoSize height:14]);
        make.bottom.equalTo(LineOne).offset(-[JNSHAutoSize height:13]);
        make.width.mas_equalTo([JNSHAutoSize width:40]);
    }];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    
    NSString *time = [formatter stringFromDate:[NSDate date]];
    
    self.startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startBtn.backgroundColor = [UIColor whiteColor];
    [self.startBtn setTitle:time forState:UIControlStateNormal];
    [self.startBtn setTitleColor:ColorText forState:UIControlStateNormal];
    [self.startBtn setTitleColor:ColorTabBarBackColor forState:UIControlStateSelected];
    self.startBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.startBtn addTarget:self action:@selector(dateSelect:) forControlEvents:UIControlEventTouchUpInside];
    self.startBtn.tag = 100;
    _currentTag = 100;
    self.startBtn.selected = NO;
    [dateImageView addSubview:self.startBtn];
    
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateLab);
        make.left.equalTo(dateLab.mas_right).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:15]));
    }];
    
    UILabel *midLab = [[UILabel alloc] init];
    midLab.text = @"至";
    midLab.textAlignment = NSTextAlignmentCenter;
    midLab.font = [UIFont systemFontOfSize:15];
    midLab.textColor = ColorLightText;
    [dateImageView addSubview:midLab];
    
    [midLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateLab);
        make.left.equalTo(self.startBtn.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:20]));
    }];
    
    self.EndBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.EndBtn.backgroundColor = [UIColor whiteColor];
    [self.EndBtn setTitle:time forState:UIControlStateNormal];
    [self.EndBtn setTitleColor:ColorText forState:UIControlStateNormal];
    [self.EndBtn setTitleColor:ColorTabBarBackColor forState:UIControlStateSelected];
    self.EndBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.EndBtn addTarget:self action:@selector(dateSelect:) forControlEvents:UIControlEventTouchUpInside];
    self.EndBtn.tag = 101;
    self.EndBtn.selected = NO;
    [dateImageView addSubview:self.EndBtn];
    
    [self.EndBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateLab);
        make.left.equalTo(midLab.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:15]));
    }];
    //日期选择底部滑动横线
    self.bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake([JNSHAutoSize width:80], [JNSHAutoSize height:(33 + 3)], [JNSHAutoSize width:77], [JNSHAutoSize height:3])];
    self.bottomLine.backgroundColor = ColorTabBarBackColor;
    
    [dateImageView addSubview:self.bottomLine];
    
    //搜索
    
    UITextField *SearchFld = [[UITextField alloc] init];
    SearchFld.placeholder = @"输入代理商名称";
    SearchFld.font = [UIFont systemFontOfSize:14];
    SearchFld.textAlignment = NSTextAlignmentLeft;
    [dateImageView addSubview:SearchFld];
    
    [SearchFld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(LineOne).offset([JNSHAutoSize height:14]);
        make.bottom.equalTo(LineTwo).offset(-[JNSHAutoSize height:14]);
        make.left.equalTo(dateImageView).offset([JNSHAutoSize width:15]);
        make.right.equalTo(dateImageView).offset(-[JNSHAutoSize width:70]);
    }];
    
    UIButton *SearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    SearchBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [SearchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [SearchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    SearchBtn.backgroundColor = BlueColor;
    SearchBtn.layer.cornerRadius = 3;
    SearchBtn.layer.masksToBounds = YES;
    [SearchBtn addTarget:self action:@selector(Search) forControlEvents:UIControlEventTouchUpInside];
    
    [dateImageView addSubview:SearchBtn];
    
    [SearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(SearchFld);
        make.right.equalTo(dateImageView).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:51], [JNSHAutoSize height:21]));
    }];
    
    
    //添加白色背景
    [self.view addSubview:dateImageView];
    
    [dateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset([JNSHAutoSize height:15]);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:82]);
    }];
    
    //tableview
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:97], KscreenWidth, KscreenHeight - [JNSHAutoSize height:97+64]) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.sectionHeaderHeight = [JNSHAutoSize height:41];
    table.sectionFooterHeight = [JNSHAutoSize height:5];
    [self.view addSubview:table];
    
}


- (void)dateSelect:(UIButton *)btn {
    
    if (!btn.isSelected) {  //没有选择
        
        if(btn.tag == 100) {  //选择起始时间
            self.EndBtn.selected = NO;
            _currentTag = 100;
        
            [self showCandle];
            
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect frame = self.bottomLine.frame;
                
                CGFloat maxX = CGRectGetMinX(self.startBtn.frame);
                
                frame.origin.x = maxX + [JNSHAutoSize width:14];
                
                self.bottomLine.frame = frame;
                
            }];
            
        }else if (btn.tag == 101) {
            self.startBtn.selected = NO;
            _currentTag = 101;
            [self showCandle];
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect frame = self.bottomLine.frame;
                
                CGFloat maxX = CGRectGetMinX(self.EndBtn.frame);
                
                frame.origin.x = maxX + [JNSHAutoSize width:14];
                
                self.bottomLine.frame = frame;
                
            }];
        }
        
        btn.selected = ! btn.selected;
        
    }else {                 //已经选择
        
        if (SingleCader.alpha > 0) {
            
        }else {
            [self showCandle];
        }

    }
}

- (void)showCandle {
    
    if (SingleCader.alpha > 0) {
        [SingleCader dismiss];
    }
    SingleCader = [[JNSHSingleCalendarView alloc] initWithFrame:CGRectMake(0, 52, KscreenWidth, 300)];
    
    __weak typeof(self) weakSelf = self;
    
    SingleCader.dateSelectBlock = ^(NSString *date) {
        __strong typeof(self) strongSelf = weakSelf;
        if (_currentTag == 100) {
            [strongSelf.startBtn setTitle:date forState:UIControlStateNormal];
        }else {
            [strongSelf.EndBtn setTitle:date forState:UIControlStateNormal];
        }
    };
    
    [SingleCader showInView:self.view];
    
}

//搜索
- (void)Search {
    
    NSLog(@"搜索");
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHSaleStatisticCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    if (cell == nil) {
        cell = [[JNSHSaleStatisticCell alloc] init];
        cell.FenRunNumLab.text = @"11110.10";
        cell.SaleAmountNumLab.text = @"共20笔     15451.00";
        cell.TotalFenRunNumLab.text = @"1888888.00";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:41])];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.textColor = ColorText;
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.text = @"名下全部代理商";
    [view addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:41]));
    }];
    
//    UIImageView *BottomLine = [[UIImageView alloc] init];
//    BottomLine.backgroundColor = ColorLineSeperate;
//    [view addSubview:BottomLine];
//
//    [BottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(view);
//        make.height.mas_equalTo([JNSHAutoSize height:SeperateLineWidth]);
//    }];
    
    return view;
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
