//
//  QYRegistrationHeaderView.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/6.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYRegistrationHeaderView.h"
#import "QYRegistrationSelectButton.h"
#import "QYRegistrationNameLabel.h"
#import "QYMenuVC.h"
#import "QYTeam.h"

@interface QYRegistrationHeaderView ()<UIPopoverPresentationControllerDelegate>

/** 背景图片 */
@property (strong, nonatomic) UIImageView * bjImageView;
@property (strong, nonatomic) QYRegistrationSelectButton * competitionLevelButton;
@property (strong, nonatomic) QYRegistrationSelectButton * competitionAreaButton;
@property (strong, nonatomic) QYRegistrationSelectButton * provinceAndCityButton;
@property (strong, nonatomic) UILabel * hostButtonLabel;    
@property (strong, nonatomic) QYRegistrationSelectButton * hostTeamButton;
@property (strong, nonatomic) UILabel * guestButtonLabel;
@property (strong, nonatomic) QYRegistrationSelectButton * guestTeamButton;
/** ------ */
@property (strong, nonatomic) UILabel * mainRefereelabel;
@property (strong, nonatomic) UITextField * mainRefereeNameLabel;
@property (strong, nonatomic) UILabel * firstDeputyRefereelabel;
@property (strong, nonatomic) UITextField * firstDeputyRefereeNameLabel;
@property (strong, nonatomic) UILabel * secondDeputyRefereelabel;
@property (strong, nonatomic) UITextField * secondDeputyRefereeNameLabel;
@property (strong, nonatomic) UILabel * technicalRepresentativeLabel;
@property (strong, nonatomic) UITextField * technicalRepresentativeNameLabel;
@property (strong, nonatomic) UILabel * technicalStatisticsLabel;
@property (strong, nonatomic) UITextField * technicalStatisticsNameLabel_01;
@property (strong, nonatomic) UITextField * technicalStatisticsNameLabel_02;

@property (nonatomic ,strong)NSArray *teamDataSouce;
@property (nonatomic ,strong)NSArray *palyDataSouce;

/** 当前点击的按钮 */
@property (nonatomic, weak) UIButton * currentClickBtn;

@end

@implementation QYRegistrationHeaderView

+ (instancetype)initializeHeaderView {
    
    QYRegistrationHeaderView * registrationHeaderView =
    [[QYRegistrationHeaderView alloc] init];
    return registrationHeaderView;
}

// 创建下拉菜单
- (void)competitionRankBtn:(UIButton *)sender AndArr:(NSArray *)arr{
    
    UIButton * btn = (UIButton *)sender;//这个通过通知传过来的按钮。用来确定弹出控制器出现的位置
    self.currentClickBtn = btn;
//    __weak typeof(self) weakself = self;;
    QYMenuVC * menuVC = [QYMenuVC createMenuWithClickBlock:^(NSString *title) {
         // 创建菜单
            [btn setTitle:title forState:(UIControlStateNormal)];
            btn.selected = !btn.selected;
    } AndTeamBlock:^(NSArray *teamArr) {
        if (teamArr.count>0) {
            id team = teamArr[0];
            if ([team isKindOfClass:[QYTeam class]]) {
                _teamDataSouce = teamArr;
                
            }
            else{
                _palyDataSouce = teamArr;
                if (btn.tag == 3) {
                    if (self.delegate && [self.delegate performSelector:@selector(backPlayInfosByArr:andTeam:)]) {
                        [_delegate backPlayInfosByArr:teamArr andTeam:Host];
                    }
                }
                else{
                    if (self.delegate && [self.delegate performSelector:@selector(backPlayInfosByArr:andTeam:)]) {
                        [_delegate backPlayInfosByArr:teamArr andTeam:Guest];
                    }
                    
                }
            }
        }
    }];
    menuVC.buttonTag = btn.tag;
    menuVC.dataSouce = arr;
    menuVC.modalPresentationStyle = UIModalPresentationPopover;//设置控制器为弹出类型
    UIPopoverPresentationController * pover = menuVC.popoverPresentationController;//获得弹出控制器属性
    pover.delegate = self;// 设置代理
    menuVC.preferredContentSize = CGSizeMake(btn.frame.size.width, 200);//设置弹出控制器视图的大小
    pover.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];//设置弹出控制器背景视图为白透明
    [pover setSourceView:self];//设置在哪个控制器里面弹出来
    [pover setSourceRect:btn.frame];//设置弹出视图的位置。
    [pover setPermittedArrowDirections:UIPopoverArrowDirectionUnknown];//设置弹出类型为任意
    [[UIApplication sharedApplication].keyWindow.rootViewController
     presentViewController:menuVC animated:YES completion:nil];//显示弹出控制器
}

// 布局子控件
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 背景图片
    [self.bjImageView
     scaleFrameMake:0
                   :0
                   :CGScaleGetWidth(self.frame)
                   :CGScaleGetHeight(self.frame)];
    
    // 选择赛事级别按钮
    [self.competitionLevelButton
     scaleFrameMake:20
                   :66
                   :348
                   :72];
    
    // 选择赛区按钮
    [self.competitionAreaButton
     scaleFrameMake:CGScaleGetMaxX(self.competitionLevelButton.frame)+30
                   :CGScaleGetMinY(self.competitionLevelButton.frame)
                   :CGScaleGetWidth(self.competitionLevelButton.frame)
                   :CGScaleGetHeight(self.competitionLevelButton.frame)];
    
    // 市辖区按钮
    [self.provinceAndCityButton
     scaleFrameMake:CGScaleGetMaxX(self.competitionAreaButton.frame)+30
                   :CGScaleGetMinY(self.competitionAreaButton.frame)
                   :CGScaleGetWidth(self.competitionLevelButton.frame)
                   :CGScaleGetHeight(self.competitionLevelButton.frame)];
    
    // 主场球队Label
    [self.hostButtonLabel sizeToFit];
    self.hostButtonLabel.scaleX =
    CGScaleGetMaxX(self.provinceAndCityButton.frame)+30;
    self.hostButtonLabel.scaleY =
    CGScaleGetMinY(self.provinceAndCityButton.frame);
    self.hostButtonLabel.scaleH =
    CGScaleGetHeight(self.provinceAndCityButton.frame);
    
    // 主场球队按钮
    [self.hostTeamButton
     scaleFrameMake:CGScaleGetMaxX(self.hostButtonLabel.frame)+10
                   :CGScaleGetMinY(self.hostButtonLabel.frame)
                   :CGScaleGetWidth(self.provinceAndCityButton.frame)
                   :CGScaleGetHeight(self.provinceAndCityButton.frame)];
    
    // 客场球队Label
    [self.guestButtonLabel
     scaleFrameMake:CGScaleGetMaxX(self.hostTeamButton.frame)+30
                   :CGScaleGetMinY(self.hostButtonLabel.frame)
                   :CGScaleGetWidth(self.hostButtonLabel.frame)
                   :CGScaleGetHeight(self.hostButtonLabel.frame)];
    
    // 客场球队按钮
    [self.guestTeamButton
     scaleFrameMake:CGScaleGetMaxX(self.guestButtonLabel.frame)+10
                   :CGScaleGetMinY(self.hostTeamButton.frame)
                   :CGScaleGetWidth(self.hostTeamButton.frame)
                   :CGScaleGetHeight(self.hostTeamButton.frame)];
    
    
    /** -------------------------------------- */
    
    // 主裁判Label
    [self.mainRefereelabel sizeToFit];
    self.mainRefereelabel.scaleH =
    CGScaleGetHeight(self.competitionLevelButton.frame);
    self.mainRefereelabel.scaleX = 40;
    self.mainRefereelabel.scaleY =
    CGScaleGetMaxY(self.competitionLevelButton.frame)+18;
    
    // 主裁判姓名Label
    [self.mainRefereeNameLabel
     scaleFrameMake:CGScaleGetMaxX(self.mainRefereelabel.frame)+8
                   :CGScaleGetMinY(self.mainRefereelabel.frame)+9
                   :166
                   :56];
    
    // 第一副裁Label
    [self.firstDeputyRefereelabel sizeToFit];
    self.firstDeputyRefereelabel.scaleH =
    CGScaleGetHeight(self.mainRefereelabel.frame);
    self.firstDeputyRefereelabel.scaleX =
    CGScaleGetMaxX(self.mainRefereeNameLabel.frame)+72;
    self.firstDeputyRefereelabel.scaleY =
    CGScaleGetMinY(self.mainRefereelabel.frame);
    
    
    
    // 第一副裁姓名Label
    [self.firstDeputyRefereeNameLabel
     scaleFrameMake:CGScaleGetMaxX(self.firstDeputyRefereelabel.frame)+8
     :CGScaleGetMinY(self.firstDeputyRefereelabel.frame) +9
     :CGScaleGetWidth(self.mainRefereeNameLabel.frame)
     :CGScaleGetHeight(self.mainRefereeNameLabel.frame)];
    
    // 第二副裁Label
    [self.secondDeputyRefereelabel sizeToFit];
    self.secondDeputyRefereelabel.scaleH =
    CGScaleGetHeight(self.firstDeputyRefereelabel.frame);
    self.secondDeputyRefereelabel.scaleX
    = CGScaleGetMaxX(self.firstDeputyRefereeNameLabel.frame)+72;
    self.secondDeputyRefereelabel.scaleY
    = CGScaleGetMinY(self.mainRefereelabel.frame);
    
    // 第二副裁姓名Label
    [self.secondDeputyRefereeNameLabel
     scaleFrameMake:CGScaleGetMaxX(self.secondDeputyRefereelabel.frame)+8
                   :CGScaleGetMinY(self.secondDeputyRefereelabel.frame) +9
                   :CGScaleGetWidth(self.mainRefereeNameLabel.frame)
                   :CGScaleGetHeight(self.mainRefereeNameLabel.frame)];
    
    
    // 技术代表Label
    [self.technicalRepresentativeLabel sizeToFit];
    self.technicalRepresentativeLabel.scaleH =
    CGScaleGetHeight(self.secondDeputyRefereelabel.frame);
    self.technicalRepresentativeLabel.scaleX =
    CGScaleGetMaxX(self.secondDeputyRefereeNameLabel.frame)+72;
    self.technicalRepresentativeLabel.scaleY =
    CGScaleGetMinY(self.secondDeputyRefereelabel.frame);
    
    // 技术代表姓名Label
    [self.technicalRepresentativeNameLabel
     scaleFrameMake:CGScaleGetMaxX(self.technicalRepresentativeLabel.frame)+8
                   :CGScaleGetMinY(self.technicalRepresentativeLabel.frame)+9
                   :CGScaleGetWidth(self.mainRefereeNameLabel.frame)
                   :CGScaleGetHeight(self.mainRefereeNameLabel.frame)];
    
    // 技术统计Label
    [self.technicalStatisticsLabel sizeToFit];
    self.technicalStatisticsLabel.scaleH =
    CGScaleGetHeight(self.technicalRepresentativeLabel.frame);
    self.technicalStatisticsLabel.scaleX =
    CGScaleGetMaxX(self.technicalRepresentativeNameLabel.frame)+72;
    self.technicalStatisticsLabel.scaleY =
    CGScaleGetMinY(self.technicalRepresentativeLabel.frame);
    
    // 技术统计姓名_01Label
    [self.technicalStatisticsNameLabel_01
     scaleFrameMake:CGScaleGetMaxX(self.technicalStatisticsLabel.frame)+8
                   :CGScaleGetMinY(self.technicalStatisticsLabel.frame) +9
                   :CGScaleGetWidth(self.mainRefereeNameLabel.frame)
                   :CGScaleGetHeight(self.mainRefereeNameLabel.frame)];
    
    // 技术统计姓名_02Label
    [self.technicalStatisticsNameLabel_02
     scaleFrameMake:CGScaleGetMaxX(self.technicalStatisticsNameLabel_01.frame)+4
                   :CGScaleGetMinY(self.technicalStatisticsNameLabel_01.frame)
                   :CGScaleGetWidth(self.mainRefereeNameLabel.frame)
                   :CGScaleGetHeight(self.mainRefereeNameLabel.frame)];

}

#pragma mark - lazy

- (UIImageView *)bjImageView {
    
    if (!_bjImageView) {
        _bjImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头部背景"]];
        [self addSubview:_bjImageView];
    }
    return _bjImageView;
}

- (QYRegistrationSelectButton *)competitionLevelButton {
    
    if (!_competitionLevelButton) {
        _competitionLevelButton = [[QYRegistrationSelectButton alloc] init];
        _competitionLevelButton.tag = 0;
        [_competitionLevelButton setTitle:@"选择赛事级别" forState:(UIControlStateNormal)];
        [_competitionLevelButton addTarget:self action:@selector(competitionLevelClick:)
                          forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_competitionLevelButton];
    }
    return _competitionLevelButton;
}

// 赛事级别按钮监听方法
- (void)competitionLevelClick:(UIButton *)levelbtn {
    
    levelbtn.selected = !levelbtn.selected;
    [_competitionAreaButton setTitle:@"选择赛区" forState:(UIControlStateNormal)];
    [_provinceAndCityButton setTitle:@"市辖区" forState:(UIControlStateNormal)];
    [self competitionRankBtn:levelbtn AndArr:GameLevelArray];
}

- (QYRegistrationSelectButton *)competitionAreaButton {
    
    if (!_competitionAreaButton) {
        _competitionAreaButton = [[QYRegistrationSelectButton alloc] init];
        _competitionAreaButton.tag = 1;
        [_competitionAreaButton setTitle:@"选择赛区" forState:(UIControlStateNormal)];
        [_competitionAreaButton addTarget:self action:@selector(competitionAreaClick:)
                         forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_competitionAreaButton];
    }
    return _competitionAreaButton;
}

// 选择赛区按钮监听方法
- (void)competitionAreaClick:(UIButton *)areabtn {
    
    if ([[_competitionLevelButton titleForState:UIControlStateNormal] isEqualToString:@"大区赛"]) {
        areabtn.selected = !areabtn.selected;
        
        [_hostTeamButton setTitle:@"球队" forState:UIControlStateNormal];
        [_guestTeamButton setTitle:@"球队" forState:UIControlStateNormal];
        
        [self competitionRankBtn:areabtn AndArr:GameAreaArray];
    }
    
    
}

- (QYRegistrationSelectButton *)provinceAndCityButton {
    
    if (!_provinceAndCityButton) {
        _provinceAndCityButton = [[QYRegistrationSelectButton alloc] init];
        _provinceAndCityButton.tag = 2;
        [_provinceAndCityButton setTitle:@"市辖区" forState:(UIControlStateNormal)];
        [_provinceAndCityButton addTarget:self action:@selector(provinceAndCityClick:)
                         forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_provinceAndCityButton];
    }
    return _provinceAndCityButton;
}

// 省事选择按钮监听方法
- (void)provinceAndCityClick:(UIButton *)cityBtn {
    
    
    if ([[_competitionLevelButton titleForState:UIControlStateNormal] isEqualToString:@"地区赛"]) {
        [_hostTeamButton setTitle:@"球队" forState:UIControlStateNormal];
        [_guestTeamButton setTitle:@"球队" forState:UIControlStateNormal];
        cityBtn.selected = !cityBtn.selected;
        [self competitionRankBtn:cityBtn AndArr:GameProvinceArray];
    }
}

- (UILabel *)hostButtonLabel {
    
    if (!_hostButtonLabel) {
        _hostButtonLabel = [[UILabel alloc] init];
        _hostButtonLabel.text = @"主场";
        _hostButtonLabel.font = kSCALE_FONT(15);
        _hostButtonLabel.textColor = [UIColor whiteColor];
        _hostButtonLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_hostButtonLabel];
    }
    return _hostButtonLabel;
}

- (QYRegistrationSelectButton *)hostTeamButton {
    
    if (!_hostTeamButton) {
        _hostTeamButton = [[QYRegistrationSelectButton alloc] init];
        _hostTeamButton.tag =3;
        [_hostTeamButton setTitle:@"球队" forState:(UIControlStateNormal)];
        [_hostTeamButton addTarget:self action:@selector(hostTeamClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_hostTeamButton];
    }
    return _hostTeamButton;
}

// 主场球队按钮监听方法
- (void)hostTeamClick:(UIButton *)teamBtn {
    
    teamBtn.selected = !teamBtn.selected;
    [self competitionRankBtn:teamBtn AndArr:_teamDataSouce];
}

- (UILabel *)guestButtonLabel {
    
    if (!_guestButtonLabel) {
        _guestButtonLabel = [[UILabel alloc] init];
        _guestButtonLabel.text = @"客场";
        _guestButtonLabel.font = kSCALE_FONT(15);
        _guestButtonLabel.textColor = [UIColor whiteColor];
        _guestButtonLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_guestButtonLabel];
    }
    return _guestButtonLabel;
}

- (QYRegistrationSelectButton *)guestTeamButton {
    
    if (!_guestTeamButton) {
        _guestTeamButton = [[QYRegistrationSelectButton alloc] init];
        _guestTeamButton.tag = 4;
        [_guestTeamButton setTitle:@"球队" forState:(UIControlStateNormal)];
        [_guestTeamButton addTarget:self action:@selector(guestTeamClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_guestTeamButton];
    }
    return _guestTeamButton;
}

// 客场球队按钮
- (void)guestTeamClick:(UIButton *)teamBtn {
    
    teamBtn.selected = !teamBtn.selected;
    [self competitionRankBtn:teamBtn AndArr:_teamDataSouce];
}

- (UILabel *)mainRefereelabel {
    
    if (!_mainRefereelabel) {
        
        _mainRefereelabel = [[UILabel alloc] init];
        _mainRefereelabel.text = @"主裁判";
        _mainRefereelabel.font = kSCALE_FONT(15);
        _mainRefereelabel.textColor = [UIColor whiteColor];
        _mainRefereelabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_mainRefereelabel];
    }
    return _mainRefereelabel;
}

- (UITextField *)mainRefereeNameLabel {
    
    if (!_mainRefereeNameLabel) {
        _mainRefereeNameLabel = [[UITextField alloc] init];
        _mainRefereeNameLabel.textColor = [UIColor colorWithHexRGB:@"1e3d74" andAlpha:1];
        _mainRefereeNameLabel.textAlignment = NSTextAlignmentCenter;
        _mainRefereeNameLabel.backgroundColor = [UIColor whiteColor];
        _mainRefereeNameLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
        _mainRefereeNameLabel.layer.cornerRadius = scaleX_ByPx(7.83);
        _mainRefereeNameLabel.clipsToBounds = YES;
        [self addSubview:_mainRefereeNameLabel];
        
    }
    
    
    
    return _mainRefereeNameLabel;
}

- (UILabel *)firstDeputyRefereelabel {
    
    if (!_firstDeputyRefereelabel) {
        
        _firstDeputyRefereelabel = [[UILabel alloc] init];
        _firstDeputyRefereelabel.text = @"第一副裁";
        _firstDeputyRefereelabel.font = kSCALE_FONT(15);
        _firstDeputyRefereelabel.textColor = [UIColor whiteColor];
        _firstDeputyRefereelabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_firstDeputyRefereelabel];
    }
    return _firstDeputyRefereelabel;
}

- (UITextField *)firstDeputyRefereeNameLabel {
    
    if (!_firstDeputyRefereeNameLabel) {
        _firstDeputyRefereeNameLabel = [[UITextField alloc] init];
        _firstDeputyRefereeNameLabel.textColor = [UIColor colorWithHexRGB:@"1e3d74" andAlpha:1];
        _firstDeputyRefereeNameLabel.textAlignment = NSTextAlignmentCenter;
        _firstDeputyRefereeNameLabel.backgroundColor = [UIColor whiteColor];
        _firstDeputyRefereeNameLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
        _firstDeputyRefereeNameLabel.layer.cornerRadius = scaleX_ByPx(7.83);
        _firstDeputyRefereeNameLabel.clipsToBounds = YES;
        [self addSubview:_firstDeputyRefereeNameLabel];
        
    }

    return _firstDeputyRefereeNameLabel;
}

- (UILabel *)secondDeputyRefereelabel {
    
    if (!_secondDeputyRefereelabel) {
        
        _secondDeputyRefereelabel = [[UILabel alloc] init];
        _secondDeputyRefereelabel.text = @"第二副裁";
        _secondDeputyRefereelabel.font = kSCALE_FONT(15);
        _secondDeputyRefereelabel.textColor = [UIColor whiteColor];
        _secondDeputyRefereelabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_secondDeputyRefereelabel];
    }
    return _secondDeputyRefereelabel;
}

- (UITextField *)secondDeputyRefereeNameLabel {
    
    if (!_secondDeputyRefereeNameLabel) {
        _secondDeputyRefereeNameLabel = [[UITextField alloc] init];
        _secondDeputyRefereeNameLabel.textColor = [UIColor colorWithHexRGB:@"1e3d74" andAlpha:1];
        _secondDeputyRefereeNameLabel.textAlignment = NSTextAlignmentCenter;
        _secondDeputyRefereeNameLabel.backgroundColor = [UIColor whiteColor];
        _secondDeputyRefereeNameLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
        _secondDeputyRefereeNameLabel.layer.cornerRadius = scaleX_ByPx(7.83);
        _secondDeputyRefereeNameLabel.clipsToBounds = YES;
        [self addSubview:_secondDeputyRefereeNameLabel];
        
    }
    return _secondDeputyRefereeNameLabel;
}

- (UILabel *)technicalRepresentativeLabel {
    
    if (!_technicalRepresentativeLabel) {
        
        _technicalRepresentativeLabel = [[UILabel alloc] init];
        _technicalRepresentativeLabel.text = @"技术代表";
        _technicalRepresentativeLabel.font = kSCALE_FONT(15);
        _technicalRepresentativeLabel.textColor = [UIColor whiteColor];
        _technicalRepresentativeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_technicalRepresentativeLabel];
    }
    return _technicalRepresentativeLabel;
}

- (UITextField *)technicalRepresentativeNameLabel {
    
    if (!_technicalRepresentativeNameLabel) {
        _technicalRepresentativeNameLabel = [[UITextField alloc] init];
        _technicalRepresentativeNameLabel.textColor = [UIColor colorWithHexRGB:@"1e3d74" andAlpha:1];
        _technicalRepresentativeNameLabel.textAlignment = NSTextAlignmentCenter;
        _technicalRepresentativeNameLabel.backgroundColor = [UIColor whiteColor];
        _technicalRepresentativeNameLabel.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
        _technicalRepresentativeNameLabel.layer.cornerRadius = scaleX_ByPx(7.83);
        _technicalRepresentativeNameLabel.clipsToBounds = YES;
        [self addSubview:_technicalRepresentativeNameLabel];
        
    }
    return _technicalRepresentativeNameLabel;
}

- (UILabel *)technicalStatisticsLabel {
    
    if (!_technicalStatisticsLabel) {
        
        _technicalStatisticsLabel = [[UILabel alloc] init];
        _technicalStatisticsLabel.text = @"技术统计";
        _technicalStatisticsLabel.font = kSCALE_FONT(15);
        _technicalStatisticsLabel.textColor = [UIColor whiteColor];
        _technicalStatisticsLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_technicalStatisticsLabel];
    }
    return _technicalStatisticsLabel;
}

- (UITextField *)technicalStatisticsNameLabel_01 {
    
    if (!_technicalStatisticsNameLabel_01) {
        _technicalStatisticsNameLabel_01 = [[UITextField alloc] init];
        _technicalStatisticsNameLabel_01.textColor = [UIColor colorWithHexRGB:@"1e3d74" andAlpha:1];
        _technicalStatisticsNameLabel_01.textAlignment = NSTextAlignmentCenter;
        _technicalStatisticsNameLabel_01.backgroundColor = [UIColor whiteColor];
        _technicalStatisticsNameLabel_01.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
        _technicalStatisticsNameLabel_01.layer.cornerRadius = scaleX_ByPx(7.83);
        _technicalStatisticsNameLabel_01.clipsToBounds = YES;
        [self addSubview:_technicalStatisticsNameLabel_01];
        
    }
    return _technicalStatisticsNameLabel_01;
}

- (UITextField *)technicalStatisticsNameLabel_02 {
    
    if (!_technicalStatisticsNameLabel_02) {
        _technicalStatisticsNameLabel_02 = [[UITextField alloc] init];
        _technicalStatisticsNameLabel_02.textColor = [UIColor colorWithHexRGB:@"1e3d74" andAlpha:1];
        _technicalStatisticsNameLabel_02.textAlignment = NSTextAlignmentCenter;
        _technicalStatisticsNameLabel_02.backgroundColor = [UIColor whiteColor];
        _technicalStatisticsNameLabel_02.font = [UIFont systemFontOfSize:scaleX_ByPx(30)];
        _technicalStatisticsNameLabel_02.layer.cornerRadius = scaleX_ByPx(7.83);
        _technicalStatisticsNameLabel_02.clipsToBounds = YES;
        [self addSubview:_technicalStatisticsNameLabel_02];
        
    }
    return _technicalStatisticsNameLabel_02;
}

#pragma mark - < UIPopoverPresentationControllerDelegate >

// 下拉菜单消失时调用
- (void)popoverPresentationControllerDidDismissPopover:
(UIPopoverPresentationController *)popoverPresentationController {
    
    self.currentClickBtn.selected = !self.currentClickBtn.selected;
}

@end
