//
//  QYFinishMatchVC.h
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TSGameModel.h"

@protocol QYFinishMatchVCDelegate <NSObject>

-(void)removeInsertDBDictArrayObjects;

-(void)refreshTime;


@end



@interface QYFinishMatchVC : UIViewController

@property (nonatomic ,strong)TSDBManager *tSDBManager;
@property (nonatomic ,strong)TSGameModel *gameModel;
@property (nonatomic ,weak) id<QYFinishMatchVCDelegate>delegate;
@property (nonatomic, assign)NSInteger controllerTag;//0 单节比赛  1 整场比赛
@property (nonatomic, copy)NSString *finisnTag; 

@end
