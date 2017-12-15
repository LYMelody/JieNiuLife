//
//  JNSHTiXianAlertView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/12/13.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHTiXianAlertView.h"
#import "Masonry.h"
#import "JNSHTiXianCell.h"

#define popHeight 300
#define bottomHeight 80

@implementation JNSHTiXianAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setUpViews];
    }
    
    return self;
    
}

- (void)setUpViews {
    
    self.frame = CGRectMake(0, 0, KscreenWidth, KscreenHeight);
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, KscreenHeight, KscreenWidth, [JNSHAutoSize height:popHeight])];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.userInteractionEnabled = YES;
    
    //付款方式
    UIImageView *backImg = [[UIImageView alloc] init];
    backImg.backgroundColor = [UIColor whiteColor];
    backImg.userInteractionEnabled = YES;
    
    [self.contentView addSubview:backImg];
    
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_offset([JNSHAutoSize height:46]);
    }];
    
    UIButton *dimissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dimissBtn setImage:[UIImage imageNamed:@"payment_delete"] forState:UIControlStateNormal];
    [dimissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [backImg addSubview:dimissBtn];
    [dimissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backImg);
        make.left.equalTo(backImg).offset([JNSHAutoSize width:16]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:15], [JNSHAutoSize height:15]));
    }];
    
    UILabel *typeLab = [[UILabel alloc] init];
    typeLab.text = @"确认提现";
    typeLab.font = [UIFont systemFontOfSize:15];
    typeLab.textAlignment = NSTextAlignmentCenter;
    typeLab.textColor = ColorText;
    [backImg addSubview:typeLab];
    
    [typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backImg);
        make.centerX.equalTo(backImg);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:140], [JNSHAutoSize height:20]));
    }];
    
    UIImageView *headerLine = [[UIImageView alloc] init];
    headerLine.backgroundColor = ColorLineSeperate;
    [backImg addSubview:headerLine];
    
    [headerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(backImg);
        make.left.equalTo(backImg).offset([JNSHAutoSize width:15]);
        make.right.equalTo(backImg).offset(-[JNSHAutoSize width:15]);
        make.height.mas_equalTo([JNSHAutoSize height:1]);
    }];
    
    //按钮
    
    UIImageView *btnImgView = [[UIImageView alloc] init];
    btnImgView.backgroundColor = [UIColor whiteColor];
    btnImgView.userInteractionEnabled = YES;
    [self.contentView addSubview:btnImgView];
    
    [btnImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo([JNSHAutoSize height:bottomHeight]);
    }];
    
    //取消按钮
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    cancleBtn.layer.cornerRadius = 3;
    cancleBtn.backgroundColor = GrayColor;
    [cancleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [btnImgView addSubview:cancleBtn];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnImgView);
        make.left.equalTo(btnImgView).offset([JNSHAutoSize width:80]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:91], [JNSHAutoSize height:31]));
    }];
    
    //确认按钮
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    sureBtn.layer.cornerRadius = 3;
    sureBtn.backgroundColor = ColorTabBarBackColor;
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [btnImgView addSubview:sureBtn];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnImgView);
        make.right.equalTo(btnImgView).offset(-[JNSHAutoSize width:80]);
        make.size.equalTo(cancleBtn);
    }];
    
    //table
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:46],KscreenWidth, [JNSHAutoSize height:(popHeight - 46 - bottomHeight)]) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    _tableView.scrollEnabled = NO;
    [self.contentView addSubview:self.tableView];
    
    
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHTiXianCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[JNSHTiXianCell alloc] init];
        switch (indexPath.row) {
            case 0:
                cell.leftLab.text = @"提现总额";
                cell.rightLab.text = [NSString stringWithFormat:@"￥%.2f",self.model.totalAmount];
                break;
            case 1:
                cell.leftLab.text = @"开票税费";
                cell.rightLab.text = [NSString stringWithFormat:@"￥%.2f",self.model.rateTax];
                break;
            case 2:
                cell.leftLab.text = @"提现费";
                cell.rightLab.text = [NSString stringWithFormat:@"￥%.2f",self.model.ratefree];
                break;
            case 3:
                cell.leftLab.text = @"到账金额";
                cell.rightLab.text = [NSString stringWithFormat:@"￥%.2f",self.model.settleReal];
                cell.rightLab.textColor = [UIColor redColor];
                break;
            default:
                break;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

//在父视图上展示
- (void)showInView:(UIView *)view {
    
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:self.contentView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
    
    float height = 64;
    
    //self.superview.inputViewController.navigationController.navigationBar.translucent
    
    if (self.superview.inputViewController.navigationController.navigationBar.translucent) {
        height = 0;
    }
    
    self.contentView.frame = CGRectMake(0, KscreenHeight, KscreenWidth, 100);
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(0, KscreenHeight - [JNSHAutoSize height:popHeight] - height, KscreenWidth, [JNSHAutoSize height:popHeight]);
    }];
    
}

//隐藏视图
- (void)dismiss {
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentView.frame = CGRectMake(0, KscreenHeight, KscreenWidth, [JNSHAutoSize height:popHeight]);
        self.contentView.alpha = 0.3;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.contentView removeFromSuperview];
    }];
    
}

//确认按钮点击方法
- (void)sure {
    
    NSLog(@"确认");
    
    if (self.sureTiXianBlock) {
        self.sureTiXianBlock();
    }
    
}

- (void)dealloc {
    
    NSLog(@"dealloc");
    
}



@end
