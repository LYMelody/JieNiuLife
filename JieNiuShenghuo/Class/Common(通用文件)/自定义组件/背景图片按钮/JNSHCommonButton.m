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
    
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self setBackgroundImage:[UIImage imageNamed:@"btn_nor"] forState:UIControlStateNormal];
    
    [self setBackgroundImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateSelected];
    
    
}

- (void)setEnabled:(BOOL)enabled {
    
    [super setEnabled:enabled];
    
    if (enabled) {
       [self setBackgroundImage:[UIImage imageNamed:@"btn_nor"] forState:UIControlStateNormal];
    }else {
        [self setBackgroundImage:[UIImage imageNamed:@"btn_non-clickable"] forState:UIControlStateNormal];
    }
    
}



@end
