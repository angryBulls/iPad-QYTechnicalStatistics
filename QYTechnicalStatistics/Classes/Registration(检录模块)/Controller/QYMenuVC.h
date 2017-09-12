//
//  QYMenuVC.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/6.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBlock)(NSString *title);
typedef void(^TeamBlock)(NSArray *teamArr);


@interface QYMenuVC : UITableViewController
@property (nonatomic ,strong)NSArray *dataSouce;
/* initialization method **/
+ (instancetype)createMenuWithClickBlock:(ClickBlock)clickBlock AndTeamBlock:(TeamBlock)teamBlock;
@property (nonatomic,assign) NSInteger buttonTag;

@end
