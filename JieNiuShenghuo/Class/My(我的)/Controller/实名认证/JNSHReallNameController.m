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
@interface JNSHReallNameController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>

@end

@implementation JNSHReallNameController{
    
    NSInteger currentIndex;
    UITableView *table;
    NSString *name;
    NSString *IDCard;
    
    NSString *CertFaceHttp;
    NSString *CertBackHttp;
    NSString *HoldCertHttp;
    
    JNSHLabFldCell *NameCell;
    JNSHLabFldCell *CertCell;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"实名认证";
    self.view.backgroundColor = ColorTableBackColor;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    backImg.backgroundColor = ColorTabBarBackColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight -64 )];
    table.dataSource = self;
    table.delegate = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:44])];
    headerView.backgroundColor = ColorTableBackColor;
    headerView.userInteractionEnabled = YES;
    
    UILabel *leftLab = [[UILabel alloc] init];
    leftLab.font = [UIFont systemFontOfSize:15];
    leftLab.textAlignment = NSTextAlignmentLeft;
    leftLab.text = @"未通过";
    [headerView addSubview:leftLab];
    
    [leftLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).offset([JNSHAutoSize width:15]);
        make.size.mas_equalTo(CGSizeMake([JNSHAutoSize width:100], [JNSHAutoSize height:20]));
    }];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
}

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
                          @"userCert":CertCell.textFiled.text,
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
            
            
            [JNSHAutoSize showMsg:@"成功提交!"];
        
            
            //[self UpdateUserPicHeader:httpPath];
            
        }else {
            NSString *msg = dic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
      
    }];
    
    
    
}

#define mark textfiledDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 100) {
        name = textField.text;
    }else if (textField.tag == 101) {
        IDCard = textField.text;
    }
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
            if (CertFaceHttp) {
                [Cell.leftImg sd_setImageWithURL:[NSURL URLWithString:CertFaceHttp]];
            }
            Cell.uploadImgBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf selectImg:indexPath];
            };
            cell = Cell;
        }else if (indexPath.row == 4) {
            JNSHImgUploadCell *Cell = [[JNSHImgUploadCell alloc] init];
            Cell.leftLab.text = @"身份证背面照";
            if (CertBackHttp) {
                [Cell.leftImg sd_setImageWithURL:[NSURL URLWithString:CertBackHttp]];
            }
            Cell.uploadImgBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf selectImg:indexPath];
            };
            cell = Cell;
        }else if (indexPath.row == 5) {
            JNSHImgUploadCell *Cell = [[JNSHImgUploadCell alloc] init];
            Cell.leftLab.text = @"手持身份证半身照";
            if (HoldCertHttp) {
                [Cell.leftImg sd_setImageWithURL:[NSURL URLWithString:HoldCertHttp]];
            }
            Cell.uploadImgBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                [strongSelf selectImg:indexPath];
            };
            cell = Cell;
        }else if (indexPath.row == 6) {
            cell.backgroundColor = [UIColor whiteColor];
        }
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((indexPath.row > 2) && (indexPath.row < 6)) {
        return 131;
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
            NSLog(@"从相册中选择");
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                sourcetype = UIImagePickerControllerSourceTypePhotoLibrary;
            }else {
                [self alert:@"对不起，您的相册不可用"];
            }
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
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    NSData *imgdata = UIImagePNGRepresentation(image);
    
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
            
            //[self UpdateUserPicHeader:httpPath];
            
        }else {
            NSString *msg = dic[@"msg"];
            [JNSHAutoSize showMsg:msg];
        }
        
        [HUD hide:YES];
        
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
