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
@interface JNSHSettlementCardController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation JNSHSettlementCardController {
    
    NSString *name;
    NSString *cardNum;
    UITableView *table;
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.title = @"添加结算卡";
    
    self.view.backgroundColor = ColorTableBackColor;
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //返回按钮
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *backImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    backImg.backgroundColor = ColorTabBarBackColor;
    backImg.userInteractionEnabled = YES;
    [self.view addSubview:backImg];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, KscreenWidth, KscreenHeight - 64) style:UITableViewStylePlain];
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
    
}

//绑定
- (void)bind {
    
    NSLog(@"绑定");
    
    JNSHAlertView *alertView = [[JNSHAlertView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
    __block typeof(JNSHAlertView) *alert = alertView;
    alertView.sureAlertBlock = ^{
        [alert dismiss];
    };
    
    [alertView show:@"请填写银行卡完整信息!" inView:self.view];
    
    
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
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"持 卡 人";
            Cell.textFiled.placeholder = @"请输入持卡人姓名";
            Cell.textFiled.clearButtonMode = UITextFieldViewModeAlways;
            Cell.textFiled.delegate = self;
            Cell.textFiled.tag = 100;
            Cell.textFiled.text = name;
            cell = Cell;
        }else if (indexPath.row == 1) {
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"卡      号";
            Cell.textFiled.placeholder = @"请输入卡号";
            Cell.textFiled.clearButtonMode = UITextFieldViewModeAlways;
            Cell.textFiled.delegate = self;
            Cell.textFiled.tag = 101;
            Cell.textFiled.text = cardNum;
            cell = Cell;
        }else if (indexPath.row == 2) {
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"选择银行";
            Cell.textFiled.enabled = NO;
            Cell.textFiled.text = @"中国银行";
            cell = Cell;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row == 3) {
            JNSHLabFldCell *Cell = [[JNSHLabFldCell alloc] init];
            Cell.leftLab.text = @"选择支行";
            Cell.textFiled.enabled = NO;
            Cell.textFiled.text = @"城北支行";
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
    
    [LSActionSheet showWithTitle:nil destructiveTitle:nil otherTitles:@[@"拍照",@"从手机相册选择"] block:^(int index) {
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
        Picker.allowsEditing = YES;
        
        [self.navigationController presentViewController:Picker animated:YES completion:nil];
        
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    //NSData *imgdata = UIImagePNGRepresentation(image);
    
    //NSString *encodedImagStr = [GTMBase64 stringByEncodingData:imgdata];
    
    //NSString *imageBase64 = [NSString stringWithFormat:@"%@%@",@"data:image/png;base64,",encodedImagStr];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:5 inSection:0];
    JNSHImgUploadCell *Cell = [table cellForRowAtIndexPath:indexPath];
    Cell.leftImg.image = image;
    
    //pop
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 4) {
        return 15;
    }else if (indexPath.row == 5) {
        return 131;
    }else if (indexPath.row == 6) {
        return 10;
    }
    
    return 41;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) { //选择银行
        NSLog(@"选择银行");
        JNSHPopBankCardView *CardView = [[JNSHPopBankCardView alloc] initWithFrame:CGRectMake(0, 0, KscreenWidth, KscreenHeight)];
        CardView.typetag = 2;
        [CardView showInView:self.view];
    }else if (indexPath.row == 3) { //选择支行
        NSLog(@"选择支行");
        
        JNSHSubBankController *subBankVc = [[JNSHSubBankController alloc] init];
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
