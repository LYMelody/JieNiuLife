//
//  JNSHActiveMessageController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/20.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHActiveMessageController.h"
#import "JNSHActiveMessageCell.h"
#import "UIImageView+WebCache.h"
#import "JNSHWebViewController.h"

@interface JNSHActiveMessageController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHActiveMessageController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"活动通知";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self.view addSubview:table];
    
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
    
    NSLog(@"消息列表:%@",self.messageList);
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.messageList.count + 1;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] init];
        
        if (indexPath.row == self.messageList.count) {
            cell.backgroundColor = ColorTableBackColor;
        }else {
            JNSHActiveMessageCell *Cell = [[JNSHActiveMessageCell alloc] init];
            NSDictionary *dic = self.messageList[indexPath.row];
            Cell.timeLab.text = dic[@"noticeTime"];
            Cell.titleLab.text = dic[@"noticeTitle"];
            Cell.contentLab.text = dic[@"noticeContent"];
            NSString *icon = dic[@"noticeIcon"];
            Cell.messageTapBlock = ^{
                
                NSString *url = [NSString stringWithFormat:@"%@",dic[@"noticeUrl"]];
                if ((![url isEqualToString:@"<null>"]) && (![url isKindOfClass:[NSNull class]]) ) {
                    JNSHWebViewController *WebVc = [[JNSHWebViewController alloc] init];
                    WebVc.url = url;
                    WebVc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:WebVc animated:YES];
                }
                
            };
            if (![icon isKindOfClass:[NSNull class]]) {
                [Cell.titleImg sd_setImageWithURL:[NSURL URLWithString:icon]];
            }
            cell = Cell;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.messageList.count) {
        return 20;
    }
    
    return [JNSHAutoSize height:270];
    
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
