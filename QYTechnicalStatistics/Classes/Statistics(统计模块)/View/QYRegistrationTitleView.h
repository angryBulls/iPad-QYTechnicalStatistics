//
//  QYRegistrationTitleView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/21.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYRegistrationScoreLabel.h"
@interface QYRegistrationTitleView : UIView

@property (nonatomic, strong) QYRegistrationScoreLabel * totalHostTeamLabel;
@property (nonatomic, strong) QYRegistrationScoreLabel * totalGuestTeamLabel;

@property (nonatomic, strong) QYRegistrationScoreLabel * hostTeamScoreLabel;
@property (nonatomic, strong) QYRegistrationScoreLabel * guestTeamScoreLabel;

+ (instancetype)createRegistrationTitleView;

@end
