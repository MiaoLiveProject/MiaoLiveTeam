//
//  UIBarButtonItem+ZJExtension.m
//  百思不得姐
//
//  Created by 张杰 on 16/5/8.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import "UIBarButtonItem+ZJExtension.h"

@implementation UIBarButtonItem (ZJExtension)

+ (instancetype)itemWithImageName:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    //设置导航栏按钮
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    if (highImage != nil)
    {
        [button setBackgroundImage:[UIImage imageNamed:highImage] forState:(UIControlStateHighlighted)];
    }
    //设置button的方法
    [button addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    button.size = button.currentBackgroundImage.size;
    
    return [[self alloc]initWithCustomView:button];
}

@end
