//
//  UIView+ZJExtense.h
//  百思不得姐
//
//  Created by 张杰 on 16/5/8.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZJExtense)
//在分类声明property，只会生成方法的声明，不会生成方法的实现和带有下滑线de成员变量
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;
@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGFloat centerX;
@property (assign, nonatomic) CGFloat centerY;

- (BOOL)isShowingOnWindow;

@end
