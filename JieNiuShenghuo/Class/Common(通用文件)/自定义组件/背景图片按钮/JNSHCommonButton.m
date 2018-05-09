//
//  JNSHCommonButton.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/11.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHCommonButton.h"

@implementation JNSHCommonButton

- (id)initWithFrame:(CGRect)frame {
    
    
    if ([super initWithFrame:frame]) {
        
        [self setImages];
    }
    
    return self;
}

- (void)setImages{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isTaiHe = [user boolForKey:@"IsTaiHe"];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (isTaiHe && self.isLogin) {
        [self setBackgroundImage:[UIImage imageNamed:@"login_btn_h"] forState:UIControlStateNormal];
    } else {
        [self setBackgroundImage:[UIImage imageNamed:@"btn_nor"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateSelected];
    }
}

- (void)setEnabled:(BOOL)enabled {
    
    [super setEnabled:enabled];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isTaiHe = [user boolForKey:@"IsTaiHe"];
    
    if (enabled) {
        if (isTaiHe && self.isLogin) {
            [self setBackgroundImage:[UIImage imageNamed:@"login_btn_h"] forState:UIControlStateNormal];
        } else {
            [self setBackgroundImage:[UIImage imageNamed:@"btn_nor"] forState:UIControlStateNormal];
        }
    }else {
        if (isTaiHe) {
             [self setBackgroundImage:[UIImage imageNamed:@"login_btn_d"] forState:UIControlStateNormal];
        } else {
             [self setBackgroundImage:[UIImage imageNamed:@"btn_non-clickable"] forState:UIControlStateNormal];
        }
       
    }
    
}



@end
