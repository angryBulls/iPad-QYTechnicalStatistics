//
//  QYRegistrationVC.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/13.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYBaseViewController.h"
#import "TSCheckModel.h"
@interface QYRegistrationVC : QYBaseViewController

@property (nonatomic, strong) TSCheckModel *checkModel;

/** initialization func */
+ (instancetype)getRegistrationVC;

@end
