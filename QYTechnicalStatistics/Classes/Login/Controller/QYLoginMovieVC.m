//
//  QYLoginMovieVC.m
//  启动页
//
//  Created by 曹航玮 on 2017/6/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYLoginMovieVC.h"
#import <AVFoundation/AVFoundation.h>
#import "QYMovieCoveringView.h"
#import "QYLoginViewController.h"
#import "AppDelegate.h"
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kIsFirstLauchApp @"kIsFirstLauchApp"

@interface QYLoginMovieVC ()

/** 结束按钮 */
@property (nonatomic , strong) UIButton * enterMainButton;

@end

@implementation QYLoginMovieVC

+ (instancetype)loadLoginMovieWithResourceName:(NSString *)resourceName {
    
    QYLoginMovieVC * lmVC = [[QYLoginMovieVC alloc] init];
    lmVC.resourceName = resourceName;
    return lmVC;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    self.videoGravity = AVLayerVideoGravityResize;
    
    // 设置界面
    [self setupView];
    
    // 添加监听
    [self addNotification];
    
    // 初始化视频
    [self prepareMovie];
}


/**
 
 设置界面
 
 */
- (void)setupView {
    
    //设置进入主界面的按钮
    [self setupEnterMainButton];
}


/**
 
 初始化视频
 
 */
- (void)prepareMovie {
    
    //加载视频路径
    NSString *filePath = nil;
    filePath = [[NSBundle mainBundle] pathForResource:_resourceName ofType:@"mov"];
    
    //初始化player
    if (_resourceName) {
        
        self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:filePath]];
        self.showsPlaybackControls = NO;
        
    }
    
    //播放视频
    [self.player play];
}


/**
 
 初始化视图逻辑
 
 */
- (void)setupEnterMainButton {
    
    // 创建进入应用按钮
    self.enterMainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_enterMainButton setTitle:@"点击进入技术统计" forState:UIControlStateNormal];
    [_enterMainButton setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
    _enterMainButton.titleLabel.font = kSCALE_BOLD_FONT(28);
    
    // 设置按钮尺寸
    _enterMainButton.scaleW = 600;
    _enterMainButton.scaleH = 60;
    CGPoint center = _enterMainButton.center;
    center.x = MAIN_SCREEN.width/2;
    center.y = MAIN_SCREEN.height - CGScaleGetHeight(_enterMainButton.frame)/2 - kSCALE_NUM(25);
    _enterMainButton.center = center;
    
    // 添加进入应用按钮
    [self.view addSubview:[QYMovieCoveringView addCoveringView]];
    [self.view addSubview:_enterMainButton];
    
    // 添加点击事件
    [_enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
}

#pragma mark -- 进入应用和显示进入按钮

- (void)enterMainAction:(UIButton *)btn {
    
    // 视频暂停
    [self.player pause];
    
    //视频播放结束
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self moviePlaybackComplete];
    });
    
}


#pragma mark -- 监听以及实现方法

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewWillEnterForeground) name:UIApplicationDidBecomeActiveNotification object:nil];//进入前台
    
    //进入app视频需要轮播
    //视频播放结束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlaybackAgain) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}



/**
 
 再一次播放视频
 
 */
- (void)moviePlaybackAgain {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:_resourceName ofType:@"mov"];
    //初始化player
    self.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:filePath]];
    self.showsPlaybackControls = NO;
    //播放视频
    [self.player play];
}



/**
 
 视频播放完成
 
 */
- (void)moviePlaybackComplete {
    
    //发送推送之后就删除  否则 界面显示有问题
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:nil];
    
    //进入主界面
    [self enterMain];
}


/**
 
 APP进入前台时判断重新初始化视频还是继续播放
 
 */
- (void)viewWillEnterForeground
{
    
    if (!self.player) {
        [self prepareMovie];
    }
    //播放视频
    [self.player play];
}


/**
 
 设置是否是第一次打开APP
 
 */
- (void)setIsFirstLauchApp:(BOOL)isFirstLauchApp
{
    [[NSUserDefaults standardUserDefaults] setBool:isFirstLauchApp forKey:kIsFirstLauchApp];
}


/**
 
 控制器页面即将显示时
 
 */
- (BOOL)prefersStatusBarHidden {
    
    return YES;
}


/**
 
 移除控制器dealloc方法
 
 */
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self]; // 移除通知
    self.player = nil; // 将播放器设置为nil
}


/**
 
 进入主界面
 
 */
- (void)enterMain {
    
    [UIApplication sharedApplication].keyWindow.rootViewController =
    [QYLoginViewController createLoginVC];
}

@end
