//
//  UIView+ScaleFrame.h
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/16.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import <UIKit/UIKit.h>

// 此时以ipad9.7inch 横屏为基准(UI设计) 单位为pt
#define HYPOTHETIC_W 1024 
#define HYPOTHETIC_H 768

/**
 *  UIScreen width.
 */
#define  SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width

/**
 *  UIScreen height.
 */
#define  SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height


/**
 *  Status bar height.
 */
#define  StatusBarHeight      20.f

/**
 *  Navigation bar height.
 */
#define  NavigationBarHeight  44.f

/**
 *  Tabbar height.
 */
#define  TabbarHeight         49.f

/**
 *  Status bar & navigation bar height.
 */
#define  StatusBarAndNavigationBarHeight   (20.f + 44.f)



// 设置字体的宏
#define kSCALE_FONT(f) [UIFont systemFontOfSize:((MAIN_SCREEN.width/HYPOTHETIC_W) * (f))]
#define kSCALE_FONT_NAME_SIZE(n,f) [UIFont fontWithName:(n) size:((MAIN_SCREEN.width/HYPOTHETIC_W) * (f))]
// 设置字体的宏(描粗)
#define kSCALE_BOLD_FONT(f) [UIFont fontWithName:@"Helvetica-Bold" size:((MAIN_SCREEN.width/HYPOTHETIC_W) * (f))]
#define kSCALE_NUM(n) ((MAIN_SCREEN.width/HYPOTHETIC_W) * (n))

#define MAIN_SCREEN [UIScreen mainScreen].bounds.size
#define SCREEN_SCALE [UIScreen mainScreen].scale
#define XW(w) ((MAIN_SCREEN.width/HYPOTHETIC_W) * (w))
#define XH(h) ((MAIN_SCREEN.height/HYPOTHETIC_H) * (h))
#define R_XW(w) ((w)/(MAIN_SCREEN.width/HYPOTHETIC_W))
#define R_XH(h) ((h)/(MAIN_SCREEN.height/HYPOTHETIC_H))





@interface UIView (ScaleFrame)

/*
 * px为单位
 */
@property (assign, nonatomic) CGFloat scaleX;
@property (assign, nonatomic) CGFloat scaleY;
@property (assign, nonatomic) CGFloat scaleW;
@property (assign, nonatomic) CGFloat scaleH;
@property (assign, nonatomic) CGFloat scaleCenterX;
@property (assign, nonatomic) CGFloat scaleCenterY;

/*
 * 设置控件自适应尺寸方法 参数单位为px
 */
- (void)scaleFrameMake:(CGFloat)x :(CGFloat)y :(CGFloat)w :(CGFloat)h;
- (void)scaleCenterBoundsMake:(CGFloat)cenX :(CGFloat)cenY :(CGFloat)w :(CGFloat)h;
CGRect scaleFrameMake(CGFloat x, CGFloat y, CGFloat w, CGFloat h);

/*
 * 参数px 返回pt 根据像素返回对应比例化后的点数
 */
CGFloat scaleX_ByPx(CGFloat px);
CGFloat scaleY_ByPx(CGFloat px);
CGFloat scaleW_ByPx(CGFloat px);
CGFloat scaleH_ByPx(CGFloat px);

/*
 * 参数pt 返回值px
 */
CGFloat CGScaleGetMaxX(CGRect rect);
CGFloat CGScaleGetMaxY(CGRect rect);
CGFloat CGScaleGetMinX(CGRect rect);
CGFloat CGScaleGetMinY(CGRect rect);
CGFloat CGScaleGetCenterX(CGRect rect);
CGFloat CGScaleGetCenterY(CGRect rect);
CGFloat CGScaleGetWidth(CGRect rect);
CGFloat CGScaleGetHeight(CGRect rect);



@property (nonatomic) CGPoint viewOrigin;
@property (nonatomic) CGSize  viewSize;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

/*----------------------
 * Relative coordinate *
 ----------------------*/

@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint middlePoint;

/** 获得当前屏幕像素 */
CGSize CGScaleGetScreenSize();

@end
