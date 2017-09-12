//
//  QYMovieCoveringView.m
//  启动页
//
//  Created by 曹航玮 on 2017/6/8.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYMovieCoveringView.h"

@implementation QYMovieCoveringView

+ (QYMovieCoveringView *)addCoveringView {
    
    return [QYMovieCoveringView new];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [super setFrame:frame];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {}


@end
