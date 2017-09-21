//
//  QYFinishMatchVC.h
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSGameModel.h"

@interface QYFinishMatchVC : UIViewController

@property (nonatomic ,strong)TSDBManager *tSDBManager;
@property (nonatomic ,strong)TSGameModel *gameModel;

@end
