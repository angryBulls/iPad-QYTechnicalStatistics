//
//  QYReplacePlayerVC.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/7/6.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QYReplacePlayerVCDelegate <NSObject>

-(void)backInsterDic1:(NSMutableDictionary *)dic1 andInsterDic2:(NSMutableDictionary *)dic2;

@end
@interface QYReplacePlayerVC : UIViewController

+ (instancetype)createReplacePlayerVC;

@property (nonatomic,weak)id <QYReplacePlayerVCDelegate>delegate;
@end
