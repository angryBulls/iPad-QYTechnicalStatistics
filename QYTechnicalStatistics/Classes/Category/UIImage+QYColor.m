//
//  UIImage+QYColor.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/14.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "UIImage+QYColor.h"

@implementation UIImage (QYColor)

+ (UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
