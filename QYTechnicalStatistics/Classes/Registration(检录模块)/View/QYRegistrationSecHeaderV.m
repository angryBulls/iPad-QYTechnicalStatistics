//
//  QYRegistrationSecHeaderV.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/13.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYRegistrationSecHeaderV.h"

@interface QYRegistrationSecHeaderV ()

// 队组图片
@property (strong, nonatomic) UIImageView *teamImageView;

@end

@implementation QYRegistrationSecHeaderV

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

- (void)settingWithIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        self.teamImageView.image = [UIImage imageNamed:@"人员检录1_18"];
    } else if (1 == indexPath.section) {
        self.teamImageView.image = [UIImage imageNamed:@"人员检录1_21"];
    }
}

#pragma mark - lazy

- (UIImageView *)teamImageView {
    
    if (!_teamImageView) {
        _teamImageView = [[UIImageView alloc] init];
        [_teamImageView scaleFrameMake:108 :38 :1832 :72];
        [self addSubview:_teamImageView];
    }
    return _teamImageView;
}

@end
