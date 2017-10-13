//
//  JNSHAgentmsgCell.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/10/10.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHAgentmsgCell : UITableViewCell

@property(nonatomic,strong)UIImageView *headimg;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,assign)BOOL isRead;

@end
