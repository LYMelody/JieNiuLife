//
//  JNSHSubBankCell.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/14.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSubBankCell.h"
#import "JNSYHighLightImageView.h"
#import "Masonry.h"
@implementation JNSHSubBankCell

- (instancetype)init {
    
    if ([super init]) {
        
        self.titleArray = [[NSMutableArray alloc] initWithArray:@[@"正在定位...",@"上海",@"北京",@"南京",@"宁波",@"台州"]];
        
        [self setUpViews];
    }
    
    return self;
    
}


- (void)setUpViews{
    
    self.backgroundColor = ColorTableBackColor;
    
    CGFloat width = (KscreenWidth - [JNSHAutoSize width:44])/3.0;
    
    for (NSInteger i = 0; i < 2; i++) {
        
        for (NSInteger j = 0; j < 3; j++) {
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
            tap.numberOfTouchesRequired = 1;
            
            JNSYHighLightImageView *hotPlace = [[JNSYHighLightImageView alloc] init];
            hotPlace.userInteractionEnabled = YES;
            hotPlace.backgroundColor = [UIColor whiteColor];
            hotPlace.layer.cornerRadius = 2;
            hotPlace.layer.masksToBounds = YES;
            hotPlace.frame = CGRectMake([JNSHAutoSize width:15]+j*([JNSHAutoSize width:7] + width), [JNSHAutoSize height:10] + i*([JNSHAutoSize height:7] + [JNSHAutoSize height:30]), width, [JNSHAutoSize height:30]);
            [hotPlace addGestureRecognizer:tap];
            [self.contentView addSubview:hotPlace];
            
            UILabel *titlelab = [[UILabel alloc] init];
            titlelab.font = [UIFont systemFontOfSize:13];
            titlelab.textColor = ColorText;
            titlelab.textAlignment = NSTextAlignmentCenter;
            titlelab.text = _titleArray[(i*3)+j];
            [hotPlace addSubview:titlelab];
            
            [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(hotPlace);
                make.size.equalTo(hotPlace);
            }];
            
            if (i==0 && j == 0) {
                _locationImg = hotPlace;
                self.locationLab = titlelab;
                
                UIImageView *locationlogo = [[UIImageView alloc] init];
                locationlogo.image = [UIImage imageNamed:@"local"];
                
                [_locationImg addSubview:locationlogo];
                
                [locationlogo mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(_locationImg);
                    make.left.equalTo(_locationImg).offset([JNSHAutoSize width:[JNSHAutoSize width:12]]);
                    make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:12], [JNSHAutoSize height:15]));
                }];
                
            }
        }
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    
}

- (void)tap:(UITapGestureRecognizer *)sender {
    
    UIView *view = sender.view;
    
    for (NSInteger i = 0; i < view.subviews.count; i++) {
        
        if ([view.subviews[i] isKindOfClass:[UILabel class]]) {
            UILabel *lab =  view.subviews[i];
            NSLog(@"标题:%@",lab.text);
            
            if (self.citySelectBlock) {
                self.citySelectBlock(lab.text);
            }
            
            
        }
        
    }
}




@end
