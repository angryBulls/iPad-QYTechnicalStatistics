//
//  QYRegistrationCell.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/13.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSPlayerModel.h"
@protocol QYRegistrationCellDelegate <NSObject>
-(void)BackPlayerWithPlayer:(TSPlayerModel *)p andSection:(NSInteger )section andRow:(NSInteger)row;
@end

@interface QYRegistrationCell : UICollectionViewCell
@property (nonatomic ,strong)TSPlayerModel *p;
@property (nonatomic ,assign)NSInteger section;
@property (nonatomic ,assign)NSInteger row;
@property (nonatomic ,weak) id <QYRegistrationCellDelegate>delegate;
@end
