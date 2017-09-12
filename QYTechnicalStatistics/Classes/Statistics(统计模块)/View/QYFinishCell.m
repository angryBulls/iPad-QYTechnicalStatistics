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
            [view addSubview:l];
            
        }
        view.tag = i;
        [self.viewArr addObject:view];
        [self addSubview:view];
        
    }
    
    self.backgroundColor = [UIColor colorWithHexRGB:@"#F4F8FF" andAlpha:1];
    
    return self;
}





@end
