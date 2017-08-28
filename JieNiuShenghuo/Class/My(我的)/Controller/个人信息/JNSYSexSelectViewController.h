//
//  JNSYSexSelectViewController.h
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/5/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeSexBlock)(void);

@interface JNSYSexSelectViewController : UIViewController

@property(nonatomic,copy)ChangeSexBlock ChangeSexBlock;


@end
