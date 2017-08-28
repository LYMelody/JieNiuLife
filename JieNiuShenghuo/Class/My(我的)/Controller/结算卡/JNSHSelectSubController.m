//
//  JNSHSelectSubController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSelectSubController.h"
#import "Masonry.h"
@interface JNSHSelectSubController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@end

@implementation JNSHSelectSubController


- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"选择支行";
    self.view.backgroundColor = [UIColor whiteColor];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.showsVerticalScrollIndicator = NO;
    table.sectionHeaderHeight = [JNSHAutoSize height:44];
    table.sectionFooterHeight = 0;
    [self.view addSubview:table];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 20;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = ColorText;
        cell.textLabel.text = @"工商银行杭州分行";
    }
    
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:44])];
    
    view.backgroundColor = ColorTableBackColor;
    
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    [view addSubview:searchBar];
    searchBar.placeholder = @"搜索支行";
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.equalTo(view);
    }];
    
    
    return view;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    
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
