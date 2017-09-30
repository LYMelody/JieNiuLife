//
//  JNSYUserInfo.h
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/6/28.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JNSYUserInfo : NSObject

@property(nonatomic,assign)BOOL isLoggedIn;    //是否登录

@property(nonatomic,copy)NSString *shopStates;  //商户状态

@property(nonatomic,copy)NSString *userCode;   //用户编码

@property(nonatomic,copy)NSString *userKey;    //用户授权秘钥

@property(nonatomic,copy)NSString *userName;    //用户名

@property(nonatomic,copy)NSString *userNick;    //用户昵称

@property(nonatomic,copy)NSString *userPhone;   //用户手机

@property(nonatomic,copy)NSString *userToken;   //用户授权码

@property(nonatomic,copy)NSString *noticeFlg;   //系统公告

@property(nonatomic,copy)NSString *noticeTitle; //公告标题

@property(nonatomic,copy)NSString *noticeText;   //公告详情

@property(nonatomic,copy)NSString *userAccount;   //用户姓名、实名认证账户

@property(nonatomic,copy)NSString *userCert;       //用户身份证、实名认证身份证

@property(nonatomic,copy)NSString *userSex;        //用户性别

@property(nonatomic,copy)NSString *birthday;       //用户生日

@property(nonatomic,copy)NSString *picHeader;      //用户头像

@property(nonatomic,copy)NSString *lastIp;          //最后登录IP

@property(nonatomic,copy)NSString *lastTime;        //最后时间

@property(nonatomic,copy)NSString *headerPicHttpPath;  //头像地址

@property(nonatomic,assign)BOOL isSetPayPwd;            //是否设置支付密码

@property(nonatomic,copy)NSString *userPoints;           //用户积分

@property(nonatomic,copy)NSString *branderCardFlg;        //是否绑定会员卡

@property(nonatomic,copy)NSString *branderCardNo;          //绑定会员卡

@property(nonatomic,copy)NSString *userVipFlag;         //用户是否为会员

@property(nonatomic,copy)NSString *vipExpireDay;       //会员过期日

@property(nonatomic,copy)NSString *SettleCard;         //结算卡

@property(nonatomic,copy)NSString *userStatus;        //实名认证状态

@property(nonatomic,copy)NSString *userQr;            //注册二维码

+ (JNSYUserInfo *)getUserInfo;

@end
