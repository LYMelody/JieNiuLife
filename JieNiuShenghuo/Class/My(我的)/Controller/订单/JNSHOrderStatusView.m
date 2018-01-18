//
//  JNSHOrderStatusView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHOrderStatusView.h"
#import "JNSHOrderStatusCell.h"
@implementation JNSHOrderStatusView {
    
    
    UITableView *table;
}

- (id)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews{
    
    //self.frame = CGRectMake(0, -, KscreenWidth, KscreenHeight);
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    //164
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, (self.array.count>3?[JNSHAutoSize height:164]:41*self.array.count))];
    table.dataSource = self;
    table.delegate = self;
    table.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    table.backgroundColor = [UIColor whiteColor];
    [self addSubview:table];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHOrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    //NSArray *array = @[@"全部",@"收款",@"会员购买",@"后台管理费"];
    
    if (cell == nil) {
        cell = [[JNSHOrderStatusCell alloc] init];
        cell.centerLab.text = self.array[indexPath.row];
        if (indexPath.row == self.selectIndex) {
            cell.rightImg.hidden = NO;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [JNSHAutoSize height:41];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectblock) {
        self.selectblock(indexPath);
    }
    
    [self dismiss];
}

- (void)showinView:(UIView *)view {
    
    if (!view) {
        return;
    }
    [view addSubview:self];
    [view addSubview:table];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
    
    table.frame = CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, [JNSHAutoSize height:0]);
    
    [UIView animateWithDuration:0.2 animations:^{
        table.frame = CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, (self.array.count>3?[JNSHAutoSize height:164]:41*self.array.count));
    }];
}


- (void)dismiss {
    
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        table.frame = CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, [JNSHAutoSize height:0]);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [table removeFromSuperview];
    }];
    
}


@end
