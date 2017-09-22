//
//  JNSHSystemViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/6.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSystemViewController.h"
#import "JNSHSystemMessageCell.h"
@interface JNSHSystemViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation JNSHSystemViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"系统通知";
    self.view.backgroundColor = ColorTabBarBackColor;
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //灰色背景
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64)];
    backImg.userInteractionEnabled = YES;
    backImg.backgroundColor = ColorTableBackColor;
    
    [self.view addSubview:backImg];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = ColorTableBackColor;
    //table.showsVerticalScrollIndicator = NO;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [backImg addSubview:table];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.messageList.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dic = self.messageList[indexPath.row];
    
    NSString *message = dic[@"noticeContent"];
    
    float height = [self heightForString:message andWidth:(KscreenWidth - [JNSHAutoSize width:50])];
    
    if (height > 76) {
        return 86 + height;
    }else {
        return 162;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        
        cell = [[JNSHSystemMessageCell alloc] init];
        NSDictionary *dic = self.messageList[indexPath.row];
        cell.timeLab.text = dic[@"noticeTime"];
        cell.message = dic[@"noticeContent"];
        cell.titleLab.text = dic[@"noticeTitle"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (float)heightForString:(NSString *)value andWidth:(float)width {
    
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:value];
    NSRange range = NSMakeRange(0, attrStr.length);
    NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
    CGSize sietofit = [value boundingRectWithSize:CGSizeMake(width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return sietofit.height + 16 + 40;
    
    
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
