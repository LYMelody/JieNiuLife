//
//  JNSYAccountMessageViewController.h
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/5/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeHeaderImgViewBlock)(void);

@interface JNSYAccountMessageViewController : UIViewController
@property (nonatomic, strong)UIImage *HeaderImg;
@property (nonatomic, copy)ChangeHeaderImgViewBlock changeHeaderImgBlock;
@end
