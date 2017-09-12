//
//  UIView+ScaleFrame.m
//  QYTechnicalStatistics
//
//  Created by 曹航玮 on 2017/6/16.
//  Copyright © 2017年 qiuyouquan. All rights reserved.
//

#import "UIView+ScaleFrame.h"

@implementation UIView (ScaleFrame)


- (CGPoint)viewOrigin {
    
    return self.frame.origin;
}

- (void)setViewOrigin:(CGPoint)viewOrigin {
    
    CGRect newFrame = self.frame;
    newFrame.origin = viewOrigin;
    self.frame      = newFrame;
}

- (CGSize)viewSize {
    
    return self.frame.size;
}

- (void)setViewSize:(CGSize)viewSize {
    
    CGRect newFrame = self.frame;
    newFrame.size   = viewSize;
    self.frame      = newFrame;
}

- (CGFloat)x {
    
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.x = x;
    self.frame        = newFrame;
}

- (CGFloat)y {
    
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.y = y;
    self.frame        = newFrame;
}

- (CGFloat)width {
    
    return CGRectGetWidth(self.bounds);
}

- (void)setWidth:(CGFloat)width {
    
    CGRect newFrame     = self.frame;
    newFrame.size.width = width;
    self.frame          = newFrame;
}

- (CGFloat)height {
    
    return CGRectGetHeight(self.bounds);
}

- (void)setHeight:(CGFloat)height {
    
    CGRect newFrame      = self.frame;
    newFrame.size.height = height;
    self.frame           = newFrame;
}

- (CGFloat)top {
    
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)top {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.y = top;
    self.frame        = newFrame;
}

- (CGFloat)bottom {
    
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.y = bottom - self.frame.size.height;
    self.frame        = newFrame;
}

- (CGFloat)left {
    
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)left {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.x = left;
    self.frame        = newFrame;
}

- (CGFloat)right {
    
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    
    CGRect newFrame   = self.frame;
    newFrame.origin.x = right - self.frame.size.width;
    self.frame        = newFrame;
}

- (CGFloat)centerX {
    
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint newCenter = self.center;
    newCenter.x       = centerX;
    self.center       = newCenter;
}

- (CGFloat)centerY {
    
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint newCenter = self.center;
    newCenter.y       = centerY;
    self.center       = newCenter;
}

- (CGFloat)middleX {
    
    return CGRectGetWidth(self.bounds) / 2.f;
}

- (CGFloat)middleY {
    
    return CGRectGetHeight(self.bounds) / 2.f;
}

- (CGPoint)middlePoint {
    
    return CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
}


- (void)setScaleX:(CGFloat)scaleX {
    
    scaleX /= SCREEN_SCALE;
    scaleX = XW(scaleX);
    CGRect frame = self.frame;
    frame.origin.x = scaleX;
    self.frame = frame;
}

- (CGFloat)scaleX {
    
    CGFloat x = self.frame.origin.x;
    x = R_XW(x);
    x *= SCREEN_SCALE;
    return x;
}

- (void)setScaleY:(CGFloat)scaleY {
    
    scaleY /= SCREEN_SCALE;
    scaleY = XH(scaleY);
    CGRect frame = self.frame;
    frame.origin.y = scaleY;
    self.frame = frame;
}

- (CGFloat)scaleY {
    
    CGFloat y = self.frame.origin.y;
    y = R_XH(y);
    y *= SCREEN_SCALE;
    return y;
}

- (void)setScaleW:(CGFloat)scaleW {
    
    scaleW /= SCREEN_SCALE;
    scaleW = XW(scaleW);
    CGRect frame = self.frame;
    frame.size.width = scaleW;
    self.frame = frame;
}

- (CGFloat)scaleW {
    
    CGFloat w = self.frame.size.width;
    w = R_XW(w);
    w *= SCREEN_SCALE;
    return w;
}

- (void)setScaleH:(CGFloat)scaleH {
    
    scaleH /= SCREEN_SCALE;
    scaleH = XH(scaleH);
    CGRect frame = self.frame;
    frame.size.height = scaleH;
    self.frame = frame;
}

- (CGFloat)scaleH {
    
    CGFloat h = self.frame.size.height;
    h = R_XH(h);
    h *= SCREEN_SCALE;
    return h;
}

- (void)setScaleCenterX:(CGFloat)scaleCenterX {
    
    scaleCenterX /= SCREEN_SCALE;
    scaleCenterX = XW(scaleCenterX);
    CGPoint center = self.center;
    center.x = scaleCenterX;
    self.center = center;
}

- (CGFloat)scaleCenterX {
    
    CGFloat cx = self.center.x;
    cx = R_XW(cx);
    cx *= SCREEN_SCALE;
    return cx;
}

- (void)setScaleCenterY:(CGFloat)scaleCenterY {
    
    scaleCenterY /= SCREEN_SCALE;
    scaleCenterY = XH(scaleCenterY);
    CGPoint center = self.center;
    center.y = scaleCenterY;
    self.center = center;
}

- (CGFloat)scaleCenterY {
    
    CGFloat cy = self.center.y;
    cy = R_XH(cy);
    cy *= SCREEN_SCALE;
    return cy;
}

CGFloat CGScaleGetMaxX(CGRect rect) {
    
    CGFloat maxX = CGRectGetMaxX(rect);
    maxX = R_XW(maxX);
    maxX *= SCREEN_SCALE;
    return maxX;
}

CGFloat CGScaleGetMaxY(CGRect rect) {
    
    CGFloat maxY = CGRectGetMaxY(rect);
    maxY = R_XH(maxY);
    maxY *= SCREEN_SCALE;
    return maxY;
}

CGFloat CGScaleGetMinX(CGRect rect) {
    
    CGFloat minX = CGRectGetMinX(rect);
    minX = R_XW(minX);
    minX *= SCREEN_SCALE;
    return minX;
}

CGFloat CGScaleGetMinY(CGRect rect) {
    
    CGFloat minY = CGRectGetMinY(rect);
    minY = R_XH(minY);
    minY *= SCREEN_SCALE;
    return minY;
}

- (void)scaleFrameMake:(CGFloat)x :(CGFloat)y :(CGFloat)w :(CGFloat)h {
    
    self.scaleX = x;
    self.scaleY = y;
    self.scaleW = w;
    self.scaleH = h;
}

- (void)scaleCenterBoundsMake:(CGFloat)cenX :(CGFloat)cenY :(CGFloat)w :(CGFloat)h {
    
    self.scaleW = w;
    self.scaleH = h;
    self.scaleCenterX = cenX;
    self.scaleCenterY = cenY;
}

CGFloat CGScaleGetCenterX(CGRect rect) {
    
    CGFloat cenX = CGRectGetMidX(rect);
    cenX = R_XW(cenX);
    cenX *= SCREEN_SCALE;
    return cenX;
}

CGFloat CGScaleGetCenterY(CGRect rect) {
    
    CGFloat cenY = CGRectGetMidY(rect);
    cenY = R_XH(cenY);
    cenY *= SCREEN_SCALE;
    return cenY;
}

CGFloat CGScaleGetWidth(CGRect rect) {
    
    CGFloat width = CGRectGetWidth(rect);
    width = R_XW(width);
    width *= SCREEN_SCALE;
    return width;
}

CGFloat CGScaleGetHeight(CGRect rect) {
    
    CGFloat height = CGRectGetHeight(rect);
    height = R_XH(height);
    height *= SCREEN_SCALE;
    return height;
}

CGFloat scaleX_ByPx(CGFloat px) {
    
    px /= SCREEN_SCALE;
    px = XW(px);
    return px;
}

CGFloat scaleY_ByPx(CGFloat px) {
    
    px /= SCREEN_SCALE;
    px = XH(px);
    return px;
}

CGFloat scaleW_ByPx(CGFloat px) {
    
    px /= SCREEN_SCALE;
    px = XW(px);
    return px;
}

CGFloat scaleH_ByPx(CGFloat px) {
    
    px /= SCREEN_SCALE;
    px = XH(px);
    return px;
}

CGRect scaleFrameMake(CGFloat x, CGFloat y, CGFloat w, CGFloat h) {
    
    return CGRectMake(scaleX_ByPx(x), scaleY_ByPx(y), scaleW_ByPx(w), scaleH_ByPx(h));
}

CGSize CGScaleGetScreenSize() {
    
    CGSize size = MAIN_SCREEN;
    size.width = size.width * SCREEN_SCALE;
    size.height = size.height * SCREEN_SCALE;
    return size;
}

@end
