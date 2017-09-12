//
//  QYReplacePlayerVC.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/7/6.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYReplacePlayerVC.h"
#import "QYReplacementPlayersView.h"
#define kTestRowCount 3

@interface QYReplacePlayerVC () <UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView * topView;
@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) UIImageView * hostTeamTitleView;
@property (strong, nonatomic) UIImageView * guestTeamTitleView;
@property (strong, nonatomic) QYReplacementPlayersView * hostPlayersView;
@property (strong, nonatomic) QYReplacementPlayersView * guestPlayersView;

// 主队上下场每行头标题数组
@property (strong, nonatomic) NSMutableArray * hostSectionTitleArray;
// 客队上下场每行头标题数组
@property (strong, nonatomic) NSMutableArray * guestSectionTitleArray;
// 进入比赛按钮
@property (strong, nonatomic) UIButton * enterFieldButton;

@end

@implementation QYReplacePlayerVC

+ (instancetype)createReplacePlayerVC {
    
    QYReplacePlayerVC * replacePlayerVC = [[QYReplacePlayerVC alloc] init];
    return replacePlayerVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialization];
}

- (void)initialization {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.topView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 布局子控件
    [self.hostTeamTitleView scaleFrameMake:108 :31 :1832 :72];
    
    for (NSInteger count = 0; count < kTestRowCount; count++) {
        
        UIButton * secTitleView = self.hostSectionTitleArray[count];
        [secTitleView scaleFrameMake:108
                                    :CGScaleGetMaxY(self.hostTeamTitleView.frame)+31 + count*(286+50)
                                    :64
                                    :286];
    }
    
    [self.guestTeamTitleView scaleFrameMake:CGScaleGetMinX(self.hostTeamTitleView.frame)
                                           :CGScaleGetMaxY(((UIButton *)self.hostSectionTitleArray.lastObject).frame)+31
                                           :CGScaleGetWidth(self.hostTeamTitleView.frame)
                                           :CGScaleGetHeight(self.hostTeamTitleView.frame)];
    
    for (NSInteger count = 0; count < kTestRowCount; count++) {
        
        UIButton * secTitleView = self.guestSectionTitleArray[count];
        [secTitleView scaleFrameMake:108
                                    :CGScaleGetMaxY(self.guestTeamTitleView.frame)+ 31 + count*(286+50)
                                    :64
                                    :286];
    }
    
    [self.enterFieldButton scaleCenterBoundsMake:CGScaleGetWidth(self.scrollView.frame)/2
                                                :CGScaleGetMaxY(((UIButton *)self.guestSectionTitleArray.lastObject).frame)+70+50
                                                :326
                                                :100];
    
    // 布局换人界面主队球员视图
    self.hostPlayersView.scaleX = 306;
    self.hostPlayersView.scaleY = CGScaleGetMaxY(self.hostTeamTitleView.frame)+31;
    // 布局换人界面客队球员视图
    self.guestPlayersView.scaleX = CGScaleGetMinX(self.hostPlayersView.frame);
    self.guestPlayersView.scaleY = CGScaleGetMaxY(self.guestTeamTitleView.frame)+31;
    
    // 根据内容重设contentSize
    self.scrollView.contentSize =
    CGSizeMake(MAIN_SCREEN.width, scaleH_ByPx(CGScaleGetMaxY(self.enterFieldButton.frame)+70));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - lazy

- (UIImageView *)topView {
    
    if (!_topView) {
        
        _topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"头部背景"]];
        UILabel * titleLabel = [[UILabel alloc] init];
        [self.topView scaleFrameMake:0
                                    :0
                                    :2048
                                    :142];
        titleLabel.text = @"换人";
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = kSCALE_BOLD_FONT(20);
        [titleLabel sizeToFit];
        titleLabel.scaleCenterX = CGScaleGetWidth(self.view.frame)*0.5;
        titleLabel.scaleCenterY = CGScaleGetHeight(_topView.frame)*0.5;
        [_topView addSubview:titleLabel];
    }
    return _topView;
}

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentInset = UIEdgeInsetsMake(scaleY_ByPx(142), 0, 0, 0);
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.frame = CGRectMake(0, 0, MAIN_SCREEN.width, MAIN_SCREEN.height);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIImageView *)hostTeamTitleView {
    
    if (!_hostTeamTitleView) {
        _hostTeamTitleView = [[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:@"人员检录1_18"]];
        [self.scrollView addSubview:_hostTeamTitleView];
    }
    return _hostTeamTitleView;
}

- (UIImageView *)guestTeamTitleView {
    
    if (!_guestTeamTitleView) {
        _guestTeamTitleView = [[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:@"人员检录1_21"]];
        [self.scrollView addSubview:_guestTeamTitleView];
    }
    return _guestTeamTitleView;
}

// 主队上下场每行头标题数组lazy
- (NSMutableArray *)hostSectionTitleArray {
    
    if (!_hostSectionTitleArray) {
        _hostSectionTitleArray = [NSMutableArray array];
        for (NSInteger count = 0; count < kTestRowCount; count++) {
            
            UIButton * secTitleView = [self createSecTitleViewWith:@"圆角矩形28副本"
                                              enterFieldTitleColor:@"eb1a15"
                                                          andCount:count];
            [_hostSectionTitleArray addObject:secTitleView];
            [self.scrollView addSubview:secTitleView];
        }
    }
    return _hostSectionTitleArray;
}

// 客队上下场每行头标题数组lazy
- (NSMutableArray *)guestSectionTitleArray {
    
    if (!_guestSectionTitleArray) {
        _guestSectionTitleArray = [NSMutableArray array];
        for (NSInteger count = 0; count < kTestRowCount; count++) {
            
            UIButton * secTitleView = [self createSecTitleViewWith:@"圆角矩形28副本4"
                                              enterFieldTitleColor:@"#02703F"
                                                          andCount:count];
            [_guestSectionTitleArray addObject:secTitleView];
            [self.scrollView addSubview:secTitleView];
        }
    }
    return _guestSectionTitleArray;
}

// 换人界面主队球员视图lazy
- (QYReplacementPlayersView *)hostPlayersView {
    
    if (!_hostPlayersView) {
        _hostPlayersView = [QYReplacementPlayersView createReplacementPlayersView];
        [self.scrollView addSubview:_hostPlayersView];
    }
    return _hostPlayersView;
}

// 换人界面客队球员视图lazy
- (QYReplacementPlayersView *)guestPlayersView {
    
    if (!_guestPlayersView) {
        _guestPlayersView = [QYReplacementPlayersView createReplacementPlayersView];
        [self.scrollView addSubview:_guestPlayersView];
    }
    return _guestPlayersView;
}


// 进入比赛按钮
- (UIButton *)enterFieldButton {
    
    if (!_enterFieldButton) {
        
        _enterFieldButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_enterFieldButton setTitle:@"进入比赛" forState:(UIControlStateNormal)];
        [_enterFieldButton setTitleColor:[UIColor colorWithHexRGB:@"#ffffff" andAlpha:1.0f]
                                forState:(UIControlStateNormal)];
        [_enterFieldButton setBackgroundImage:[UIImage imageNamed:@"人员检录1_24"]
                                     forState:(UIControlStateNormal)];
        _enterFieldButton.titleLabel.font = kSCALE_FONT(16);
        [_enterFieldButton addTarget:self action:@selector(enterFieldClick:)
                    forControlEvents:(UIControlEventTouchUpInside)];
        [self.scrollView addSubview:_enterFieldButton];
    }
    return _enterFieldButton;
}

// 换人界面进入比赛按钮监听方法
- (void)enterFieldClick:(UIButton *)enterFieldBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIButton *)createSecTitleViewWith:(NSString *)enterFieldBjImage enterFieldTitleColor:(NSString *)color andCount:(NSInteger)count {
    
    UIButton * secTitleView = [UIButton buttonWithType:(UIButtonTypeCustom)];
    secTitleView.titleLabel.numberOfLines = 0;
    secTitleView.titleLabel.font = kSCALE_FONT(16);
    secTitleView.enabled = YES;
    // 按组设置背景图片
    if (0 == count) {
        
        [secTitleView setBackgroundImage:[UIImage imageNamed:enterFieldBjImage]
                                forState:(UIControlStateNormal)];
        [secTitleView setBackgroundImage:[UIImage imageNamed:enterFieldBjImage]
                                forState:(UIControlStateHighlighted)];
        [secTitleView setTitle:@"上场" forState:(UIControlStateNormal)];
        [secTitleView setTitleColor:[UIColor colorWithHexRGB:color andAlpha:1.0f]
                           forState:(UIControlStateNormal)];
    } else {
        
        [secTitleView setBackgroundImage:[UIImage imageNamed:@"圆角矩形28副本2"]
                                forState:(UIControlStateNormal)];
        [secTitleView setBackgroundImage:[UIImage imageNamed:@"圆角矩形28副本2"]
                                forState:(UIControlStateHighlighted)];
        [secTitleView setTitle:@"下场" forState:(UIControlStateNormal)];
        [secTitleView setTitleColor:[UIColor colorWithHexRGB:@"#515151" andAlpha:1.0f]
                           forState:(UIControlStateNormal)];
   }
    
   return secTitleView;
}

#pragma mark - <UIScrollViewDelegate>



@end
