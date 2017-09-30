//
//  JNSHSettlementCardController.m
//  JieNiuShenghuo
//
//  Created by rongfeng on 2017/8/14.
//  Copyright © 2017年 China Zhou. All rights reserved.
//

#import "JNSHSettlementCardController.h"
#import "JNSHLabFldCell.h"
#import "JNSHImgUploadCell.h"
#import "JNSHCommonButton.h"
#import "JNSHPopBankCardView.h"
#import "JNSHSubBankController.h"
#import "LSActionSheet.h"
#import "JNSHAlertView.h"
#import "JNSHAutoSize.h"
#import "JNSYUserInfo.h"
#import "SBJSON.h"
#import "IBHttpTool.h"
#import "MBProgressHUD.h"
#import "GTMBase64.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+Cloudox.h"
#import "UINavigationController+Cloudox.h"

@interface JNSHSettlementCardController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,copy)NSString *currentBank;

@end

@implementation JNSHSettlementCardController {
    
    NSString *name;
    NSString *cardNum;
    UITableView *table;
    JNSHLabFldCell *NameCell;
    JNSHLabFldCell *CardCell;
    NSString *cardHttp;
   
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"添加结算卡";
    self.navBarBgAlpha = @"1.0";
    self.view.backgroundColor = ColorTableBackColor;
    
    [table reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = ColorTableBackColor;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];
    
    //头视图
    UIImageView *HeaderView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:44])];
    HeaderView.backgroundColor = ColorTableBackColor;
    
    UILabel *headerLab = [[UILabel alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:10], KscreenWidth, [JNSHAutoSize height:20])];
    headerLab.text = @"请添加本人的储蓄卡";
    headerLab.font = [UIFont systemFontOfSize:15];
    headerLab.textColor = ColorText;
    headerLab.textAlignment = NSTextAlignmentLeft;
    [HeaderView addSubview:headerLab];
    
    table.tableHeaderView = HeaderView;
    
    //底部视图
    UIImageView *footView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, [JNSHAutoSize height:80])];
    footView.backgroundColor = ColorTableBackColor;
    footView.userInteractionEnabled = YES;
    
    JNSHCommonButton *bindBtn = [[JNSHCommonButton alloc] initWithFrame:CGRectMake([JNSHAutoSize width:15], [JNSHAutoSize height:40],(KscreenWidth - [JNSHAutoSize width:15]*2) , [JNSHAutoSize height:41])];
    [bindBtn setTitle:@"绑定" forState:UIControlStateNormal];
    [bindBtn addTarget:self action:@selector(bind) forControlEvents:UIControlEventTouchUpInside];
    
    [footView addSubview:bindBtn];
    
    table.tableFooterView = footView;
    
    //禁止滑动延迟
    table.delaysContentTouches = NO;
    for(id view in table.subviews) {
        
        if ([NSStringFromClass([view class]) isEqualToString:@"UITableViewWrapperView"]) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrrowView = (UIScrollView *)view;
                scrrowView.delaysContentTouches = NO;
            }
            break;
        }
    }
    
    //初始化银行
   self.currentBank = @"102";
   self.bankName = @"中国工商银行";
}

//绑定
- (void)bind {
    
    NSLog(@"绑定");
    
    JNSHAlertView *alertView = [[JNSHAlertView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    __block typeof(JNSHAlertView) *alert = alertView;
    alertView.sureAlertBlock = ^{
        [alert dismiss];
    };
    NSString *msg = @"";
    
    //NSLog(@"subbankcode:%@",self.subBankCode);
    
    if ([NameCell.textFiled.text isEqualToString:@""]) {
        msg = @"手机号为空!";
        [alertView show:msg inView:self.view];
        return;
    }else if(NameCell.textFiled.text.length != 11) {
        
    }
    else if ([CardCell.textFiled.text isEqualToString:@""]){
        msg = @"卡号为空!";
        [alertView show:msg inView:self.view];
        return;
    }else if (self.subBankCode == nil) {
        msg = @"请选择支行信息";
        [alertView show:msg inView:self.view];
        return;
    }else if (cardHttp == nil ) {
        msg = @"请上传银行卡正面照";
        [alertView show:msg inView:self.view];
        return;
    }
    
    NSDictionary *dic = @{
                          @"cardNo":CardCell.textFiled.text,
                          @"cardCode":self.subBankCode,
                          @"cardPhone":NameCell.textFiled.text,
                          @"cardPic":cardHttp
                          };
    NSString *action = @"UserSettleCardBindState";
    
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
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"信息已提交!";
            [hud hide:YES afterDelay:1.5];
            [self performSelector:@selector(back) withObject:nil afterDelay:1.5];
            
        }else {
            
            [JNSHAutoSize showMsg:msg];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"identy";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        if (indexPath.row == 0) {
            NameCell = [[JNSHLabFldCell alloc] init];
            NameCell.leftLab.text = @"手 机 号";
            NameCell.textFiled.placeholder = @"请输入预留手机号";
            NameCell.textFiled.clearButtonMode = UITextFieldViewModeAlways;
            NameCell.textFiled.delegate = self;
            NameCell.textFiled.tag = 100;
            NameCell.textFiled.text = name;
            NameCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            cell = NameCell;
        }else if (indexPath.row == 1) {
            CardCell = [[JNSHLabFldCell alloc] init];
            CardCell.leftLab.text = @"卡      号";
            CardCell.textFiled.placeholder = @"请输入卡号";
            CardCell.textFiled.clearButtonMode = UITextFieldViewModeAlways;
            CardCell.textFiled.delegate = self;
            CardCell.textFiled.tag = 101;
            CardCell.textFiled.text = cardNum;
            CardCell.textFiled.keyboardType = UIKeyboardTypeNumberPad;
            cell = CardCell;
        }else if (indexPath.row == 2) {
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"选择银行";
            Cell.textFiled.enabled = NO;
            Cell.textFiled.text = self.bankName;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 3) {
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"选择支行";
            Cell.textFiled.enabled = NO;
            Cell.textFiled.text = self.subBank;
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if(indexPath.row == 4) {
            cell.backgroundColor = ColorTableBackColor;
        }else if(indexPath.row == 5) {
            JNSHImgUploadCell *Cell = [[JNSHImgUploadCell alloc] init];
            __weak typeof(self) weakSelf = self;
            Cell.uploadImgBlock = ^{
                __strong typeof(self) strongSelf = weakSelf;
                
                [strongSelf pickImage];
            };
            Cell.leftLab.text = @"请上传储蓄卡正面照";
            Cell.rightImg.image = [UIImage imageNamed:@"card_example"];
            cell = Cell;
        }else if (indexPath.row == 6) {
            cell.backgroundColor = [UIColor whiteColor];
        }
    }
    //取消点击效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)pickImage {
    
    [LSActionSheet showWithTitle:nil destructiveTitle:nil otherTitles:@[@"拍照"] block:^(int index) {
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
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
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    JNSHImgUploadCell *Cell = [table cellForRowAtIndexPath:indexPath];
    Cell.leftImg.image = image;
    
    [self uploadImg:imageBase64 type:@"Other"];
    
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
            
            cardHttp = dic[@"httpPath"];
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
            
            JNSHImgUploadCell *Cell = [table cellForRowAtIndexPath:indexPath];
            
            [Cell.leftImg sd_setImageWithURL:[NSURL URLWithString:cardHttp]];
            
            [HUD hide:YES];
            
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"上传成功!";
            [hud hide:YES afterDelay:1];
            
            
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) {
        return 15;
    }else if (indexPath.row == 5) {
        return [JNSHAutoSize height:131];
    }else if (indexPath.row == 6) {
        return 10;
    }
    
    return 41;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) { //选择银行
        
        [NameCell.textFiled resignFirstResponder];
        [CardCell.textFiled resignFirstResponder];
        
        NSLog(@"选择银行");
        JNSHPopBankCardView *CardView = [[JNSHPopBankCardView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        CardView.typetag = 2;
        __weak typeof(self) weakSelf = self;
        
        CardView.bankselectBlock = ^(NSString *bankName, NSString *bankCode) {
            __strong typeof(self) strongSelf = weakSelf;
            JNSHLabFldCell *Cell = [tableView cellForRowAtIndexPath:indexPath];
            Cell.textFiled.text = bankName;
            strongSelf.currentBank = bankCode;
            strongSelf.bankName = bankName;
        };
        [CardView showInView:self.view];
    }else if (indexPath.row == 3) { //选择支行
        NSLog(@"选择支行");
        
        JNSHSubBankController *subBankVc = [[JNSHSubBankController alloc] init];
        subBankVc.bankName = self.currentBank;
        subBankVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:subBankVc animated:YES];
    }
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if (textField.tag == 100) {
        name = textField.text;
    }else if (textField.tag == 101) {
        cardNum = textField.text;
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.tag == 100) {   //手机号
        if (range.location > 10) {
            return NO;
        }
    }else if (textField.tag == 101) { //卡号
        if (range.location > 19) {
            return NO;
        }
    }
    return YES;
    
    
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
