//
//  JNSYHighLightImageView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/3.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSYHighLightImageView.h"

@implementation JNSYHighLightImageView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.highlighted = YES;
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.highlighted = NO;
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    self.highlighted = NO;
}


- (void)setHighlighted:(BOOL)highlighted {
    
    
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.alpha = 0.6;
    }else {
        self.alpha = 1.0;
    }
    
    
}

@end
