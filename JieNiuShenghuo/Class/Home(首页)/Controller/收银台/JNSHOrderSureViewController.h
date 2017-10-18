//
//  JNSHOrderSureViewController.h
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/22.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNSHOrderSureViewController : UIViewController

@property(nonatomic,copy)NSString *orderNo;                 //消费订单

@property(nonatomic,copy)NSString *orderTime;               //订单时间

@property(nonatomic,copy)NSString *amount;                  //订单金额

@property(nonatomic,strong)NSArray *bindCards;              //绑卡

@property(nonatomic,copy)NSString *rateFee;                 //实际手续费

@property(nonatomic,copy)NSString *rateNormalFee;           //普通商户手续费

@property(nonatomic,copy)NSString *rateNormalFeeValue;      //普通费率信息

@property(nonatomic,copy)NSString *rateVipFee;              //vip商户手续费

@property(nonatomic,copy)NSString *rateVipFeeVale;          //VIP费信息

@property(nonatomic,copy)NSString *voucheersFlag;           //抵扣券有无

@property(nonatomic,copy)NSString *vouchersPrice;           //抵扣券金额

@property(nonatomic,copy)NSString *settleReal;              //实际手续费

@property(nonatomic,copy)NSString *vipDiscount;             //会员(/可)优惠

@property(nonatomic,copy)NSString *vipFlag;                 //会员状态

@property(nonatomic,assign)NSInteger typeTag;               //区别银联支付（2：银联通道；其他：正常通道）


@end
