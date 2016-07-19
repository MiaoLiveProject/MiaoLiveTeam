//
//  UIBarButtonItem+ZJExtension.h
//  百思不得姐
//
//  Created by 张杰 on 16/5/8.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZJExtension)

+ (instancetype)itemWithImageName:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


@end