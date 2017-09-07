//
//  JNSHTicketsSuccessView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/7.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WatchTicketBlock)(void);

@interface JNSHTicketsSuccessView : UIView

@property(nonatomic,copy)WatchTicketBlock watchTicksBlock;


- (void)dismiss;

- (void)showinView:(UIWindow *)view;



@end
