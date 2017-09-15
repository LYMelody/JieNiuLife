//
//  JNSHSubBankController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/14.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSubBankController.h"
#import "Masonry.h"
#import "JNSHSubBankCell.h"
#import "JNSHSelectCityController.h"
#import <CoreLocation/CoreLocation.h>
#import "JNSHSelectSubController.h"
@interface JNSHSubBankController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@end

@implementation JNSHSubBankController{
    
    
    UITableView *table;
    NSMutableArray *ProArr;
    NSMutableDictionary *Citydict;
    JNSHSubBankCell *Cell;
    
    CLLocationManager *Locmanager;
    CLGeocoder *geocoder;
    NSString *locationStr;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"选择支行";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [table reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   

    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"provinces" ofType:@"plist"];
    ProArr = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSString *Citypath = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"plist"];
    Citydict = [[NSMutableDictionary alloc] initWithContentsOfFile:Citypath];
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.sectionFooterHeight = 0;
    table.sectionHeaderHeight = 40;
    table.showsVerticalScrollIndicator = NO;
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
    
    [self.view addSubview:table];
    
    //定位
    Locmanager = [[CLLocationManager alloc] init];
    Locmanager.delegate = self;
    Locmanager.distanceFilter = 10;
    [Locmanager requestAlwaysAuthorization];
    [Locmanager startUpdatingLocation];
    
    geocoder = [[CLGeocoder alloc] init];
    
    //定位信息
    locationStr = @"正在定位...";
    
}

//反编码
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *mylocation = [locations lastObject];
    
    //停止定位
    [Locmanager stopUpdatingLocation];
    
    //设置语言
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans", nil] forKey:@"AppleLanguages"];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:mylocation.coordinate.latitude longitude:mylocation.coordinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            //NSLog(@"%@,%@,%@",placemark.locality,placemark.addressDictionary,placemark.administrativeArea);
            
            //设置定位地址
            locationStr = [placemark.locality stringByReplacingOccurrencesOfString:@"市" withString:@""];
            Cell.locationLab.text = locationStr;
           
        }
        if (error) {
            NSLog(@"获取失败：%@",error);
            
        }
        
        //还原系统语言
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
    }];
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view
{
    if ([view isKindOfClass:[UIImageView class]] || [view isKindOfClass:[UILabel class]])
    {
        return YES;
    }
    
    return [table touchesShouldCancelInContentView:view];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    }
    
    return ProArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.section == 0) {
            Cell = [[JNSHSubBankCell alloc] init];
            Cell.locationLab.text = locationStr;
            __weak typeof(self) weakSelf = self;
            
            Cell.citySelectBlock = ^(NSString *city) {//
                __strong typeof(self) strongSelf = weakSelf;
                JNSHSelectSubController *SelcectVc = [[JNSHSelectSubController alloc] init];
                SelcectVc.hidesBottomBarWhenPushed = YES;
                SelcectVc.city = city;
                SelcectVc.bankName = strongSelf.bankName;
                [strongSelf.navigationController pushViewController:SelcectVc animated:YES];
                
            };
            cell = Cell;
            
        }else {
            cell.textLabel.text = ProArr[indexPath.row];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.textColor = ColorText;
        }
    }
    
    if(indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return  cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return [JNSHAutoSize height:80];
    }else {
        return [JNSHAutoSize height:44];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    

    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:41])];
    backImg.backgroundColor = ColorTableBackColor;
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.font = [UIFont systemFontOfSize:13];
    titleLab.textColor = ColorText;
    titleLab.textAlignment = NSTextAlignmentLeft;
    if (section == 0) {
        titleLab.text = @"定位/常用城市";
    }else {
        titleLab.text = @"选择省份";
    }
    [backImg addSubview:titleLab];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backImg);
        make.left.equalTo(backImg).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:200], [JNSHAutoSize height:41]));
    }];

    return backImg;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        JNSHSelectCityController *Vc = [[JNSHSelectCityController alloc] init];
        NSString *proName = ProArr[indexPath.row];
        Vc.citylist = Citydict[proName];
        Vc.hidesBottomBarWhenPushed = YES;
        Vc.bankName = self.bankName;
        [self.navigationController pushViewController:Vc animated:YES];
        
    }
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    if (section == 0) {
//        return @"定位/常用城市";
//    }else {
//        return @"选择省份";
//    }
//    
//}

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
