//
//  QYRegistrationNameLabel.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/7/3.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYRegistrationNameLabel : UIButton

@property (nonatomic, copy) NSString * name;

+ (instancetype)createRegistrationNameLabelWith:(NSString *)name;

@end
