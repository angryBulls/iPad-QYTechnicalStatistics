//
//  QYInputTextField.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/19.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYInputTextField.h"
#import "UIView+ScaleFrame.h"
#import "UIColor+QYHexRGB.h"

@interface QYInputTextField ()

/**
 *  输入框左侧图标
 */
@property (nonatomic, strong) UIView * leftContainedView;
@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, copy) NSString * leftViewImage;

@end

@implementation QYInputTextField

+ (instancetype)createInputTextFieldWith:(NSString *)leftViewImage
                          andPlaceholder:(NSString *)placeholder {
    
    QYInputTextField * field = [[QYInputTextField alloc] init];
    field.background = [UIImage imageNamed:@"输入框背景"];
    field.leftViewImage = leftViewImage;
    field.leftViewMode = UITextFieldViewModeAlways;
    field.placeholder = placeholder;
    field.leftView = field.leftContainedView;
    field.clearButtonMode = UITextFieldViewModeAlways;
    [field setValue:[UIColor colorWithHexRGB:@"#666666" andAlpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [field setValue:kSCALE_FONT(15) forKeyPath:@"_placeholderLabel.font"];
    
    return field;
}


#pragma mark - lazy

- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        
        _leftImageView = [[UIImageView alloc]
                          initWithImage:[UIImage imageNamed:_leftViewImage]];
        [_leftImageView scaleFrameMake:34 :0 :24 :30];
    }
    return _leftImageView;
}

- (UIView *)leftContainedView {
    
    if (!_leftContainedView) {
        _leftContainedView = [[UIView alloc] init];
        [_leftContainedView scaleFrameMake:0 :0 :24 + 34 * 2.0 :30];
        [_leftContainedView addSubview:self.leftImageView];
    }
    return _leftContainedView;
}

@end
