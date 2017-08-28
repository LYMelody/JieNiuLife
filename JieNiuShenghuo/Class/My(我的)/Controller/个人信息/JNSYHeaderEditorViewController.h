//
//  JNSYHeaderEditorViewController.h
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/5/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChangeHeadeImgBlock)(void);


@interface JNSYHeaderEditorViewController : UIViewController

@property (nonatomic, strong)UIImageView *HeaderImgView;
@property (nonatomic, copy)ChangeHeadeImgBlock changeHeadeImgBlock;

@end
