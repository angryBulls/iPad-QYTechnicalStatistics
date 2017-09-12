//
//  QYRegistrationNameLabel.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/7/3.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYRegistrationNameLabel.h"

@implementation QYRegistrationNameLabel

+ (instancetype)createRegistrationNameLabelWith:(NSString *)name {
    
    QYRegistrationNameLabel * registrationNameLabel =
    [QYRegistrationNameLabel buttonWithType:(UIButtonTypeCustom)];
    registrationNameLabel.titleLabel.font = kSCALE_FONT(15);
    registrationNameLabel.titleLabel.textAlignment = NSTextAlignmentCenter;
    [registrationNameLabel setTitle:name forState:(UIControlStateNormal)];
    [registrationNameLabel setBackgroundImage:[UIImage imageNamed:@"人员检录1_14"]
                                     forState:(UIControlStateNormal)];
    [registrationNameLabel setTitleColor:[UIColor colorWithHexRGB:@"1e3d74" andAlpha:1.0f]
                                forState:(UIControlStateNormal)];

    return registrationNameLabel;
}

- (void)setName:(NSString *)name {
    
    _name = name;
    [self setTitle:_name forState:(UIControlStateNormal)];
}

@end
