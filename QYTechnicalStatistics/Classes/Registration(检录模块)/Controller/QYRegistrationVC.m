//
//  QYRegistrationVC.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/13.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//  

#import "QYRegistrationVC.h"
#import "QYRegistrationCell.h"
#import "QYRegistrationHeaderView.h"
#import "QYStatisticsVC.h"


@interface QYRegistrationVC ()<QYRegistrationHeaderViewDelegate>

/**
 *  头部视图
 */
@property (nonatomic, strong) QYRegistrationHeaderView * registrationHeaderView;
/**
 *  进入比赛按钮
 */
@property (strong, nonatomic) UIButton * enterButton;
@property (nonatomic ,strong) NSMutableArray *hostDataSouce;
@property (nonatomic ,strong) NSMutableArray *guestDataSouce;
@end

@implementation QYRegistrationVC

// 重用ID
static NSString * const registrationCell = @"registrationCell";


// initialization func
+ (instancetype)getRegistrationVC {
    
    QYRegistrationVC * registrationVC = [[QYRegistrationVC alloc] init];
    registrationVC.automaticallyAdjustsScrollViewInsets = NO;
    return registrationVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // register
    [self.collectionView registerClass:[QYRegistrationCell class]
            forCellWithReuseIdentifier:registrationCell];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHid)];
    [self.view addGestureRecognizer:tap];
}


/** 设置头尾部是图 */
- (void)headerViewSettings {
    
    // 设置头尾部视图
    [self.registrationHeaderView scaleFrameMake:0 :0 :2048 :265];
    self.collectionView.contentInset =
    UIEdgeInsetsMake(scaleY_ByPx(265), 0, scaleY_ByPx(265), 0);
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
//    return 15;
    if (section == 0) {
        return _hostDataSouce.count;
    }
    
    return _guestDataSouce.count;
    
}


- (QYRegistrationCell *)collectionView:(UICollectionView *)collectionView
                cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    QYRegistrationCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:registrationCell
                                              forIndexPath:indexPath];
    
    if (indexPath.section) {
        cell.p = _guestDataSouce[indexPath.row];
    }
    else
    {
        cell.p = _hostDataSouce[indexPath.row];
    }
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    // 设置头部是图
    [self headerViewSettings];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self.enterButton scaleCenterBoundsMake:CGScaleGetWidth(self.collectionView.frame)/2
                                           :CGScaleGetHeight(CGRectMake(0, 0,
                                            self.collectionView.contentSize.width,
                                            self.collectionView.contentSize.height))+200/2+50
                                           :326
                                           :100];
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


#pragma mark <UICollectionViewDelegate>



#pragma mark <QYRegistrationHeaderViewDelegate>

-(void)backPlayInfosByArr:(NSArray *)arr andTeam:(NSInteger)team{
    if (team) {
        _guestDataSouce = arr;
    }
    else
    {
        _hostDataSouce = arr;
    }
    [_collectionView reloadData];
    
}


#define mark - lazy

-(NSMutableArray *)HostDataSouce{
    if (_hostDataSouce == nil) {
        _hostDataSouce = [NSMutableArray array];
    }
    return _hostDataSouce;
}
-(NSMutableArray *)guestDataSouce{
    
    if (_guestDataSouce == nil) {
        _guestDataSouce = [NSMutableArray array];
    }
    return _guestDataSouce;
}

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        
        // 布局设置
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(scaleW_ByPx(300), scaleH_ByPx(226+50+10));
        flowLayout.headerReferenceSize = // 设置分组头视图大小
        CGSizeMake(scaleW_ByPx(2048), scaleH_ByPx(38+42+72));
                                         // 设置检录列表两侧边距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, scaleX_ByPx(103), 0, scaleX_ByPx(103));
        flowLayout.minimumInteritemSpacing = scaleW_ByPx(43);
        flowLayout.minimumLineSpacing = scaleH_ByPx(56);
        
        // colloctionView 创建
        UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kMAIN_SCREEN_SIZE.width, kMAIN_SCREEN_SIZE.height) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        self.collectionView = collectionView;
        [self.view addSubview:collectionView];
        
    }
    return _collectionView;
}

- (QYRegistrationHeaderView *)registrationHeaderView {
    
    if (!_registrationHeaderView) {
        _registrationHeaderView = [QYRegistrationHeaderView initializeHeaderView];
        _registrationHeaderView.delegate = self;
        [self.view addSubview:_registrationHeaderView];
    }
    return _registrationHeaderView;
}

- (UIButton *)enterButton {
    
    if (!_enterButton) {
        
        _enterButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_enterButton setBackgroundImage:[UIImage imageNamed:@"人员检录1_24"]
                                forState:(UIControlStateNormal)];
        [_enterButton setTitleColor:[UIColor whiteColor]
                           forState:(UIControlStateNormal)];
        [_enterButton setTitle:@"进入比赛" forState:(UIControlStateNormal)];
        [_enterButton addTarget:self action:@selector(enterClick:)
               forControlEvents:(UIControlEventTouchUpInside)];
        _enterButton.titleLabel.font = kSCALE_BOLD_FONT(15);
        [self.collectionView addSubview:_enterButton];
    }
    return _enterButton;
}

- (void)enterClick:(UIButton *)button {
    
    QYStatisticsVC * statisticsVC = [[QYStatisticsVC alloc] init];
    [self.navigationController pushViewController:statisticsVC animated:YES];
}

-(void)keyboardHid{
    
    [self.view endEditing:YES];
}

@end
