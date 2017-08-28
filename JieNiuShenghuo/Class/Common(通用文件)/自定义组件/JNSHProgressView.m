//
//  JNSHProgressView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/3.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHProgressView.h"

@implementation JNSHProgressView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        _trackView = [[UIImageView alloc] init];
        _trackView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _trackView.backgroundColor = [UIColor whiteColor];
        _trackView.layer.borderColor = [UIColor redColor].CGColor;
        _trackView.layer.borderWidth = 1;
        _trackView.layer.cornerRadius = 3;
        _trackView.layer.masksToBounds = YES;
        
        [self addSubview:_trackView];
        
        self.progress = 0.3;
        
        self.progressView = [[UIImageView alloc] init];
        self.progressView.backgroundColor = [UIColor redColor];
        self.progressView.frame = CGRectMake(0, 0, frame.size.width*self.progress, frame.size.height);
        
        [self.trackView addSubview:self.progressView];
        
       
    }
    
    return self;
    
}

- (void)setProgress:(float)progress {
    
    _progress = progress;
    
    self.progressView.frame = CGRectMake(0, 0, self.frame.size.width*_progress, self.frame.size.height);
    
}


@end
