//
//  QYLoginViewController.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/1.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYLoginViewController.h"
#import "UIView+ScaleFrame.h"
#import "QYInputView.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserEntity.h"
// 测试导入
#import "QYNavigationController.h"
#import "QYRegistrationVC.h"
#import "LoginViewModel.h"
#import "TSUserInfoModelBCBC.h"
#import "TSToolsMethod.h"
//网络请求


@interface QYLoginViewController ()<QYInputViewDelegate>

/**
 *  输入视图
 */
@property (nonatomic, weak) QYInputView * inputView;

/**
 *  登陆背景图片
 */
@property (nonatomic, weak) UIImageView * bjImageView;

    
@end

@implementation QYLoginViewController

+ (instancetype)createLoginVC {
    
    QYLoginViewController * loginVC = [[QYLoginViewController alloc] init];
    loginVC.view.backgroundColor = [UIColor whiteColor];
    return loginVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBlank)];
    [self.view addGestureRecognizer:tap];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
  
// 登陆
- (void)login:(UIButton *)loginBtn {
   

//
//    LoginViewModel *login = [[LoginViewModel alloc] initWithDict:dic];
//    [login setBlockWithReturnBlock:^(id returnValue) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginLogOutNotifi" object:nil];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshMall" object:nil];
//        QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
//        NSLog(@"phone = %@", userInfo.phone);
//        [UMessage setAlias:userInfo.phone type:@"phone" response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//            
//        }];
//        [self.navigationController popViewControllerAnimated:YES];
//    } WithErrorBlock:^(id errorCode) {
//        [SVProgressHUD showInfoWithStatus:errorCode];
//    } WithFailureBlock:^{
//        [SVProgressHUD showInfoWithStatus:@"连接错误"];
//    }];
//    [login startLogin];

//    // 如若登陆成功、切换根视图控制器
//    [[UIApplication sharedApplication].keyWindow setRootViewController:[[QYNavigationController alloc] initWithRootViewController:[QYRegistrationVC getRegistrationVC]]];
}

#pragma mark - lazy

- (QYInputView *)inputView {
    
    if (!_inputView) {
        
        QYInputView * inputView = [QYInputView createInputView];
        _inputView = inputView;
        _inputView.delegate = self;
        [self.view addSubview:_inputView];
    }
    return _inputView;
}

- (UIImageView *)bjImageView {
    
    if (!_bjImageView) {
        UIImageView * bjImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"背景"]];
        [self.view addSubview:bjImageView];
        _bjImageView = bjImageView;
    }
    return _bjImageView;
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    // 已适配
    [self.bjImageView scaleFrameMake:0 :218 :2048 :1096];
    [self.inputView scaleCenterBoundsMake:1384 :218+180+736*0.5 :680 :845];
}


#pragma mark - < QYInputViewDelegate >

- (void)inputView:(QYInputView *)inputView loginClick:(UIButton *)loginBtn AndDic:(NSDictionary *)dic{
    
        LoginViewModel *login = [[LoginViewModel alloc] initWithDict:dic];
        [login setBlockWithReturnBlock:^(id returnValue) {

            QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
            NSLog(@" %@", userInfo.token);
            
        [[UIApplication sharedApplication].keyWindow setRootViewController:[[QYNavigationController alloc] initWithRootViewController:[QYRegistrationVC getRegistrationVC]]];
            
            
            
            
        } WithErrorBlock:^(id errorCode) {
            [SVProgressHUD showInfoWithStatus:errorCode];
        } WithFailureBlock:^{
            [SVProgressHUD showInfoWithStatus:@"连接错误"];
        }];
    
    
        [login startLogin];
    

}

-(void)touchBlank{
    [self.view endEditing:YES];
    
}


@end
