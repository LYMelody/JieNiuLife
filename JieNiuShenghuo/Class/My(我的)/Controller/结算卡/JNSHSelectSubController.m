//
//  JNSHSelectSubController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSelectSubController.h"
#import "Masonry.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSYUserInfo.h"
#import "JNSHAutoSize.h"
#import "JNSHSelectCityController.h"
#import "JNSHSettlementCardController.h"
@interface JNSHSelectSubController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property(nonatomic,strong)NSArray *subBankArray;

@property(nonatomic,strong)NSMutableArray *searchArray;




@end

@implementation JNSHSelectSubController {
    
    UITableView *table;
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    self.title = @"选择支行";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self requestForSubBank:self.bankName city:self.city];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.subBankArray = [[NSArray alloc] init];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.showsVerticalScrollIndicator = NO;
    table.sectionHeaderHeight = [JNSHAutoSize height:44];
    table.sectionFooterHeight = 0;
    [self.view addSubview:table];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return  self.searchArray == nil? self.subBankArray.count : self.searchArray.count;
    
}

//获取支行列表
- (void)requestForSubBank:(NSString *)bank city:(NSString *)city {
    
    NSDictionary *dic = @{
                          @"bankType":bank,
                          @"city":city
                          };
    NSString *action = @"CardCnapsSearch";
    
    NSDictionary *requstDic = @{
                                @"action":action,
                                @"data":dic,
                                @"token":[JNSYUserInfo getUserInfo].userToken
                                };
    
    NSString *params = [requstDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        NSLog(@"%@",resultdic);
        NSString *msg = resultdic[@"msg"];
        if ([code isEqualToString:@"000000"]) {
            
            self.subBankArray = resultdic[@"cnapsList"];
            
            [table reloadData];
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];

    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = ColorText;
        
        if (self.searchArray != nil) {
            cell.textLabel.text = self.searchArray[indexPath.row][@"bankName"];
        }else if (self.subBankArray.count > 0) {
            cell.textLabel.text = self.subBankArray[indexPath.row][@"bankName"];
        }
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count - 2)] isKindOfClass:[JNSHSelectCityController class]]) { //如果是城市页面PUSH
        
        JNSHSettlementCardController *Vc = [self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count - 4)];
        if(self.searchArray != nil) {
            
            Vc.subBank = self.searchArray[indexPath.row][@"bankName"];
            Vc.subBankCode = self.searchArray[indexPath.row][@"bankCode"];
            
        }else {
            Vc.subBank = self.subBankArray[indexPath.row][@"bankName"];
            Vc.subBankCode = self.subBankArray[indexPath.row][@"bankCode"];
        }
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count - 4)] animated:YES];

    }else {
        
        JNSHSettlementCardController *Vc = [self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count - 3)];
        if(self.searchArray != nil) {
            
            Vc.subBank = self.searchArray[indexPath.row][@"bankName"];
            Vc.subBankCode = self.searchArray[indexPath.row][@"bankCode"];
        }else {
            Vc.subBank = self.subBankArray[indexPath.row][@"bankName"];
            Vc.subBankCode = self.subBankArray[indexPath.row][@"bankCode"];
        }
        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:(self.navigationController.viewControllers.count - 3)] animated:YES];
    }
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",searchBar.text];
    
    NSMutableArray *midArray = [[NSMutableArray alloc] init];
   
    for (NSInteger i = 0; i < self.subBankArray.count; i++) {
        NSString *dic =self.subBankArray[i][@"bankName"];
        [midArray addObject:dic];
    }
    
    NSArray *resultArray = [midArray filteredArrayUsingPredicate:pred];
    
    NSLog(@"结果%@",resultArray);
    
    self.searchArray = [[NSMutableArray alloc] init];
    
    for (NSInteger i = 0; i<resultArray.count; i++) {
        for (NSInteger j = 0; j < self.subBankArray.count; j++) {
            if ([[self.subBankArray[j] objectForKey:@"bankName"] isEqualToString:[resultArray[i] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]) {
                [self.searchArray addObject:self.subBankArray[j]];
                //NSLog(@"银行卡信息:%@",self.subBankArray[j][@"bankName"]);
            }
        }
    }
    
    if ([searchBar.text isEqualToString:@""]) {
        self.searchArray = nil;
    }

    [table reloadData];

}

-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    if (range.location == 0) {
        
        self.searchArray = nil;
        [table reloadData];
    }
    
    
    return YES;
    
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
