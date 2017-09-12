//
//  PlayerDataCell.h
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *infoW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageLeft;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageRight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numberW;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addW;
//@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addH;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *addWs;
@property (weak, nonatomic) IBOutlet UIView *headerIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *lanBanView;

//@property (weak, nonatomic) IBOutlet UILabel *lanBanNumLabel;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *numLabels;



@property (weak, nonatomic) IBOutlet UIView *zhuGongView;

@property (weak, nonatomic) IBOutlet UIView *fanGuiView;

@property (weak, nonatomic) IBOutlet UIView *gaiMaoView;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet UIView *threeView;

@end
