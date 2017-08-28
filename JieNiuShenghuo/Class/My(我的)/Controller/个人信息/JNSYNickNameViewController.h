//
//  JNSYNickNameViewController.h
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/5/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeNickNameBlock)(void);


@interface JNSYNickNameViewController : UIViewController

@property (nonatomic, copy)ChangeNickNameBlock changeNickBlock;

@end
