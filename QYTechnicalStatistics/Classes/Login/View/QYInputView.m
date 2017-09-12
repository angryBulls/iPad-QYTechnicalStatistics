//
//  QYInputView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/16.
//  Copyright © 2017年 qiuyouquan. All rights reserved.


#import "QYInputView.h"
#import "QYInputTextField.h"

@interface QYInputView ()<UITextFieldDelegate>

/**
 *  登陆view title标识
 */
@property (nonatomic, weak) UILabel * titleLabel;

/**
 *  账号
 */
@property (weak, nonatomic) QYInputTextField *account;

/**
 *  密码
 */
@property (weak, nonatomic) QYInputTextField *pwd;

/**
 *  Login
 */
@property (nonatomic, weak) UIButton * loginBtn;
/*
 *免责声明
 */
@property (nonatomic ,strong) UIView * shengMingView;
@property (nonatomic ,strong) UIButton *shengMingBtn;
@property (nonatomic ,strong) UIButton *pwdBtn;
/*
 *记住密码
 */
@property (nonatomic ,strong) UIButton *remberBtn;


@end

@implementation QYInputView

+ (instancetype)createInputView {
    
    QYInputView * inputView = [[QYInputView alloc] init];
    inputView.backgroundColor = [UIColor colorWithHexRGB:@"#FFFFFF" andAlpha:0.9f];
    return inputView;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 设置子控件尺寸
    [self.titleLabel sizeToFit];
    self.titleLabel.scaleCenterX = CGScaleGetWidth(self.frame)/2;
    self.titleLabel.scaleCenterY = 92 + CGScaleGetHeight(self.titleLabel.frame)/2;
    
    [self.account scaleFrameMake:58
                               :92 * 2 + CGScaleGetHeight(self.titleLabel.frame)
                               :564
                               :82];
    self.account.text = @"wpc";
    
    [self.pwd scaleFrameMake:CGScaleGetMinX(self.account.frame)
                            :CGScaleGetMaxY(self.account.frame)+58
                            :CGScaleGetWidth(self.account.frame)
                            :CGScaleGetHeight(self.account.frame)];
    self.pwd.text = @"123456";
    [self creatShengMingView];
    
    
    [self.loginBtn scaleFrameMake:46 :CGScaleGetMaxY(self.pwd.frame)+94 :582 :100];
    [self CreatRemaberPWDView];
}

-(void)creatShengMingView{
    
    self.shengMingView = [[UIView alloc] initWithFrame:scaleFrameMake(61, 504, 564, 32)];
    [self addSubview:self.shengMingView];
    self.shengMingBtn = [[UIButton alloc] initWithFrame:scaleFrameMake(0, 0, 32, 32)];
    [self.shengMingView  addSubview:_shengMingBtn];
    [_shengMingBtn setImage:[UIImage imageNamed:@"圆形"] forState:UIControlStateNormal];
    [_shengMingBtn setImage:[UIImage imageNamed:@"圆形-h"] forState:UIControlStateSelected];
    [_shengMingBtn addTarget: self action:@selector(shengMingBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *shengMingL = [[UILabel alloc] initWithFrame:scaleFrameMake(10+32, 3.5, 564-(61+10+32), 25)];
    shengMingL.text = @"我已详细阅读并同意免责声明";
    shengMingL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:scaleX_ByPx(25)];
    shengMingL.textColor = [UIColor colorWithHexRGB:@"#666666" andAlpha:1];
    [self.shengMingView addSubview:shengMingL];
}

-(void)CreatRemaberPWDView{
    UIView *view = [[UIView alloc] initWithFrame:scaleFrameMake(63, 665, 678-63*2, 845-665)];
    [self addSubview:view];
    
    self.remberBtn = [[UIButton alloc] initWithFrame:scaleFrameMake(0, 0, 32, 32)];
    [view  addSubview:_remberBtn];
    [_remberBtn setImage:[UIImage imageNamed:@"圆形"] forState:UIControlStateNormal];
    [_remberBtn setImage:[UIImage imageNamed:@"圆形-h"] forState:UIControlStateSelected];
    [_remberBtn addTarget: self action:@selector(remberBtnBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *shengMingL = [[UILabel alloc] initWithFrame:scaleFrameMake(10+32, 3.5, 564-(61+10+32), 25)];
    shengMingL.text = @"记住密码";
    shengMingL.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:scaleX_ByPx(25)];
    shengMingL.textColor = [UIColor colorWithHexRGB:@"#666666" andAlpha:1];
    [view addSubview:shengMingL];
    
    UILabel *serverceL1 = [[UILabel alloc] initWithFrame:scaleFrameMake(0, 845-665-100, 678-63*2, 30)];
    [view addSubview:serverceL1];
    serverceL1.font = [UIFont systemFontOfSize:scaleX_ByPx(26)];
    serverceL1.textColor = [UIColor colorWithHexRGB:@"#666666" andAlpha:1];
    serverceL1.textAlignment = NSTextAlignmentCenter;
    serverceL1.text = @"赛事技术统计合作请致电：15201513972";
    
    UILabel *serverceL2 = [[UILabel alloc] initWithFrame:scaleFrameMake(0, 845-665-70, 678-63*2, 30)];
    [view addSubview:serverceL2];
    serverceL2.font = [UIFont systemFontOfSize:scaleX_ByPx(26)];
    serverceL2.textColor = [UIColor colorWithHexRGB:@"#666666" andAlpha:1];
    serverceL2.textAlignment = NSTextAlignmentCenter;
    serverceL2.text = @"客服电话：400-631-3677";
    
    
}

#pragma mark - lazy
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = kSCALE_FONT(22);
        titleLabel.text = @"登录";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor colorWithHexRGB:@"#333333" andAlpha:1.0f];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (QYInputTextField *)pwd {
    
    if (!_pwd) {
        
        QYInputTextField * pwd = [QYInputTextField
                                  createInputTextFieldWith:@"密码"
                                            andPlaceholder:@"密码 (6位数字/英文/数字加英文)"];
        [self addSubview:pwd];
        _pwd = pwd;
        _pwd.delegate = self;
    }
    return _pwd;
}

- (QYInputTextField *)account {
    
    if (!_account) {
        
        QYInputTextField * account = [QYInputTextField
                                      createInputTextFieldWith:@"登录名"
                                                andPlaceholder:@"登录名 (数字/英文/数字加英文)"];
        [self addSubview:account];
        _account = account;
        _account.delegate = self;
    }
    return _account;
}

- (UIButton *)loginBtn {
    
    if (!_loginBtn) {
        
        UIButton * loginBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [loginBtn setTitle:@"登    录" forState:(UIControlStateNormal)];
        [loginBtn addTarget:self action:@selector(loginClick:)
           forControlEvents:(UIControlEventTouchUpInside)];
        
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"默认按钮"]
                            forState:(UIControlStateNormal)];
        [loginBtn setBackgroundImage:[UIImage imageNamed:@"选中按钮"]
                            forState:(UIControlStateHighlighted)];
        
        loginBtn.titleLabel.font = kSCALE_BOLD_FONT(18);
        [self addSubview:loginBtn];
        
        _loginBtn = loginBtn;
    }
    return _loginBtn;
}



- (void)loginClick:(UIButton *)loginBtn {
    
    
    [_account resignFirstResponder];
    [_pwd resignFirstResponder];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"loginname"] = _account.text;
    dic[@"password"] = _pwd.text;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *deviceToken = [defaults objectForKey:@"deviceToken"];
//    dic[@"device_token"] = deviceToken;
//    dic[@"channel"] = @2;
    
    QYUserInfoModel *userInfo = [QYToolsMethod fetchUserInfoModel];
    userInfo.phone = _account.text;
    userInfo.password = _pwd.text;
    [QYToolsMethod setUserInfo:[userInfo dictWithModel:userInfo]];
    
       
    
    if ([self.delegate respondsToSelector:@selector(inputView:loginClick:AndDic:)]) {
        [self.delegate inputView:self loginClick:loginBtn AndDic:dic];
    }
}

-(void)shengMingBtnClicked:(UIButton *)btn{
    
    btn.selected = !btn.selected;
}

-(void)remberBtnBtnClicked:(UIButton *)btn{
    btn.selected = !btn.selected;
}


#pragma mark - <UITextFieldDelegate>

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.scaleCenterY -= kSCALE_NUM(180);// 提升输入框（防止键盘遮挡）
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.25f animations:^{
        
        self.scaleCenterY += kSCALE_NUM(180);// 隐藏键盘 还原输入框位置
    }];
}

@end
