//
//  JNSHPopBankCardView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHPopBankCardView.h"
#import "Masonry.h"
#import "JNSHBankSelectCell.h"
#define popHeight 247



@implementation JNSHPopBankCardView {
    
   
    NSInteger count;
}


- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _currentIndex = 0;
        count = 5;
        [self setUpViews];
    }
    
    return self;
}


- (void)setUpViews{
    
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
    typeLab.text = @"选择付款方式";
    typeLab.font = [UIFont systemFontOfSize:15];
    typeLab.textAlignment = NSTextAlignmentCenter;
    typeLab.textColor = ColorText;
    [backImg addSubview:typeLab];
    
    if (self.typetag  == 1) {
        
    }else if(self.typetag == 2) {
        typeLab.text = @"选择银行";
    }
    
    [typeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backImg);
        make.centerX.equalTo(backImg);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:140], [JNSHAutoSize height:20]));
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, [JNSHAutoSize height:(popHeight - 46 - ((self.typetag ==  1)?46:0))]) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.contentView addSubview:self.tableView];
    
    
    if (self.typetag == 1) {
        
        //add新卡
        UIImageView *AddBackImg = [[UIImageView alloc] init];
        AddBackImg.backgroundColor = [UIColor whiteColor];
        AddBackImg.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapAddNewCard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAdd)];
        tapAddNewCard.numberOfTapsRequired = 1;
        
        [AddBackImg addGestureRecognizer:tapAddNewCard];
        
        [self.contentView addSubview:AddBackImg];
        
        [AddBackImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_tableView.mas_bottom);
            make.left.right.equalTo(self.contentView);
            make.height.mas_equalTo([JNSHAutoSize height:51]);
        }];

        
        UIImageView *leftImg = [[UIImageView alloc] init];
        leftImg.image = [UIImage imageNamed:@"payment_new-card"];
        [AddBackImg addSubview:leftImg];
        
        [leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(AddBackImg);
            make.left.equalTo(AddBackImg).offset([JNSHAutoSize width:16]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:22], [JNSHAutoSize width:18]));
        }];
        
        UILabel *AddLab = [[UILabel alloc] init];
        AddLab.text = @"添加新信用卡付款";
        AddLab.font = [UIFont systemFontOfSize:15];
        AddLab.textColor = ColorText;
        AddLab.textAlignment = NSTextAlignmentLeft;
        [AddBackImg addSubview:AddLab];
        
        [AddLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(AddBackImg);
            make.left.equalTo(leftImg.mas_right).offset([JNSHAutoSize width:15]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:180], [JNSHAutoSize height:20]));
        }];
        
        UIImageView *rightImg = [[UIImageView alloc] init];
        rightImg.image = [UIImage imageNamed:@"my_arror_right"];
        [AddBackImg addSubview:rightImg];
        
        [rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(AddBackImg);
            make.right.equalTo(AddBackImg).offset(-[JNSHAutoSize width:18]);
        }];
    }
    
    
}

//添加新卡片
- (void)tapAdd {
    

    if (self.addnewCardBlock) {
        self.addnewCardBlock();
    }
    
    [self dismiss];
    
}

- (void)showInView:(UIView *)view {
    
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:self.contentView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];
    
    self.contentView.frame = CGRectMake(0, KscreenHeight, KscreenWidth, 100);
    [UIView animateWithDuration:0.3 animations:^{
         self.contentView.frame = CGRectMake(0, KscreenHeight - [JNSHAutoSize height:popHeight], KscreenWidth, [JNSHAutoSize height:popHeight]);
    }];
}

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    JNSHBankSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    __weak typeof(self) weakSelf = self;
    
    if (cell == nil) {
        cell = [[JNSHBankSelectCell alloc] init];
        if (self.typetag == 1) {
            cell.tag = 1;
        }else {
            cell.tag = 2;
        }
        if (indexPath.row == _currentIndex) {
            cell.selectBtn.selected = YES;
        }else {
            cell.selectBtn.selected = NO;
        }
        cell.cardSelectBlock = ^{
            __strong typeof(self) strongSelf = weakSelf;
            strongSelf.currentIndex = indexPath.row;
        };
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [JNSHAutoSize height:51];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    self.currentIndex = indexPath.row;
    
    
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    _currentIndex = currentIndex;
    

    [self.tableView reloadData];
    
    
}

- (void)setTypetag:(NSInteger)typetag {
    
    _typetag = typetag;
    
    [self setUpViews];
}
@end
