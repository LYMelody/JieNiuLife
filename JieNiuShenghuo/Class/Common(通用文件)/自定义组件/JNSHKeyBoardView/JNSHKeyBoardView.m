//
//  JNSHKeyBoardView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/12/20.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHKeyBoardView.h"
#import "Masonry.h"

#define popHeight 326

@implementation JNSHKeyBoardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        [self setUpViews];
    }
    
    return self;
    
    
}

//
- (void)setUpViews {
    
    self.frame = CGRectMake(0, 100, KscreenWidth, KscreenHeight);
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    tap.numberOfTapsRequired = 1;
    
    [self addGestureRecognizer:tap];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, KscreenHeight, KscreenWidth, popHeight)];
    self.contentView.backgroundColor = ColorTableBackColor;
    self.contentView.userInteractionEnabled = YES;
    
    //数字键盘
    NSArray *array = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"0",@"X"];
    
    CGFloat width = (KscreenWidth - 2*3)/4.0;
    CGFloat height = [JNSHAutoSize height:64];
    CGFloat midHeight = 0;
    if(IS_IphoneX) {
        
        midHeight = 64;
    }else {
        midHeight = 0;
    }
    
    for (NSInteger i = 0; i < 4; i++) {
        for (NSInteger j = 0; j < 3; j++) {
            UIButton *numberBtn = [[UIButton alloc] init];
            numberBtn.tag = 3*i + j;
            [numberBtn setTitle:array[3*i+j] forState:UIControlStateNormal];
            numberBtn.backgroundColor = [UIColor whiteColor];
            
            [numberBtn setTitleColor:ColorText forState:UIControlStateNormal];
            numberBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            numberBtn.frame = CGRectMake(j*(width + 2), (popHeight-64-midHeight) - ((4-i)*(height) + (3- i)*2), width, height);
            [numberBtn addTarget:self action:@selector(numSelect:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.contentView addSubview:numberBtn];
        }
    }
    
    //删除
    UIButton *delectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delectBtn.tag = 12;
    [delectBtn setBackgroundColor:[UIColor whiteColor]];
    [delectBtn setImage:[UIImage imageNamed:@"cashier_delete"] forState:UIControlStateNormal];
    [delectBtn setAdjustsImageWhenHighlighted:YES];
    [delectBtn addTarget:self action:@selector(numSelect:) forControlEvents:UIControlEventTouchUpInside];
    delectBtn.frame = CGRectMake(KscreenWidth - width, (popHeight-64-midHeight) - ((4)*(height) + (3)*2), width, height * 2 + 2);
    
    [self.contentView addSubview:delectBtn];
    
    //确定
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.tag = 13;
    [payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [payBtn setTitle:@"确定" forState:UIControlStateNormal];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [payBtn setBackgroundColor:ColorTabBarBackColor];
    [payBtn addTarget:self action:@selector(numSelect:) forControlEvents:UIControlEventTouchUpInside];
    payBtn.frame = CGRectMake(KscreenWidth - width, (popHeight-64-midHeight) - ((2)*(height) + 2*2), width, height * 2 + 2*2);
    [self.contentView addSubview:payBtn];
    
}

//按钮点击方法
- (void)numSelect:(UIButton *)sender {
    
    //UIButton *btn =sender;
    
    NSLog(@"btn tag :%ld",sender.tag);
    
    if (self.itemSelectBlock) {
        self.itemSelectBlock(sender.tag,sender.titleLabel.text);
    }
    
    
}



- (void)showInView:(UIView *)view {
    
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:self.contentView];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.0];
    }];
    
    float height = 64;
    
    //self.superview.inputViewController.navigationController.navigationBar.translucent
    
    if (self.superview.inputViewController.navigationController.navigationBar.translucent) {
        height = 0;
    }
    height = 0;
    self.contentView.frame = CGRectMake(0, KscreenHeight, KscreenWidth, 100);
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(0,self.frame.size.height - popHeight - height, KscreenWidth, popHeight);
    }];
    
    
    self.IsShowed = YES;
    
    
}

- (void)dismiss {
    
    self.IsShowed = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.contentView.frame = CGRectMake(0, KscreenHeight, KscreenWidth, popHeight);
        self.contentView.alpha = 0.3;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.contentView removeFromSuperview];
    }];
    
}


@end
