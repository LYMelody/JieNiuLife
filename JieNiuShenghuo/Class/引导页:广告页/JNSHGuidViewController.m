//
//  JNSHGuidViewController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/9/12.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHGuidViewController.h"
#import "Masonry.h"
#import "JNSHMainBarController.h"
@interface JNSHGuidViewController ()<UIScrollViewDelegate>

@end

@implementation JNSHGuidViewController {
    
    UIPageControl *pageControl;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    //scorllView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    scrollView.contentSize = CGSizeMake(KscreenWidth*3, KscreenHeight);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(KscreenWidth*i, 0, KscreenWidth, KscreenHeight)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"引导页%d",i+1]];
        [scrollView addSubview:imageView];
        
        if (i == 2) {
            //添加按钮
            imageView.userInteractionEnabled = YES;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btn setTitle:@"立即开启" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            btn.backgroundColor = [UIColor redColor];
            btn.layer.cornerRadius = 3;
            btn.layer.masksToBounds = YES;
            [btn addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(imageView).offset(KscreenHeight*9/16);
                make.centerX.equalTo(imageView);
                make.size.mas_equalTo(CGSizeMake(KscreenWidth/2, [JNSHAutoSize height:35]));
            }];
            
        }
    }
    
    //pageControl
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(KscreenWidth/3, KscreenHeight*9/16, KscreenWidth/3, KscreenHeight/16)];
    pageControl.numberOfPages = 3;
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    
    [self.view addSubview:pageControl];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float x = scrollView.contentOffset.x;
    
    
    if (x < 0) {
        scrollView.contentOffset = CGPointMake(0, 0);
    }else if (x > KscreenWidth*2) {
        scrollView.contentOffset = CGPointMake(KscreenWidth*2, 0);
    }
    
    NSInteger currentIndex = scrollView.contentOffset.x / KscreenWidth;
    //计算当前第几页
    pageControl.currentPage = currentIndex;
    //到第三页的中间消失
    if (x > KscreenWidth*1.7) {
        pageControl.hidden = YES;
    }else {
        pageControl.hidden = NO;
    }
    
    
}

//进入首页
- (void)open{
    
    self.view.window.rootViewController = [[JNSHMainBarController alloc] init];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
