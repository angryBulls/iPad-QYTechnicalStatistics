//
//  QYRegistrationSelectButton.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/30.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYRegistrationSelectButton.h"

@implementation QYRegistrationSelectButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor colorWithHexRGB:@"1e3d74" andAlpha:1.0f]
                   forState:(UIControlStateNormal)];
        [self setBackgroundImage:[UIImage imageNamed:@"人员检录1_03"]
                        forState:(UIControlStateNormal)];
        [self setImage:[UIImage imageNamed:@"人员检录1_08"] forState:(UIControlStateNormal)];
        [self setImage:[UIImage imageNamed:@"人员检录1_06"] forState:(UIControlStateSelected)];
        self.titleLabel.font = kSCALE_FONT(15);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 布局子控件
    self.imageView.scaleW = 22;
    self.imageView.scaleH = 11;
    self.imageView.scaleCenterX = CGScaleGetWidth(self.frame) - 25 - CGScaleGetWidth(self.imageView.frame)/2;
    self.imageView.scaleCenterY = CGScaleGetHeight(self.frame)/2;
    
    [self.titleLabel scaleFrameMake:0
                                   :0
                                   :CGScaleGetWidth(self.frame)-CGScaleGetWidth(self.imageView.frame)
                                   :CGScaleGetHeight(self.frame)];
}

- (void)setFrame:(CGRect)frame {
    
    frame.size.width = scaleW_ByPx(348);
    frame.size.height = scaleH_ByPx(72);
    [super setFrame:frame];
}

@end
