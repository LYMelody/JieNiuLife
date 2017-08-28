//
//  JNSHPopYXQView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHPopYXQView.h"
#import "Masonry.h"

#define popHeight 247

@interface JNSHPopYXQView()<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,assign)NSInteger yearRange;

@property(nonatomic,strong)NSArray *montyArr;

@property(nonatomic,strong)NSArray *yearArr;

@property(nonatomic,assign)NSInteger curYear;

@end


@implementation JNSHPopYXQView {
    
    UIPickerView *_pickerView;
    
}

- (id)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
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
    
    [self addSubview:self.contentView];
    
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:44])];
    headImgView.userInteractionEnabled = YES;
    headImgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:headImgView];
    
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [cancleBtn setImage:[UIImage imageNamed:@"payment_delete"] forState:UIControlStateNormal];
    
    [headImgView addSubview:cancleBtn];
    
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headImgView);
        make.left.equalTo(headImgView).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:30], [JNSHAutoSize height:30]));
    }];
    
    
    UILabel *YXQLab = [[UILabel alloc] init];
    YXQLab.font = [UIFont systemFontOfSize:15];
    YXQLab.textColor = ColorText;
    YXQLab.textAlignment = NSTextAlignmentCenter;
    YXQLab.text = @"有效期";
    [headImgView addSubview:YXQLab];
    
    [YXQLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.height.equalTo(headImgView);
        make.width.mas_equalTo([JNSHAutoSize width:100]);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor colorWithRed:255/255.0 green:102/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    rightBtn.backgroundColor = [UIColor whiteColor];
    [rightBtn addTarget:self action:@selector(complect) forControlEvents:UIControlEventTouchUpInside];
    
    [headImgView addSubview:rightBtn];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headImgView);
        make.right.equalTo(headImgView).offset(-[JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:60], [JNSHAutoSize height:40]));
    }];

    _pickerView = [[UIPickerView alloc] init];
    _pickerView.delegate = self;
    _pickerView.backgroundColor = LightGrayColor;
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *com = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:[NSDate date]];
    self.curYear = com.year;
    NSLog(@"%ld",(long)self.curYear);
    _yearRange = 100;
    
    [_pickerView selectRow:_yearRange inComponent:0 animated:NO];
    [_pickerView selectRow:com.month-1 inComponent:1 animated:NO];
    
    [self.contentView addSubview:_pickerView];
    
    
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headImgView.mas_bottom);
        make.left.right.bottom.equalTo(self.contentView);
    }];
}

- (NSString *)selectDate {
    
    NSInteger year = self.curYear - _yearRange + [_pickerView selectedRowInComponent:0];
    NSInteger month = [_pickerView selectedRowInComponent:1] + 1;
    
    return [NSString stringWithFormat:@"%ld/%.2ld",(long)year,(long)month];
}

#pragma mark pickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return _yearRange*2+1;
    }
    
    return 12;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    if (component == 0) {
        return pickerView.frame.size.width/2.0;
        
    }else {
        return pickerView.frame.size.width/3.0;
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        row = self.curYear-_yearRange+row;
        return [NSString stringWithFormat:@"%ld年",(long)row];
    }else {
        return [NSString stringWithFormat:@"%d月",row+1];
    }
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
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
    
    self.contentView.frame = CGRectMake(0, KscreenHeight, KscreenWidth, [JNSHAutoSize height:popHeight]);
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

- (void)complect {
    
    if (self.selectdateblock) {
        self.selectdateblock(self.selectDate);
    }
    
    
    //NSLog(@"selectdate:%@",self.selectDate);
    
    [self dismiss];
    
}


@end
