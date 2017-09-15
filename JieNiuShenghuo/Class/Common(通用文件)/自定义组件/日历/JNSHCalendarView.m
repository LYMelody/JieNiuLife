//
//  JNSHCalendarView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/16.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHCalendarView.h"
#import "Masonry.h"

@interface JNSHCalendarView()

@property(nonatomic,strong)UIButton *leftBtn;

@property(nonatomic,strong)UIButton *rightBtn;

@property(nonatomic,assign)NSInteger currentTag;

@property(nonatomic,strong)UIImageView *bottomLine;

@end

@implementation JNSHCalendarView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        [self setUpViews];
        
    }
    
    return self;
}

- (void)setUpViews{
    
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.frame = CGRectMake(0,64+ [JNSHAutoSize height:46], KscreenWidth, 0);
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:44])];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    
    NSString *time = [formatter stringFromDate:[NSDate date]];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftBtn.tag = 100;
    _leftBtn.backgroundColor = [UIColor whiteColor];
    [_leftBtn setTitle:time forState:UIControlStateNormal];
    [_leftBtn setTitleColor:ColorTabBarBackColor forState:UIControlStateSelected];
    [_leftBtn setTitleColor:ColorLightText forState:UIControlStateNormal];
    _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_leftBtn addTarget:self action:@selector(dateselect:) forControlEvents:UIControlEventTouchUpInside];
    _leftBtn.selected = YES;
    _currentTag = 100;
    
    [_headerView addSubview:_leftBtn];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headerView);
        make.left.equalTo(_headerView).offset([JNSHAutoSize width:34]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:15]));
    }];
    
    UILabel *midLab = [[UILabel alloc] init];
    midLab.text = @"至";
    midLab.textAlignment = NSTextAlignmentCenter;
    midLab.font = [UIFont systemFontOfSize:15];
    midLab.textColor = ColorLightText;
    [self.headerView addSubview:midLab];
    
    [midLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerView);
        make.left.equalTo(_leftBtn.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:20], [JNSHAutoSize height:20]));
    }];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.tag = 101;
    _rightBtn.backgroundColor = [UIColor whiteColor];
    [_rightBtn setTitle:time forState:UIControlStateNormal];
    [_rightBtn setTitleColor:ColorLightText forState:UIControlStateNormal];
    [_rightBtn setTitleColor:ColorTabBarBackColor forState:UIControlStateSelected];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_rightBtn addTarget:self action:@selector(dateselect:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_rightBtn];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headerView);
        make.left.equalTo(midLab.mas_right).offset([JNSHAutoSize width:10]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:15]));
    }];
    
    //CGFloat height = CGRectGetMaxY(self.leftBtn.frame);
    self.bottomLine = [[UIImageView alloc] initWithFrame:CGRectMake([JNSHAutoSize width:48], [JNSHAutoSize height:(33 + 3)], [JNSHAutoSize width:77], [JNSHAutoSize height:3])];
    self.bottomLine.backgroundColor = ColorTabBarBackColor;
    
    [_headerView addSubview:self.bottomLine];
    
    
    UIButton *commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitBtn setTitle:@"确定" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    commitBtn.layer.cornerRadius = 3;
    commitBtn.layer.masksToBounds = YES;
    commitBtn.backgroundColor = blueColor;
    [commitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:commitBtn];
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_headerView);
        make.right.equalTo(_headerView).offset(-[JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:50], [JNSHAutoSize height:25]));
    }];
    
    self.calendarView = [[DAYCalendarView alloc] init];
    self.calendarView.boldPrimaryComponentText = NO;
    [self.calendarView addTarget:self action:@selector(calendarViewDidChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.contentView addSubview:self.headerView];
    
}

//确定
- (void)commit {
    
    
    if (self.datechoseblock) {
        self.datechoseblock();
    }
    
    [self dismiss];
    
    NSLog(@"提交");
    
}


- (void)dateselect:(UIButton *)btn {
    
    
    if (!btn.isSelected) {  //没有选择
        
        if(btn.tag == 100) {  //选择起始时间
            self.rightBtn.selected = NO;
            _currentTag = 100;
            
           [UIView animateWithDuration:0.3 animations:^{
               
               CGRect frame = self.bottomLine.frame;
               
               CGFloat maxX = CGRectGetMinX(self.leftBtn.frame);
               
               frame.origin.x = maxX + [JNSHAutoSize width:14];
               
               self.bottomLine.frame = frame;
               
              
               
           }];
            
            
        }else if (btn.tag == 101) {
            self.leftBtn.selected = NO;
            _currentTag = 101;
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect frame = self.bottomLine.frame;
                
                CGFloat maxX = CGRectGetMinX(self.rightBtn.frame);
                
                frame.origin.x = maxX + [JNSHAutoSize width:14];
                
                self.bottomLine.frame = frame;
                
                
                
            }];
            
            
        }
        
        btn.selected = ! btn.selected;
        
    }else {                 //已经选择
        
        
    }
}

- (void)calendarViewDidChange:(id)sender {
    //self.datePicker.date = self.calendarView.selectedDate;
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";
    NSLog(@"%@", [formatter stringFromDate:self.calendarView.selectedDate]);
    
    NSString *time = [formatter stringFromDate:self.calendarView.selectedDate];
    
    if (_currentTag == 100) {  //起始时间
        [self.leftBtn setTitle:time forState:UIControlStateNormal];
    }else {                    //终止时间
        [self.rightBtn setTitle:time forState:UIControlStateNormal];
    }
}

- (void)showInView:(UIView *)view {
    
    if (!view) {
        return;
    }
    [view addSubview:self];
    [view addSubview:self.contentView];
    [view addSubview:self.calendarView];
    //[view addSubview:self.headerView];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    }];

    self.contentView.frame = CGRectMake(0,  [JNSHAutoSize height:46], KscreenWidth, [JNSHAutoSize height:0]);
    self.calendarView.frame = CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:90], KscreenWidth - [JNSHAutoSize width:15]*2, [JNSHAutoSize height:0]);
    //self.headerView.frame = CGRectMake(0, [JNSHAutoSize height:110], KscreenWidth, [JNSHAutoSize height:0]);
    [UIView animateWithDuration:0.2 animations:^{
        //self.headerView.frame = CGRectMake(0, [JNSHAutoSize height:110], KscreenWidth, [JNSHAutoSize height:44]);
        self.contentView.frame = CGRectMake(0, [JNSHAutoSize height:46], KscreenWidth, [JNSHAutoSize height:300]);
        self.calendarView.frame = CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:90], KscreenWidth - [JNSHAutoSize width:15]*2, [JNSHAutoSize height:250]);
    }];
    
}


- (void)dismiss {
    
    
    if (self.dismissblock) {
        self.dismissblock();
    }
    
    
    [self.calendarView removeFromSuperview];
    //[self.headerView removeFromSuperview];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.contentView.frame = CGRectMake(0,  [JNSHAutoSize height:46], KscreenWidth, [JNSHAutoSize height:0]);
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        [self removeFromSuperview];
        
    }];

    
}

@end
