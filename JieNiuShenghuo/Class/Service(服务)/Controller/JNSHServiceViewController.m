//
//  JNSHServiceViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/2.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHServiceViewController.h"
#import "JNSHServiceCell.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "UIImageView+WebCache.h"
#import "JNSHWebViewController.h"

@interface JNSHServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHServiceViewController {
    
    UITableView *table;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationItem.title = @"服务";
    self.navigationController.navigationBar.barTintColor = ColorTabBarBackColor;
    //设置导航栏标题颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                                                      }];
    
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor redColor];
    
    [table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = [UIColor whiteColor];
    table.showsVerticalScrollIndicator = NO;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:189])];
    headerView.backgroundColor = [UIColor grayColor];
    headerView.userInteractionEnabled = YES;
    table.tableHeaderView = headerView;
    
    [self.view addSubview:table];
    
    if(!self.serviceList) {
        
        self.serviceList = [[NSArray alloc] init];
        
    }
    
    //获取服务信息
    [self getserviceInfo];
    
}

//获取服务信息
- (void)getserviceInfo {
    
    NSDictionary *dic = @{
                          @"timestamp":[JNSHAutoSize getTimeNow]
                          };
    NSString *action = @"ServiceInfoList";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":[JNSYUserInfo getUserInfo].userToken,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [result JSONValue];
        NSLog(@"%@",resultDic);
        if ([resultDic[@"serviceInfos"] isKindOfClass:[NSArray class]]) {
            self.serviceList = resultDic[@"serviceInfos"];
            [table reloadData];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.serviceList.count + 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        
        if (indexPath.row == 0) {
            cell = [[UITableViewCell alloc] init];
            
        }else if (indexPath.row > 0) {
            JNSHServiceCell *Cell = [[JNSHServiceCell alloc] init];
            [Cell.leftImg sd_setImageWithURL:[NSURL URLWithString:self.serviceList[indexPath.row - 1][@"icon"]]];
            Cell.titleLab.text = self.serviceList[indexPath.row - 1][@"title"];
            Cell.subTitleLab.text = self.serviceList[indexPath.row - 1][@"desc"];
            cell = Cell;
        }
        
    }
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 5;
    }else {
        
        return 56;
        
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    JNSHWebViewController *webVc = [[JNSHWebViewController alloc] init];
    webVc.hidesBottomBarWhenPushed = YES;
    webVc.url = self.serviceList[indexPath.row - 1][@"url"];
    webVc.Navtitle = self.serviceList[indexPath.row - 1][@"title"];
    [self.navigationController pushViewController:webVc animated:YES];
    
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
