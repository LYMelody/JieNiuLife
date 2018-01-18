//
//  JNSHAgentInfoViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/11/27.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAgentInfoViewController.h"
#import "UIViewController+Cloudox.h"
#import "Masonry.h"
#import "JNSHTitleCell.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"

@interface JNSHAgentInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray *orderList;

@end

@implementation JNSHAgentInfoViewController {
    
    UIButton *btnOne;
    UIButton *btnTwo;
    UIButton *btnThree;
    NSInteger count;
    NSString *type;
    UITableView *table;
    UILabel *numLab;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"代理信息";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = ColorTableBackColor;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *headBackImg = [[UIImageView alloc] init];
    headBackImg.backgroundColor = [UIColor whiteColor];
    headBackImg.userInteractionEnabled = YES;
    
    [self.view addSubview:headBackImg];
    
    [headBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset([JNSHAutoSize height:5]);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo([JNSHAutoSize height:64]);
    }];
    
    UILabel *searchLab = [[UILabel alloc] init];
    searchLab.text = @"查询条件";
    searchLab.textColor = ColorText;
    searchLab.font = [UIFont systemFontOfSize:15];
    searchLab.textAlignment = NSTextAlignmentLeft;
    [headBackImg addSubview:searchLab];
    
    [searchLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headBackImg).offset([JNSHAutoSize height:10]);
        make.left.equalTo(self.view).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:62], [JNSHAutoSize height:15]));
    }];
    
//
//    btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btnOne setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
//    [btnOne setImage:[UIImage imageNamed:@"---checkmark"] forState:UIControlStateSelected];
//    [btnOne addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
//    btnOne.tag = 100;
//    btnOne.selected = YES;
//    [headBackImg addSubview:btnOne];
//
//    [btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(searchLab);
//        make.left.equalTo(searchLab.mas_right).offset([JNSHAutoSize width:15]);
//        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:15], [JNSHAutoSize width:15]));
//    }];
//
//    UILabel *LabOne = [[UILabel alloc] init];
//    LabOne.text = @"办事处";
//    LabOne.textColor = ColorLightText;
//    LabOne.font = [UIFont systemFontOfSize:13];
//    LabOne.textAlignment = NSTextAlignmentLeft;
//    [headBackImg addSubview:LabOne];
//    [LabOne mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(btnOne);
//        make.left.equalTo(btnOne.mas_right).offset([JNSHAutoSize width:10]);
//        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:40], [JNSHAutoSize height:15]));
//    }];
//
    
    btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnTwo setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [btnTwo setImage:[UIImage imageNamed:@"---checkmark"] forState:UIControlStateSelected];
    [btnTwo addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    btnTwo.tag = 101;
    btnTwo.selected = YES;
    [headBackImg addSubview:btnTwo];

    [btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchLab);
        make.left.equalTo(searchLab.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:15], [JNSHAutoSize width:15]));
    }];
    
    UILabel *labTwo = [[UILabel alloc] init];
    labTwo.text = @"一级代理商";
    labTwo.textColor = ColorLightText;
    labTwo.font = [UIFont systemFontOfSize:13];
    labTwo.textAlignment = NSTextAlignmentLeft;
    labTwo.userInteractionEnabled = YES;
    labTwo.tag = 201;
    [headBackImg addSubview:labTwo];
    
    UITapGestureRecognizer *TapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureSelect:)];
    TapOne.numberOfTouchesRequired = 1;
    TapOne.numberOfTapsRequired = 1;
    [labTwo addGestureRecognizer:TapOne];
    
    [labTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchLab);
        make.left.equalTo(btnTwo.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize height:15]));
    }];
    
    btnThree = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnThree setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [btnThree setImage:[UIImage imageNamed:@"---checkmark"] forState:UIControlStateSelected];
    [btnThree addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    btnThree.tag = 102;
    [headBackImg addSubview:btnThree];
    
    [btnThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchLab);
        make.left.equalTo(labTwo.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:15], [JNSHAutoSize width:15]));
    }];
    
    UILabel *labThree = [[UILabel alloc] init];
    labThree.text = @"特约代理商";
    labThree.textColor = ColorLightText;
    labThree.font = [UIFont systemFontOfSize:13];
    labThree.textAlignment = NSTextAlignmentLeft;
    labThree.userInteractionEnabled = YES;
    labThree.tag = 202;
    [headBackImg addSubview:labThree];
    
    UITapGestureRecognizer *TapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(GestureSelect:)];
    TapTwo.numberOfTouchesRequired = 1;
    [labThree addGestureRecognizer:TapTwo];
    
    [labThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnThree);
        make.left.equalTo(btnThree.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
    numLab = [[UILabel alloc] init];
    numLab.font = [UIFont systemFontOfSize:13];
    numLab.textAlignment = NSTextAlignmentLeft;
    numLab.textColor = ColorText;
    numLab.text = @"当前共有18个一级代理商";
    [headBackImg addSubview:numLab];
    
    [numLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headBackImg).offset(-[JNSHAutoSize height:10]);
        make.left.equalTo(headBackImg).offset([JNSHAutoSize width:15]);
        make.right.equalTo(headBackImg);
        make.height.mas_equalTo([JNSHAutoSize height:15]);
    }];
    
    count = 2;
    
    //table
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:68], KscreenWidth, self.view.bounds.size.height - [JNSHAutoSize height:(128+50)]) style:UITableViewStylePlain];
    
    table.dataSource = self;
    table.delegate = self;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.backgroundColor = ColorTableBackColor;
    [self.view addSubview:table];
    
    //[table reloadData];
    type = @"L31";
    //请求数据
    [self requestForInfo:@"L31" page:0];
    
}

//点击文字方法
- (void)GestureSelect:(UITapGestureRecognizer *) sender{
    
    NSLog(@"%ld",sender.view.tag);
    
    NSInteger tag = sender.view.tag;
    
    if(tag == 201) {  //以及代理
        
        btnTwo.selected = YES;
        btnThree.selected = NO;
        type = @"L31";
    }else {
        btnTwo.selected = NO;
        btnThree.selected = YES;
        type = @"L32";
    }
    
     [self requestForInfo:type page:0];
    
}

//按钮点击
- (void)select:(UIButton *)sender {
    
    if (sender.selected) {
        
        
    }else {
        
        //其他按钮去掉选择
        if (sender.tag == 100) {
            btnTwo.selected = NO;
            btnThree.selected = NO;
            type = @"L30";
        }else if (sender.tag == 101) {
            btnOne.selected = NO;
            btnThree.selected = NO;
            type = @"L31";
        }else {
            btnOne.selected = NO;
            btnTwo.selected = NO;
            type = @"L32";
        }
        
        //改变选择状态
        sender.selected = !sender.selected;
        
        [self requestForInfo:type page:0];
        
    }
}

//获取数据
- (void)requestForInfo:(NSString *)orgType page:(NSInteger)page {
    
    NSDictionary *dic = @{
                          @"orgType":orgType,
                          @"page":[NSString stringWithFormat:@"%ld",page],
                          @"limit":[NSString stringWithFormat:@"%d",10]
                          };
    NSString *action = @"OrgChildInfo";
    NSDictionary *requestDic =@{
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
            if ([resultDic[@"records"] isKindOfClass:[NSArray class]]) {
                
                _orderList = resultDic[@"records"];
                NSString *agent = nil;
                if ([orgType isEqualToString:@"L30"]) {
                    agent = @"办事处";
                }else if ([orgType isEqualToString:@"L31"]) {
                    agent = @"一级代理商";
                }else if ([orgType isEqualToString:@"L32"]) {
                    agent = @"特约代理商";
                }
                numLab.text = [NSString stringWithFormat:@"当前共有%ld个%@",_orderList.count,agent];
                [table reloadData];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //NSLog(@"%@,%ld,%ld",_orderList,_orderList.count*6 + _orderList.count>0?(_orderList.count - 1):0,_orderList.count);
    
    return (_orderList.count*6 + (_orderList.count>0?(_orderList.count - 1):0));
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHTitleCell alloc] init];
        if (indexPath.row%7 == 6) {
            cell.backgroundColor = ColorTableBackColor;
            cell.ShowBottomLine = NO;
        }else if (indexPath.row%7 == 5) {
            cell.ShowBottomLine = NO;
            cell.leftLab.text = @"名下总商户";
            cell.rightLab.text = [NSString stringWithFormat:@"%@",_orderList[indexPath.row/7][@"childUserCount"]];
        }else if (indexPath.row%7 == 4) {
            cell.leftLab.text = @"名下代理商";
            cell.rightLab.text = [NSString stringWithFormat:@"%@",_orderList[indexPath.row/7][@"childOrgCount"]];
        }else if (indexPath.row%7 == 3) {
            cell.leftLab.text = @"开通时间";
            cell.rightLab.text = _orderList[indexPath.row/7][@"openTime"];
        }else if (indexPath.row%7 == 2) {
            cell.leftLab.text = @"联系方式";
            cell.rightLab.text = _orderList[indexPath.row/7][@"orgPhone"];
        }else if (indexPath.row%7 == 1) {
            cell.leftLab.text = @"代理级别";
            NSString *orgType = _orderList[indexPath.row/7][@"orgType"];
            if ([orgType isEqualToString:@"L30"]) {
                cell.rightLab.text = @"办事处";
            }else if ([orgType isEqualToString:@"L31"]) {
                cell.rightLab.text = @"一级代理";
            }else if ([orgType isEqualToString:@"L32"]) {
                cell.rightLab.text = @"特约代理";
            }
        }else {
            cell.leftLab.text = @"代理名称";
            cell.rightLab.text = self.orderList[indexPath.row][@"orgName"];
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row%7 == 6) {
        return 5;
    }else {
        return 41;
    }
    
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
