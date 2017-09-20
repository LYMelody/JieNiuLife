//
//  JNSHOrderModel.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/19.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNSHOrderModel : NSObject


@property(nonatomic,copy)NSString *orderPrice;    //订单金额

@property(nonatomic,copy)NSString *orderStatus;   //订单状态

@property(nonatomic,copy)NSString *product;       //产品名称

@property(nonatomic,copy)NSString *cardBank;      //交易银行

@property(nonatomic,copy)NSString *cardNo;        //交易账户

@property(nonatomic,copy)NSString *orderNo;       //订单编号

@property(nonatomic,copy)NSString *orderReqTime;  //订单交易时间


@end
