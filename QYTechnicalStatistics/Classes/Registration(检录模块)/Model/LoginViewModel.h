//
//  LoginViewModel.h
//  QiuYouHui
//
//  Created by 安鹏 on 2017/7/18.
//  Copyright © 2017年 longcai. All rights reserved.
//

#import "ViewModelClass.h"

@interface LoginViewModel : ViewModelClass
- (instancetype)initWithDict:(NSDictionary *)dic;

- (void)startLogin;
- (void)loginOut;
@end
