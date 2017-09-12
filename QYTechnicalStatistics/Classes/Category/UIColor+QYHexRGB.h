//
//  UIColor+QYHexRGB.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/14.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (QYHexRGB)

+ (UIColor *)colorWithHexRGB:(NSString *)inColorString andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;

@end
