//
//  JNSHImgUploadCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/11.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UpLoadImgBlock)(void);

@interface JNSHImgUploadCell : UITableViewCell


@property(nonatomic,strong)UILabel *leftLab;

@property(nonatomic,strong)UILabel *rightLab;

@property(nonatomic,strong)UIImageView *leftImg;

@property(nonatomic,strong)UIImageView *rightImg;

@property(nonatomic,copy)UpLoadImgBlock uploadImgBlock;

@end
