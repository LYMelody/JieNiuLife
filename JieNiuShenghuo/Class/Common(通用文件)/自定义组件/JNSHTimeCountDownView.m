//
//  JNSHTimeCountDownView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/3.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHTimeCountDownView.h"
#import "Masonry.h"
#import "JNSHAutoSize.h"
#define blackwidth 20

@implementation JNSHTimeCountDownView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        
        _secondLab = [[UILabel alloc] init];
        _secondLab.font = [UIFont systemFontOfSize:13];
        _secondLab.textColor = [UIColor whiteColor];
        _secondLab.backgroundColor = [UIColor blackColor];
        _secondLab.textAlignment = NSTextAlignmentCenter;
        _secondLab.layer.cornerRadius = 2;
        _secondLab.layer.masksToBounds = YES;
        
        [self addSubview:_secondLab];
        
        [_secondLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.right.equalTo(self);
            make.width.height.mas_equalTo([JNSHAutoSize width:blackwidth]);
        }];
        
        UILabel *midSecondLab = [[UILabel alloc] init];
        midSecondLab.text = @":";
        midSecondLab.font = [UIFont systemFontOfSize:13];
        midSecondLab.textAlignment = NSTextAlignmentCenter;
        midSecondLab.textColor = [UIColor blackColor];
        midSecondLab.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:midSecondLab];
        
        [midSecondLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_secondLab);
            make.right.equalTo(_secondLab.mas_left);
            make.width.mas_equalTo([JNSHAutoSize width:3]);
        }];
        
        _minLab = [[UILabel alloc] init];
        _minLab.textColor = [UIColor whiteColor];
        _minLab.backgroundColor = [UIColor blackColor];
        _minLab.font = [UIFont systemFontOfSize:13];
        _minLab.textAlignment = NSTextAlignmentCenter;
        _minLab.layer.cornerRadius = 2;
        _minLab.layer.masksToBounds = YES;
        [self addSubview:_minLab];
        
        [_minLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(midSecondLab);
            make.right.equalTo(midSecondLab.mas_left);
            make.width.height.mas_equalTo([JNSHAutoSize width:blackwidth]);
        }];
        
        UILabel *midlab = [[UILabel alloc] init];
        midlab.text = @":";
        midlab.font = [UIFont systemFontOfSize:13];
        midlab.textAlignment = NSTextAlignmentCenter;
        midlab.textColor = [UIColor blackColor];
        midlab.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:midlab];
        
        [midlab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(_minLab);
            make.right.equalTo(_minLab.mas_left);
            make.width.mas_equalTo([JNSHAutoSize width:3]);
        }];

        _hourLab = [[UILabel alloc] init];
        _hourLab.textColor = [UIColor whiteColor];
        _hourLab.layer.cornerRadius = 2;
        _hourLab.layer.masksToBounds = YES;
        _hourLab.font = [UIFont systemFontOfSize:13];
        _hourLab.textAlignment = NSTextAlignmentCenter;
        _hourLab.backgroundColor = [UIColor blackColor];
        [self addSubview:_hourLab];
        
        [_hourLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(midlab.mas_left);
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:blackwidth], [JNSHAutoSize height:blackwidth]));
        }];
        
    }
    
    return self;
    
}

- (void)setTime:(NSInteger)time {
    
    _time = time;
    
    
    NSInteger hour = time/60/60;
    
    NSInteger min = (time - hour*60)/60;
    
    NSInteger second = time - (hour*60 + min)*60;
    
    
    _hourLab.text = [NSString stringWithFormat:@"%02ld",(long)hour];
    _minLab.text = [NSString stringWithFormat:@"%02ld",(long)min];
    _secondLab.text = [NSString stringWithFormat:@"%02ld",(long)second];
    
    
}


@end
