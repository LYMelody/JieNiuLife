//
//  JNSHTimeCountDownView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/3.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHTimeCountDownView : UIImageView


@property(nonatomic,strong)UILabel *secondLab;

@property(nonatomic,strong)UILabel *minLab;

@property(nonatomic,strong)UILabel *hourLab;

@property(nonatomic,assign)NSInteger time;

@end
