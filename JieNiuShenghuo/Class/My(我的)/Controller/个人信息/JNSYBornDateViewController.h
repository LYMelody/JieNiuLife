//
//  JNSYBornDateViewController.h
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/5/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeBirthBlock)(void);

@interface JNSYBornDateViewController : UIViewController

@property (nonatomic,copy)ChangeBirthBlock changeBirthBlock;

@end
