//
//  JNSHReallNameController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/11.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHReallNameController.h"
#import "JNSHLabFldCell.h"
#import "JNSHTitleCell.h"
#import "JNSHBrandCell.h"
#import "JNSHImgUploadCell.h"
#import "JNSHCommonButton.h"
#import "Masonry.h"
#import "JNSHAlertView.h"
#import "LSActionSheet.h"
#import "MBProgressHUD.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "JNSHAutoSize.h"
#import "JNSYUserInfo.h"
#import "GTMBase64.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"

@interface JNSHReallNameController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@end

@implementation JNSHReallNameController{
    
    NSInteger currentIndex;
    UITableView *table;
    NSString *name;
    NSString *IDCard;
    NSString *historyCard;
    
    NSString *CertFaceHttp;
    NSString *CertBackHttp;
    NSString *HoldCertHttp;
    
    JNSHLabFldCell *NameCell;
    JNSHLabFldCell *CertCell;
    
    UILabel *leftLab;
    UIButton *editBtn;
    BOOL CanEdit;
    UIImageView *headerView;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"实名认证";
    self.view.backgroundColor = ColorTableBackColor;
    
    self.navBarBgAlpha = @"1.0";
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight-64)];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator = NO;
    [self.view addSubview:table];
    
    //tablefootView
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:100])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    JNSHCommonButton *CommitBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:17], (KscreenWidth - [JNSHAutoSize width:30]), [JNSHAutoSize height:41])];
    [CommitBtn addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    [CommitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [footView addSubview:CommitBtn];
    
    table.tableFooterView = footView;
    
    //tableheaderView
    
    headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:44])];
    headerView.backgroundColor = ColorTableBackColor;
    headerView.userInteractionEnabled = YES;
    
    leftLab = [[UILabel alloc] init];
    leftLab.font = [UIFont systemFontOfSize:13];
    leftLab.textAlignment = NSTextAlignmentLeft;
    leftLab.textColor = BlueColor;
    //leftLab.backgroundColor = [UIColor redColor];
    [headerView addSubview:leftLab];
    
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake(KscreenWidth-[JNSHAutoSize width:15], [JNSHAutoSize height:20]));
    }];
    
    editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setTitle:@"编辑资料" forState:UIControlStateNormal];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editBtn setBackgroundColor:ColorTabBarBackColor];
    editBtn.layer.cornerRadius = 3;
    editBtn.layer.masksToBounds = YES;
    editBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [headerView addSubview:editBtn];
    
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).offset(-[JNSHAutoSize width:26]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:70], [JNSHAutoSize height:23]));
    }];

    table.tableHeaderView = headerView;
    
    table.tableHeaderView.hidden = YES;
    
    CanEdit = YES;
    
    //获取实名认证信息
    [self getRealNameInfo];
    
}

//获取实名认证信息
- (void)getRealNameInfo {
    
    NSDictionary *dic = @{
                          @"timestamp":[JNSHAutoSize getTimeNow]
                          };
    NSString *action = @"UserRealInfoState";
    
    NSDictionary *requstDic = @{
                                @"action":action,
                                @"data":dic,
                                @"token":[JNSYUserInfo getUserInfo].userToken
                                };
    
    NSString *params = [requstDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:params success:^(id result) {
        
        NSDictionary *resultdic = [result JSONValue];
        NSString *code = resultdic[@"code"];
        NSLog(@"%@",resultdic);
        NSString *msg = resultdic[@"msg"];
        if ([code isEqualToString:@"000000"]) {
            
            NSString *showMsg = resultdic[@"showMsg"];
            NSString *isEdit = [NSString stringWithFormat:@"%@",resultdic[@"isEdit"]];
            NSString *userAccount = resultdic[@"userAccount"];
            NSString *userCert = resultdic[@"userCert"];
            //设置用户姓名
            if (![userAccount isEqualToString:@""]) {
                name = userAccount;
            }
            //设置用户身份证
            if (![userCert isEqualToString:@""]) {
                historyCard = userCert;
                IDCard = [userCert stringByReplacingCharactersInRange:NSMakeRange(6, 8) withString:@"********"];
            }
            
            //设置实名认证图片
            CertFaceHttp = resultdic[@"pic1"];
            CertBackHttp = resultdic[@"pic2"];
            HoldCertHttp = resultdic[@"pic3"];
            [table reloadData];
            
            //设置实名认证状态
            if (![showMsg isEqualToString:@""]) {
                table.tableHeaderView.hidden = NO;
                leftLab.text = showMsg;
                if ([showMsg isEqualToString:@"未通过"]) {
                    editBtn.hidden = NO;
                }else {
                    editBtn.hidden = YES;
                }
                if ([showMsg isEqualToString:@"您的实名认证信息已通过"]) {
                    leftLab.textColor = GreenColor;
                }else if ([showMsg isEqualToString:@""]) {
                    
                }
            }else {
                
                table.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
                
            }
            
            //设置是否可以编辑
            if ([isEdit isEqualToString:@"0"]) { //不能编辑
                
                CanEdit = NO;
                
                table.tableFooterView.hidden = YES;
               
                
            }else {
                CanEdit = YES;
                table.tableFooterView.hidden = NO;
                
            }
           
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

//提交实名认证
- (void)commit {
    
    NSLog(@"提交");
    
    
    JNSHAlertView *alertView = [[JNSHAlertView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    __block typeof(JNSHAlertView) *alert = alertView;
    alertView.sureAlertBlock = ^{
        
        [alert dismiss];
    };
    
    NSString *msg = @"";
    
    if ([NameCell.textFiled.text isEqualToString:@""]) {
        msg = @"姓名为空!";
        [alertView show:msg inView:self.view];
        return;
    }else if ([CertCell.textFiled.text isEqualToString:@""]) {
        msg = @"身份证为空!";
        [alertView show:msg inView:self.view];
        return;
    }else if ([CertFaceHttp isEqualToString:@""] || CertFaceHttp == nil) {
        msg =  @"身份证正面照为空!";
        [alertView show:msg inView:self.view];
        return;
    }else if ([CertBackHttp isEqualToString:@""] || CertBackHttp == nil) {
        msg = @"身份证背面照为空!";
        [alertView show:msg inView:self.view];
        return;
    }else if ([HoldCertHttp isEqualToString:@""] || HoldCertHttp == nil ){
        msg = @"手持身份证半身照为空!";
        [alertView show:msg inView:self.view];
        return;
    }
    
    NSDictionary *dic = @{
                          @"userAccount":NameCell.textFiled.text,
                          @"userCert":historyCard?historyCard:CertCell.textFiled.text,
                          @"pic1":CertFaceHttp,
                          @"pic2":CertBackHttp,
                          @"pic3":HoldCertHttp
                          };
    
    NSString *action = @"UserRealInfoAddState";
    
    NSDictionary *requestDic = @{
                                 @"action":action,
                                 @"data":dic,
                                 @"token":[JNSYUserInfo getUserInfo].userToken
                                 };
    NSString *paramas = [requestDic JSONFragment];
    
    [IBHttpTool postWithURL:JNSHTestUrl params:paramas success:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *dic = [result JSONValue];
        NSString *code = dic[@"code"];
        
        if ([code isEqualToString:@"000000"]) {
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"提交成功!";
            [hud hide:YES afterDelay:1.5];
            [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
            //[self UpdateUserPicHeader:httpPath];
            
        }else {
            NSString *msg = dic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
      
    }];
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#define mark textfiledDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 100) {
        name = textField.text;
    }else if (textField.tag == 101) {
        IDCard = textField.text;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 101) {
        if (range.location > 17) {
            return NO;
        }
    }
    
    return YES;
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    historyCard = nil;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    __weak typeof(self) weakSelf = self;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        
        if (indexPath.row == 0) {
            NameCell = [[JNSHLabFldCell alloc] init];
            NameCell.leftLab.text = @"姓       名";
            NameCell.textFiled.placeholder = @"请输入姓名";
            NameCell.textFiled.delegate = self;
            NameCell.textFiled.text = name;
            NameCell.textFiled.tag = 100;
            cell = NameCell;
        }else if (indexPath.row == 1) {
            CertCell = [[JNSHLabFldCell alloc] init];
            CertCell.leftLab.text = @"身份证号";
            CertCell.textFiled.placeholder = @"请输入身份证号";
            CertCell.textFiled.delegate = self;
            CertCell.textFiled.text = IDCard;
            CertCell.textFiled.tag = 101;
            cell = CertCell;
        }else if (indexPath.row == 2) {
            
            JNSHBrandCell *Cell = [[JNSHBrandCell alloc] init];
            Cell.leftLab.text = @"请按提示上传资料进行认证";
            cell = Cell;
           
        }else if (indexPath.row == 3) {
            JNSHImgUploadCell *Cell = [[JNSHImgUploadCell alloc] init];
            Cell.leftLab.text = @"身份证正面照";
            if (![CertFaceHttp isEqualToString:@""]) {
                [Cell.leftImg sd_setImageWithURL:[NSURL URLWithString:CertFaceHttp]];
            }
            Cell.uploadImgBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf selectImg:indexPath];
            };
            //身份证正面照
            Cell.rightImg.image = [UIImage imageNamed:@"微信图片_20170918154807-拷贝"];
            cell = Cell;
        }else if (indexPath.row == 4) {
            JNSHImgUploadCell *Cell = [[JNSHImgUploadCell alloc] init];
            Cell.leftLab.text = @"身份证背面照";
            if (![CertBackHttp isEqualToString:@""]) {
                [Cell.leftImg sd_setImageWithURL:[NSURL URLWithString:CertBackHttp]];
            }
            Cell.uploadImgBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf selectImg:indexPath];
            };
            Cell.rightImg.image = [UIImage imageNamed:@"微信图片_20170918154807"];
            cell = Cell;
        }else if (indexPath.row == 5) {
            JNSHImgUploadCell *Cell = [[JNSHImgUploadCell alloc] init];
            Cell.leftLab.text = @"手持身份证半身照";
            if (![HoldCertHttp isEqualToString:@""]) {
                [Cell.leftImg sd_setImageWithURL:[NSURL URLWithString:HoldCertHttp]];
            }
            Cell.uploadImgBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf selectImg:indexPath];
            };
            Cell.rightImg.image = [UIImage imageNamed:@"矩形-3"];
            cell = Cell;
        }else if (indexPath.row == 6) {
            cell.backgroundColor = [UIColor whiteColor];
        }
        
    }
    
    if (!CanEdit) {
        cell.userInteractionEnabled = NO;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.row > 2) && (indexPath.row < 6)) {
        return [JNSHAutoSize height:131];
    }else if (indexPath.row == 6) {
        return 15;
    }
    
    return 41;
    
}

//打开照相机或者相册
- (void)selectImg:(NSIndexPath *)index {
    
    currentIndex = index.row;
    
    [LSActionSheet showWithTitle:nil destructiveTitle:nil otherTitles:@[@"拍照",] block:^(int index) {
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
//            NSLog(@"从相册中选择");
//            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//                sourcetype = UIImagePickerControllerSourceTypePhotoLibrary;
//            }else {
//                [self alert:@"对不起，您的相册不可用"];
//            }
            return;
        }else {
            return;
        }
        
        UIImagePickerController *Picker = [[UIImagePickerController alloc] init];
        Picker.sourceType = sourcetype;
        Picker.delegate = self;
        //Picker.allowsEditing = YES;
        
        [self.navigationController presentViewController:Picker animated:YES completion:nil];
        
    }];

}

//图片选择方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    CGSize size = image.size;
    if (size.width > 1024) {
        size = CGSizeMake(size.width/4, size.height/4);
    }
    
    UIImage *newImage = [self imageWithImage:image scaledToSize:size];
    
    NSData *imgdata =  UIImageJPEGRepresentation(newImage, 1.0);
    NSData *originalData = UIImageJPEGRepresentation(image, 1.0);
    NSLog(@"图片大小:%ld,%ld,图片尺寸:%f,%f",(unsigned long)originalData.length,(unsigned long)imgdata.length,newImage.size.width,newImage.size.height);
    
    NSString *encodedImagStr = [GTMBase64 stringByEncodingData:imgdata];
    
    NSString *imageBase64 = [NSString stringWithFormat:@"%@%@",@"data:image/png;base64,",encodedImagStr];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
    JNSHImgUploadCell *Cell = [table cellForRowAtIndexPath:indexPath];
    Cell.leftImg.image = image;
    
    NSString *type = @"";
    if (currentIndex == 3) {
        type = @"CertFace";
    }else if (currentIndex == 4) {
        type = @"CertBack";
    }else if (currentIndex == 5) {
        type = @"CardFace";
    }
    
    [self uploadImg:imageBase64 type:type];
    
    //pop
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImg;
    
}

//上传图片
- (void)uploadImg:(NSString *)fileBase64 type:(NSString *)type {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // HUD.label.text = @"正在上传头像";
    HUD.labelText = @"正在上传图片";
    NSDictionary *Dic = @{
                          //@"timestamp":[JNSYAutoSize getTimeNow],
                          @"fileBase64":fileBase64,
                          @"type":type
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
            
            if ([type isEqualToString:@"CertFace"]) {
                CertFaceHttp = httpPath;
            }else if ([type isEqualToString:@"CertBack"]) {
                CertBackHttp = httpPath;
            }else if([type isEqualToString:@"CardFace"]) {
                HoldCertHttp = httpPath;
            }
            //去掉hud
            [HUD hide:YES];
            //换成text的提示
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"上传成功";
            [hud hide:YES afterDelay:1];
            
            //[self UpdateUserPicHeader:httpPath];
            
        }else {
            [HUD hide:YES];
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


@end
