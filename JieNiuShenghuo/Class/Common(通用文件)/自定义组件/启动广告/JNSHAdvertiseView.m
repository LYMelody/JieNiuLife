//
//  JNSHAdvertiseView.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/26.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHAdvertiseView.h"
#import "Masonry.h"
#import "JNSHUpdateView.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "PgyUpdateManager.h"
@interface JNSHAdvertiseView()

@property(nonatomic,strong)UIImageView *adView;

@property(nonatomic,strong)UIButton *slipBtn;

@property(nonatomic,strong)NSTimer *countTimer;

@property(nonatomic,assign) NSInteger count;

@property(nonatomic,strong)UILabel *leftLab;



@end

//static int const showtime = 5;


@implementation JNSHAdvertiseView {
    
    UITapGestureRecognizer *slipTap;
    
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ([super initWithFrame:frame]) {
        
        //创建广告视图
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAD)];
        tap.numberOfTapsRequired = 1;
        //去掉手势
        [_adView addGestureRecognizer:tap];
        [self addSubview:_adView];
        //跳转按钮
        
        UIImageView *backBtnImg = [[UIImageView alloc] init];
        backBtnImg.image = [UIImage imageNamed:@"Advertising-page_btn"];
        backBtnImg.userInteractionEnabled = YES;
        backBtnImg.layer.masksToBounds = YES;
        
        slipTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        slipTap.numberOfTouchesRequired = 1;
        [backBtnImg addGestureRecognizer:slipTap];
        [self addSubview:backBtnImg];
        
        [backBtnImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-[JNSHAutoSize width:10]);
            make.bottom.equalTo(self).offset(-[JNSHAutoSize height:21]);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:81], [JNSHAutoSize height:27]));
        }];
        
        self.leftLab = [[UILabel alloc] init];
        self.leftLab.backgroundColor = [UIColor blackColor];
        self.leftLab.font = [UIFont fontWithName:@"ArialMT" size:20];
        self.leftLab.textAlignment = NSTextAlignmentCenter;
        self.leftLab.layer.cornerRadius = [JNSHAutoSize width:27]/2.0;
        self.leftLab.layer.masksToBounds = YES;
        self.leftLab.textColor = [UIColor whiteColor];
        
        if (self.timeduration == nil || [self.timeduration isEqualToString:@""]) {//默认5S
            self.timeduration = @"5";
            self.leftLab.text = @"5";
        }else {
            self.leftLab.text = self.timeduration;
        }
    
        [backBtnImg addSubview:self.leftLab];
        
        [self.leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(backBtnImg);
            make.left.equalTo(backBtnImg);
            make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:27], [JNSHAutoSize width:27]));
        }];
        
        UILabel *rightLab = [[UILabel alloc] init];
        rightLab.text = @"跳过>>";
        rightLab.textAlignment = NSTextAlignmentCenter;
        rightLab.font = [UIFont systemFontOfSize:14];
        rightLab.textColor = [UIColor whiteColor];
        rightLab.adjustsFontSizeToFitWidth = YES;
        [backBtnImg addSubview:rightLab];
        
        [rightLab  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(backBtnImg);
            make.left.equalTo(self.leftLab.mas_right).offset([JNSHAutoSize width:2]);
            make.right.equalTo(backBtnImg).offset(-[JNSHAutoSize width:2]);
            make.height.mas_equalTo([JNSHAutoSize height:40]);
        }];
        
        //_slipBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        //_slipBtn
        //[self addSubview:_slipBtn];
    
    }
    
    return self;
    
}

- (NSTimer *)countTimer {
    
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (void)countDown {
    
    _count --;
    
    if (_count < 0) {
        
        [self dismiss];
        return;
    }
    
    self.leftLab.text = [NSString stringWithFormat:@"%ld",(long)_count];
    
    //[_slipBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    
}

//点击图片跳转广告
- (void)pushToAD {
    
    [self dismiss];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushtoAd" object:nil];
    
}
//点击跳过按钮
- (void)dismiss {
    
    [_countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
        [self removeFromSuperview];
        //检测更新
        //[self VersionUpdate];
        
        [[PgyUpdateManager sharedPgyManager] checkUpdate];
        
    }];
    
}

- (void)startTimer {
    
    _count = [self.timeduration integerValue];
    
    self.leftLab.text = self.timeduration;
    
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
    
    
}

//展示广告
- (void)show {
    
    [self startTimer];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
}

- (void)setFilePath:(NSString *)filePath {
    
    _filePath = filePath;
    
    _adView.image = [UIImage imageWithContentsOfFile:filePath];
    
}

//版本检测
- (void)VersionUpdate {
    
    NSDictionary *dic = @{
                          @"os":@"IOS"
                          };
    NSString *action = @"AppVersionState";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"token":TOKEN,
                                 @"data":dic
                                 };
    NSString *params = [requestDic JSONFragment];
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        NSDictionary *resultDic = [params JSONValue];
        NSLog(@"%@",resultDic);
        
        JNSHUpdateView *updateView = [[JNSHUpdateView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        [updateView show:@"" message:@"" inView:[UIApplication sharedApplication].keyWindow];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)setJumpflag:(NSString *)jumpflag {
    
    _jumpflag = jumpflag;
    //判断手势
    if ([jumpflag isEqualToString:@"0"]) {
        slipTap.enabled = NO;
    }else {
        slipTap.enabled = YES;
    }
    
    
}


@end
