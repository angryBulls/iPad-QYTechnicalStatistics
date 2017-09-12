//
//  QYInputTextField.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/19.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//  ***登陆页面--自定义输入框***

#import <UIKit/UIKit.h>

@interface QYInputTextField : UITextField

+ (instancetype)createInputTextFieldWith:(NSString *)leftViewImage
                          andPlaceholder:(NSString *)placeholder;

@end
