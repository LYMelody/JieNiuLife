//
//  JNSYHeaderEditorViewController.m
//  JieNiuSongYao
//
//  Created by rongfeng on 2017/5/15.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSYHeaderEditorViewController.h"
#import "JNSHCommon.h"
#import "Masonry.h"
#import "LSActionSheet.h"
#import "JNSHAutoSize.h"
#import "JNSYUserInfo.h"
#import "IBHttpTool.h"
#import "SBJSON.h"
#import "GTMBase64.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"

@interface JNSYHeaderEditorViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation JNSYHeaderEditorViewController {
    NSUserDefaults *User;
    MBProgressHUD *HUD;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"个人头像";
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    
    self.navBarBgAlpha = @"1.0";
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit"] style:UIBarButtonItemStylePlain target:self action:@selector(EditorHeaderImg)];
    
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    _HeaderImgView = [[UIImageView alloc] init];
    _HeaderImgView.backgroundColor = [UIColor clearColor];
    _HeaderImgView.contentMode = UIViewContentModeScaleAspectFit;
    _HeaderImgView.clipsToBounds = YES;
    
    
    
    if ([JNSYUserInfo getUserInfo].picHeader) {
        [_HeaderImgView sd_setImageWithURL:[NSURL URLWithString:[JNSYUserInfo getUserInfo].picHeader]];
    }else {
        _HeaderImgView.image = [UIImage imageNamed:@"my_head_portrait"];
    }
    
    [self.view addSubview:_HeaderImgView];
    
    [_HeaderImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(KscreenWidth);
    }];
    
    
}

- (void)EditorHeaderImg {
    
    
    
    [LSActionSheet showWithTitle:nil destructiveTitle:nil otherTitles:@[@"拍照",@"从手机相册选择",@"保存图片"] block:^(int index) {
        NSLog(@"-----%d",index);
        
        UIImagePickerControllerSourceType sourcetype = UIImagePickerControllerSourceTypePhotoLibrary;
        if (index == 0) {
            NSLog(@"拍照");
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                sourcetype = UIImagePickerControllerSourceTypeCamera;
            }else {
                [self alert:@"对不起，您的相机不可用"];
                return;
            }
        }else if (index == 1) {
            NSLog(@"从相册中选择");
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                sourcetype = UIImagePickerControllerSourceTypePhotoLibrary;
            }else {
                [self alert:@"对不起，您的相册不可用"];
            }
        }else if(index == 2){
           
            NSLog(@"保存图片");
            
            //保存到相册
            //UIImageWriteToSavedPhotosAlbum(_HeaderImgView.image, self, @selector(image:didFinashSavingWithError:contextInfo:), nil);
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeCustomView;
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]];
            hud.labelText = @"已保存到系统相册";
            [hud hide:YES afterDelay:1.5];
            
            return;
            
        }else {
            return;
        }
        
        UIImagePickerController *Picker = [[UIImagePickerController alloc] init];
        Picker.sourceType = sourcetype;
        Picker.delegate = self;
        Picker.allowsEditing = YES;
        
        [self.navigationController presentViewController:Picker animated:YES completion:nil];
        
    }];
    
}

- (void)image:(UIImage *)image didFinashSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    NSLog(@"%@",error);
    
}

//图片选择方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    NSData *imgdata = UIImagePNGRepresentation(image);

    NSString *encodedImagStr = [GTMBase64 stringByEncodingData:imgdata];
   
    NSString *imageBase64 = [NSString stringWithFormat:@"%@%@",@"data:image/png;base64,",encodedImagStr];
    
    //上传图片
    [self upLoadHeaderImg:imageBase64];
    
    _HeaderImgView.image = image;
    
    //pop
    [picker dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
    
}

//上传头像
- (void)UpdateUserPicHeader:(NSString *)picHeader {
    
    NSDictionary *dic = @{
                          
                          @"userNick":[JNSYUserInfo getUserInfo].userName,
                          @"picHeader":picHeader
                          };
    NSString *action = @"UserBaseDetailEditState";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"data":dic,
                                 @"token":[JNSYUserInfo getUserInfo].userToken
                                 };
    NSString *paramas = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:paramas success:^(id result) {
        NSLog(@"%@",result);
        
        //取消HUD
        [HUD hide:YES];
        //设置_HeaderImgView头像
        [_HeaderImgView sd_setImageWithURL:[NSURL URLWithString:picHeader]];
        //设置头像URL
        [JNSYUserInfo getUserInfo].picHeader = picHeader;
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [HUD hide:YES];
    }];
    
}

//上传头像图片获取图片URL
- (void)upLoadHeaderImg:(NSString *)fileBase64 {
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"正在上传头像";
    NSDictionary *Dic = @{
                          @"fileBase64":fileBase64,
                          @"type":@"Other"
                          };
    NSString *action = @"FileUploadState";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"data":Dic,
                                 @"token":[JNSYUserInfo getUserInfo].userToken
                                 };
    NSString *paramas = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:paramas success:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        
        if ([code isEqualToString:@"000000"]) {
            
            NSString *httpPath = dic[@"httpPath"];
            
            [JNSYUserInfo getUserInfo].headerPicHttpPath = httpPath;
            
            [self UpdateUserPicHeader:httpPath];
            
        }else {
            NSString *msg = dic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [HUD hide:YES];
    }];
    
}

- (void)alert:(NSString *)Msg {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:Msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
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
