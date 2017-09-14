//
//  QYRegistrationHeaderView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/6.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//  #316BFE

#import <UIKit/UIKit.h>
@class QYRegistrationSelectButton;
@protocol QYRegistrationHeaderViewDelegate <NSObject>

-(void)backPlayInfosByArr:(NSArray *)arr andTeam:(NSInteger)team;

@end


@interface QYRegistrationHeaderView : UIView

@property(nonatomic,weak)id<QYRegistrationHeaderViewDelegate>delegate;

@property (strong, nonatomic) QYRegistrationSelectButton * competitionLevelButton;
@property (strong, nonatomic) QYRegistrationSelectButton * competitionAreaButton;
@property (strong, nonatomic) QYRegistrationSelectButton * provinceAndCityButton;
@property (strong, nonatomic) QYRegistrationSelectButton * guestTeamButton;
@property (strong, nonatomic) QYRegistrationSelectButton * hostTeamButton;

@property (strong, nonatomic) UITextField * mainRefereeNameLabel;

@property (strong, nonatomic) UITextField * firstDeputyRefereeNameLabel;

@property (strong, nonatomic) UITextField * secondDeputyRefereeNameLabel;
@property (strong, nonatomic) UITextField * technicalRepresentativeNameLabel;

@property (strong, nonatomic) UITextField * technicalStatisticsNameLabel_01;
@property (strong, nonatomic) UITextField * technicalStatisticsNameLabel_02;

+ (instancetype)initializeHeaderView;



@end
