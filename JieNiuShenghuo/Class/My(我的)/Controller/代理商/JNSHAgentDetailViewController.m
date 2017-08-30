//
//  JNSHAgentDetailViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/30.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAgentDetailViewController.h"
#import "JNSHAccountInfoCell.h"
#import "JNSHTradeNumCell.h"
#import "JNSHAgentCell.h"

@interface JNSHAgentDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHAgentDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    
    
    self.title = @"代理商";
    self.view.backgroundColor = ColorTabBarBackColor;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    backImg.backgroundColor = ColorTabBarBackColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight ) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = ColorTableBackColor;
    
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    
    [backImg addSubview:table];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 11;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 5) {
            
            cell.backgroundColor = ColorTableBackColor;
            
        }else if (indexPath.row == 1) {
            
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"日分润";
            Cell.rightLab.text = @"￥1100.02";
            Cell.rightLab.textColor = ColorTabBarBackColor;
            cell = Cell;
            
        }else if (indexPath.row == 2) {
            JNSHTradeNumCell *Cell = [[JNSHTradeNumCell alloc] init];
            cell = Cell;
        }else if (indexPath.row == 4) {
            
            JNSHAgentCell *Cell = [[JNSHAgentCell alloc] init];
            cell = Cell;
            
        }
        else if (indexPath.row == 6) {
            
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"销售统计";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 7) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"商户管理";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 8) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"代理管理";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 9) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"订单管理";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 10) {
            JNSHAccountInfoCell *Cell = [[JNSHAccountInfoCell alloc] init];
            Cell.leftLab.text = @"分润管理";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 5) {
        return [JNSHAutoSize height:15];
    }else if (indexPath.row == 2) {
        return [JNSHAutoSize height:61];
    }else if (indexPath.row == 4) {
        return [JNSHAutoSize height:76];
    }else {
        return [JNSHAutoSize height:41];
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
