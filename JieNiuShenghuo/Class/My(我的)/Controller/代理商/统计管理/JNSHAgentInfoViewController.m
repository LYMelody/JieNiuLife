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

@interface JNSHAgentInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHAgentInfoViewController {
    
    UIButton *btnOne;
    UIButton *btnTwo;
    UIButton *btnThree;
    NSInteger count;
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
    
    btnOne = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnOne setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [btnOne setImage:[UIImage imageNamed:@"---checkmark"] forState:UIControlStateSelected];
    [btnOne addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    btnOne.tag = 100;
    btnOne.selected = YES;
    [headBackImg addSubview:btnOne];
    
    [btnOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchLab);
        make.left.equalTo(searchLab.mas_right).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:15], [JNSHAutoSize width:15]));
    }];
    
    UILabel *LabOne = [[UILabel alloc] init];
    LabOne.text = @"办事处";
    LabOne.textColor = ColorLightText;
    LabOne.font = [UIFont systemFontOfSize:13];
    LabOne.textAlignment = NSTextAlignmentLeft;
    [headBackImg addSubview:LabOne];
    [LabOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnOne);
        make.left.equalTo(btnOne.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:40], [JNSHAutoSize height:15]));
    }];
    
    btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnTwo setImage:[UIImage imageNamed:@"unchecked"] forState:UIControlStateNormal];
    [btnTwo setImage:[UIImage imageNamed:@"---checkmark"] forState:UIControlStateSelected];
    [btnTwo addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    btnTwo.tag = 101;
    [headBackImg addSubview:btnTwo];
    
    [btnTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(searchLab);
        make.left.equalTo(LabOne.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:15], [JNSHAutoSize width:15]));
    }];
    
    UILabel *labTwo = [[UILabel alloc] init];
    labTwo.text = @"一级代理商";
    labTwo.textColor = ColorLightText;
    labTwo.font = [UIFont systemFontOfSize:13];
    labTwo.textAlignment = NSTextAlignmentLeft;
    [headBackImg addSubview:labTwo];
    
    [labTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnTwo);
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
    [headBackImg addSubview:labThree];
    
    [labThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btnThree);
        make.left.equalTo(btnThree.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:80], [JNSHAutoSize height:15]));
    }];
    
    UILabel *numLab = [[UILabel alloc] init];
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
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:68], KscreenWidth, self.view.bounds.size.height - [JNSHAutoSize height:(128+50)]) style:UITableViewStylePlain];
    
    table.dataSource = self;
    table.delegate = self;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.backgroundColor = ColorTableBackColor;
    [self.view addSubview:table];
    
    [table reloadData];
    
}


- (void)select:(UIButton *)sender {
    
    
    if (sender.selected) {
       
        
    }else {
        
        //其他按钮去掉选择
        if (sender.tag == 100) {
            btnTwo.selected = NO;
            btnThree.selected = NO;
        }else if (sender.tag == 101) {
            btnOne.selected = NO;
            btnThree.selected = NO;
        }else {
            btnOne.selected = NO;
            btnTwo.selected = NO;
        }
        
        //改变选择状态
        sender.selected = !sender.selected;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (2*6 + 1);
    
    
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
            cell.rightLab.text = @"4521个";
        }else if (indexPath.row%7 == 4) {
            cell.leftLab.text = @"名下代理商";
            cell.rightLab.text = @"1个";
        }else if (indexPath.row%7 == 3) {
            cell.leftLab.text = @"开通时间";
            cell.rightLab.text = @"2017-10-20";
        }else if (indexPath.row%7 == 2) {
            cell.leftLab.text = @"联系方式";
            cell.rightLab.text = @"151****2344";
        }else if (indexPath.row%7 == 1) {
            cell.leftLab.text = @"代理级别";
            cell.rightLab.text = @"一级代理商";
        }else {
            cell.leftLab.text = @"代理名称";
            cell.rightLab.text = @"张三丰/捷牛科技";
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
