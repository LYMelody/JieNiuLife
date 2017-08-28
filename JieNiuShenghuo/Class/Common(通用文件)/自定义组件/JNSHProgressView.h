//
//  JNSHProgressView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/3.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHProgressView : UIImageView

@property(nonatomic,strong)UIImageView *trackView;

@property(nonatomic,strong)UIImageView *progressView;

@property(nonatomic,assign)float progress;

@end
