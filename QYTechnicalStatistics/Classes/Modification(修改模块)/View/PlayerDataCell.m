//
//  PlayerDataCell.m
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "PlayerDataCell.h"
@interface PlayerDataCell()
@property (nonatomic,assign) NSInteger freeThrow;
@property (nonatomic,assign) NSInteger twoPoints;
@property (nonatomic,assign) NSInteger threePoints;

@end
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
    
    _lanBanView.backgroundColor = [UIColor colorWithHexRGB: @"#F4F8FF" andAlpha:1];
    _zhuGongView.backgroundColor = [UIColor colorWithHexRGB:@"#FFFFFF" andAlpha:1];
    _fanGuiView.backgroundColor = [UIColor colorWithHexRGB: @"#F4F8FF" andAlpha:1];
    _gaiMaoView.backgroundColor = [UIColor colorWithHexRGB:@"#FFFFFF" andAlpha:1];
    _oneView.backgroundColor = [UIColor colorWithHexRGB: @"#F4F8FF" andAlpha:1];
    _twoView.backgroundColor = [UIColor colorWithHexRGB:@"#FFFFFF" andAlpha:1];
    _threeView.backgroundColor = [UIColor colorWithHexRGB: @"#F4F8FF" andAlpha:1];
    
}

-(void)setTPlayModel:(TSManagerPlayerModel *)tPlayModel{
    _tPlayModel = tPlayModel;
    _nameLabel.text =tPlayModel.playerName;
    _numberLabel.text = tPlayModel.playerNumber;
    [_headerIV sd_setImageWithURL:[NSURL URLWithString:tPlayModel.photo] completed:nil];
    
    // 表示篮板、助攻、犯规、盖帽
    [self p_updateBottomStatisticViewWithModel:tPlayModel];
    // 表示罚篮、2分、3分、总得分等数据
    [self p_updateTopStatisticViewWithModel:tPlayModel];
 
}

- (void)p_updateBottomStatisticViewWithModel:(TSManagerPlayerModel *)playerModel {
    
    
    [self.numLabels enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL * _Nonnull stop) {
        if (0 == idx) { // 助攻
            
            // 进攻篮板
            NSInteger lanBan2 = [playerModel.behaviorNumb5 integerValue];
            // 防守篮板
            
            NSInteger lanBan1 = [playerModel.behaviorNumb4 integerValue];
            
            
            NSInteger lanBan = lanBan2 +lanBan1;
            UILabel *l = _numLabels[0];
            l.text = [NSString stringWithFormat:@"%ld",lanBan];

            
        } else if (1 == idx) {
            // 助攻
            label.text = playerModel.behaviorNumb9;

        } else if (2 == idx) {
            // 犯规
            label.text = playerModel.behaviorNumb10;
            
        } else if (3 == idx) {
            // 盖帽
            label.text = playerModel.behaviorNumb8;
            
        }
        if (0 == label.text.length) {
            
            label.text = @"0";
        }
    }];
    
}
- (void)p_updateTopStatisticViewWithModel:(TSManagerPlayerModel *)playerModel {
    [self.numLabels enumerateObjectsUsingBlock:^(UILabel  *label, NSUInteger idx, BOOL * _Nonnull stop) {
        if (4 == idx) {
            label.text = playerModel.FreeThrowHit.length ? playerModel.FreeThrowHit: @"0";
            _freeThrow = [playerModel.behaviorNumb1 integerValue];
            
            
        }
        else if (5 == idx)
        {
            
            label.text =playerModel.TwoPointsHit.length ? playerModel.TwoPointsHit: @"0";
            
            _twoPoints = [playerModel.behaviorNumb2 integerValue];
            

        }
        else if (6 == idx)
        {
            label.text = playerModel.ThreePointsHit.length? playerModel.ThreePointsHit :@"0";
            _threePoints = [playerModel.behaviorNumb3 integerValue];
        }
        
    }];
    
    
}



- (IBAction)addLanBan:(UIButton *)sender {
    
    NSString *behavior;
    UILabel *label = self.numLabels[sender.tag];
    int i = [label.text intValue];
    if (_tPlayModel.playerId.length) {
        
        switch (sender.tag) {
            case 0:
                behavior = OffensiveRebound;
                i++;
                break;
            case 1:
                behavior = Assists;
                i++;
                break;
            case 2:
                behavior = Fouls;
                i++;
                break;
            case 3:
                behavior = BlockShots;
                i++;
                break;
            case 4:
                if (i<_freeThrow) {
                    i++;
                    behavior = FreeThrowHit;
                }
                break;
            case 5:
                if (i<_twoPoints) {
                    i++;
                    behavior = TwoPointsHit;
                }
                break;
            case 6:
                if (i<_threePoints) {
                    i++;
                    behavior = ThreePointsHit;
                }
                break;
                
            default:
                break;
        }
        NSLog(@"%ld",sender.tag);
        label.text = [NSString stringWithFormat:@"%d",i];
        if (self.delegate && [self.delegate respondsToSelector:@selector(changePlayerDataAction:dataType:andNewValue:)] && behavior.length) {
            
            [self.delegate changePlayerDataAction:_tPlayModel dataType:behavior andNewValue:i];
        }
    }
    
}
- (IBAction)minusLanBan:(UIButton *)sender {
    
    NSString *behavior;
    UILabel *label = self.numLabels[sender.tag];
    int i = [label.text intValue];
    if (i>0 &&_tPlayModel.playerId.length) {
        i--;
        switch (sender.tag) {
            case 0:
                behavior = OffensiveRebound;
                break;
            case 1:
                behavior = Assists;
                break;
            case 2:
                behavior = Fouls;
                break;
            case 3:
                behavior = BlockShots;
                break;
            case 4:
                behavior = FreeThrowHit;
                break;
            case 5:
                behavior = TwoPointsHit;
                break;
            case 6:
                behavior = ThreePointsHit;
                break;
                
            default:
                break;
        }

        label.text = [NSString stringWithFormat:@"%d",i];
        if (self.delegate && [self.delegate respondsToSelector:@selector(changePlayerDataAction:dataType:andNewValue:)]) {
            [self.delegate changePlayerDataAction:_tPlayModel dataType:behavior andNewValue:i];
            
            
        }
        
    }
    
    
}

@end
