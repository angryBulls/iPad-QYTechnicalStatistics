//
//  QYInputView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/16.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//  ***登陆页面--自定义输入视图***

#import <UIKit/UIKit.h>
@class QYInputView;

@protocol QYInputViewDelegate <NSObject>

- (void)inputView:(QYInputView *)inputView loginClick:(UIButton *)loginBtn AndDic:(NSDictionary *)dic;

@end

@interface QYInputView : UIView

+ (instancetype)createInputView;

/** delegate */
@property (nonatomic, weak) id<QYInputViewDelegate> delegate;

@end
