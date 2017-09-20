//
//  QYChangeVC.h
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol QYChangeVCDelegate <NSObject>
-(void)finishChange;
@end

@interface QYChangeVC : UIViewController
@property (nonatomic,weak)id <QYChangeVCDelegate>delegate;
@end
