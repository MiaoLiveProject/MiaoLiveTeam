//
//  UIView+ZJExtense.m
//  百思不得姐
//
//  Created by 张杰 on 16/5/8.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import "UIView+ZJExtense.h"

@implementation UIView (ZJExtense)

-(void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

-(CGFloat)centerX
{
    return self.center.x;
}

-(CGFloat)centerY
{
    return self.center.y;
}

-(CGSize)size
{
    return self.frame.size;
}


-(CGFloat)width
{
    return self.frame.size.width;
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(CGFloat)x
{
    return self.frame.origin.x;
}

-(CGFloat)y
{
    return self.frame.origin.y;
}

- (BOOL)isShowingOnWindow
{
    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    //转换控件的坐标系
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    //主窗口的bounds 和 self的矩形框是否有重叠
    BOOL intersets = CGRectIntersectsRect(newFrame, winBounds);
    
    //当一个控件显示在窗口上的时候，它的window属性一定不为空
    return !self.hidden && self.alpha > 0.01 && intersets && self.window == keyWindow;
}

@end
