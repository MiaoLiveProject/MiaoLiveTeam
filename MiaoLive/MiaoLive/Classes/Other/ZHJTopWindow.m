//
//  ZJTopWindow.m
//  百思不得姐
//
//  Created by 张杰 on 16/6/3.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import "ZHJTopWindow.h"

@implementation ZHJTopWindow

static UIWindow *window_;

+ (void)initialize
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, ZHJScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    window_.backgroundColor = [UIColor clearColor];
    window_.rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
   
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)windowClick
{
    //1.uiscrollview
    
    //2.keywindow 拿到window里的所有子控件
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [self searchScrollViewInView:window];
}

+ (void)searchScrollViewInView:(UIView *)superview
{
    for (UIScrollView *subviews in superview.subviews) {
       
        //如果子控件是scrollview，并且显示在window中，才去处理回滚事件
        if ([subviews isKindOfClass:[UIScrollView class]] && subviews.isShowingOnWindow)
        {
            
            CGPoint offSet = subviews.contentOffset;
            offSet.y = - subviews.contentInset.top;
            
            [subviews setContentOffset:offSet animated:YES];
            
        }
        //继续查找子控件
        [self searchScrollViewInView:subviews];
    }
}

/**
 *  监听窗口的点击
 */
+ (void)show
{
    window_.hidden = NO;
}

@end
