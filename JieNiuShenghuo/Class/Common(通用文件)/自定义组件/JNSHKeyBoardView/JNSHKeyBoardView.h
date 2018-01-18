//
//  JNSHKeyBoardView.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/12/20.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ItemSelectBlock)(NSInteger selectTag,NSString *title);

@interface JNSHKeyBoardView : UIView

@property(nonatomic,strong)UIView *contentView;

@property(nonatomic,copy)ItemSelectBlock itemSelectBlock;

@property(nonatomic,assign)BOOL IsShowed;

- (void)showInView:(UIView *)view;

- (void)dismiss;

@end
