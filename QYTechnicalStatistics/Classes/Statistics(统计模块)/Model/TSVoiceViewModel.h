//
//  TSVoiceViewModel.h
//  QYTS
//
//  Created by lxd on 2017/7/27.
//  Copyright © 2017年 longcai. All rights reserved.
//

#import "ViewModelClass.h"

@interface TSVoiceViewModel : ViewModelClass
- (instancetype)initWithPramasDict:(NSMutableDictionary *)pramasDict;

- (void)sendCurrentStageData;

- (void)abstention;
@end
