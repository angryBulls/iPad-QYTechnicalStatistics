//
//  QYFinishCell.m
//  QYTechnicalStatistics
//
//  Created by 孙中山 on 2017/9/7.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "QYFinishCell.h"
#define LabelW (1024 -29)/7
#define LabelH self.frame.size.height *2

@interface QYFinishCell ()
@property (nonatomic,strong) UIImageView *headerIV;
@property (nonatomic ,strong)UILabel *nameL;
@property (nonatomic ,strong)UILabel *persitionL;
@property (nonatomic ,strong)UILabel *timeL;
@property (nonatomic ,strong)UILabel *lanBanL;
@property (nonatomic ,strong)UILabel *zhuGongL;
@property (nonatomic ,strong)UILabel *fanGuiL;
@property (nonatomic ,strong)UILabel *gaiMaoL;
@property (nonatomic ,strong)UILabel *oneL;
@property (nonatomic ,strong)UILabel *hitOneL;
@property (nonatomic ,strong)UILabel *twoL;
@property (nonatomic ,strong)UILabel *hitTwo;
@property (nonatomic ,strong)UILabel *threeL;
@property (nonatomic ,strong)UILabel *hitThree;
@property (nonatomic ,strong)NSMutableArray *viewArr;
@property (nonatomic,assign)NSInteger oneScroe;
@property (nonatomic,assign)NSInteger twoScroe;
@property (nonatomic,assign)NSInteger threeScroe;

@end
@implementation QYFinishCell

-(NSMutableArray *)viewArr{
    if (_viewArr == nil) {
        _viewArr = [NSMutableArray array];
    }
    
    return _viewArr;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    NSArray *arr = @[@"王朝阳",@"前锋",@"8分钟",@"3",@"3",@"3",@"3",@"3",@"90%",@"3",@"60%",@"3",@"50%"];
    for (int i = 0; i<14; i++) {
        UIView *view = [[UIView alloc]initWithFrame:scaleFrameMake(i*LabelW, 0, LabelW, LabelH)];
        if (i == 0) {
            _headerIV = [[UIImageView alloc] initWithFrame:scaleFrameMake(LabelW/2-38, 13, 76, 76)];
            [view addSubview:_headerIV];
        }
        else
        {
            UILabel *l = [[UILabel alloc] initWithFrame:scaleFrameMake(0, 0, LabelW, LabelH)];
            l.textAlignment = NSTextAlignmentCenter;
            l.font = [UIFont systemFontOfSize:scaleX_ByPx(32)];
            l.backgroundColor = [UIColor clearColor];
            l.text = arr[i-1];
            [self.viewArr addObject:l];
            [view addSubview:l];
            
        }
        view.tag = i;
        
        [self addSubview:view];
        
    }
    
    self.backgroundColor = [UIColor colorWithHexRGB:@"#F4F8FF" andAlpha:1];
    
    return self;
}

-(void)setTPlayModel:(TSManagerPlayerModel *)tPlayModel{
    _tPlayModel = tPlayModel;
    
     [_headerIV sd_setImageWithURL:[NSURL URLWithString:tPlayModel.photo] completed:nil];//头像
    
    [_viewArr enumerateObjectsUsingBlock:^(UILabel  *label, NSUInteger idx, BOOL * _Nonnull stop) {
        switch (idx) {
            case 0: //名字
                label.text = tPlayModel.playerName;
                break;
            case 1: //位置
                label.text = tPlayModel.positional;
                break;
            case 2: //上场时间
                label.text =  tPlayModel.allPlayTimes.floatValue>0? [NSString stringWithFormat:@"%.1fmin",[tPlayModel.allPlayTimes floatValue] /60]:[NSString stringWithFormat:@"%.1fmin",[tPlayModel.playTimes floatValue] /60];
                break;
            case 3: //篮板
                label.text = tPlayModel.behaviorNumb4.length ? tPlayModel.behaviorNumb4:@"0";
                break;
            case 4: //助攻
                label.text = tPlayModel.behaviorNumb9.length ? tPlayModel.behaviorNumb9:@"0";
                break;
            case 5: //犯规
                label.text = tPlayModel.behaviorNumb10.length ? tPlayModel.behaviorNumb10:@"0";
                break;
            case 6: //盖帽
                label.text = tPlayModel.behaviorNumb8.length ? tPlayModel.behaviorNumb8 : @"0";
                break;
            case 7: //1分个数
                label.text = tPlayModel.FreeThrowHit.length ? tPlayModel.FreeThrowHit: @"0";
                _oneScroe = [label.text integerValue];
                break;
            case 8: //1分命中率
                label.text = tPlayModel.behaviorNumb1.length && _oneScroe != 0 ? [NSString stringWithFormat:@"%.1lf%%",100*_oneScroe/[tPlayModel.behaviorNumb1 floatValue]]:@"0";
                break;
            case 9: //2分个数
                label.text = tPlayModel.TwoPointsHit.length ? tPlayModel.TwoPointsHit: @"0";
                _twoScroe = [label.text integerValue];
                break;
            case 10: //2分命中率
                label.text = tPlayModel.behaviorNumb2.length && _twoScroe != 0 ? [NSString stringWithFormat:@"%.1f%%",_twoScroe/[tPlayModel.behaviorNumb2 floatValue]*100]:@"0";
                break;
            case 11: //3分个数
                label.text = tPlayModel.ThreePointsHit.length? tPlayModel.ThreePointsHit :@"0";
                _threeScroe = [label.text integerValue];
                break;
            case 12: //3分命中率
                label.text = label.text = tPlayModel.behaviorNumb3.length && _threeScroe != 0 ? [NSString stringWithFormat:@"%.1f%%",_threeScroe/[tPlayModel.behaviorNumb3 floatValue]*100]:@"0";
                break;
            default:
                break;
        }
    }];
    
 
    
}



@end
