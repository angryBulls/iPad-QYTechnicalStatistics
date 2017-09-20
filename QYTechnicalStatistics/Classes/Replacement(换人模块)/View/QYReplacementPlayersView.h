//
//  QYReplacementPlayersView.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/7/11.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QYReplacementPlayersViewDelegate<NSObject>

-(void)backPlaysChangeDic1:(NSMutableDictionary *)insterDic1 AndPlaysChangeDic2:(NSMutableDictionary *)insterDic2;

@end

@interface QYReplacementPlayersView : UIView



// 创建换人界面主/客队球员视图
+ (instancetype)createReplacementPlayersView;
@property (nonatomic ,assign)BOOL isGuest;
@property (nonatomic,weak)id<QYReplacementPlayersViewDelegate>delegate;
@end
