//
//  PlayerDataCell.m
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "PlayerDataCell.h"

@implementation PlayerDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _infoW.constant = scaleW_ByPx(268);
    _viewW.constant = scaleW_ByPx(247);
    
    _imageLeft.constant = scaleX_ByPx(23);
    _imageW.constant = _imageH.constant = scaleX_ByPx(76);
    
    _nameW.constant = scaleX_ByPx(100);
    _imageRight.constant = scaleX_ByPx(20);
    _numberW.constant = scaleX_ByPx(40);
    _infoView.backgroundColor = [UIColor colorWithHexRGB:@"#F4F8FF" andAlpha:1];
    
    
    for (NSLayoutConstraint *layout in self.addWs) {
        layout.constant = scaleX_ByPx(78);
    }
    
//    _addH.constant = _addW.constant = scaleX_ByPx(78);
    
    _lanBanView.backgroundColor = [UIColor colorWithHexRGB: @"#F4F8FF" andAlpha:1];
    _zhuGongView.backgroundColor = [UIColor colorWithHexRGB:@"#FFFFFF" andAlpha:1];
    _fanGuiView.backgroundColor = [UIColor colorWithHexRGB: @"#F4F8FF" andAlpha:1];
    _gaiMaoView.backgroundColor = [UIColor colorWithHexRGB:@"#FFFFFF" andAlpha:1];
    _oneView.backgroundColor = [UIColor colorWithHexRGB: @"#F4F8FF" andAlpha:1];
    _twoView.backgroundColor = [UIColor colorWithHexRGB:@"#FFFFFF" andAlpha:1];
    _threeView.backgroundColor = [UIColor colorWithHexRGB: @"#F4F8FF" andAlpha:1];
    
}
- (IBAction)addLanBan:(UIButton *)sender {
    
    
    UILabel *label = self.numLabels[sender.tag];
    int i = [label.text intValue];
   
    i++;
    label.text = [NSString stringWithFormat:@"%d",i];
    
}
- (IBAction)minusLanBan:(UIButton *)sender {
    
    
    UILabel *label = self.numLabels[sender.tag];
    int i = [label.text intValue];
    if (i>0) {
        
        i--;
    }
    label.text = [NSString stringWithFormat:@"%d",i];
    
    
}

@end
