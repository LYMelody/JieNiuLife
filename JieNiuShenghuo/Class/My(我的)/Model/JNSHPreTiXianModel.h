//
//  JNSHPreTiXianModel.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/12/14.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNSHPreTiXianModel : NSObject

@property(nonatomic,assign)float totalAmount;  //提现总额

@property(nonatomic,assign)float rateTax;     //开票税费

@property(nonatomic,assign)float ratefree;         //提现费

@property(nonatomic,assign)float settleReal; //到账金额

@end
