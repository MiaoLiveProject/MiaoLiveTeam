//
//  ZHJTabBarController.m
//  MiaoLive
//
//  Created by 张杰 on 16/7/16.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import "ZHJTabBarController.h"
#import "HomeViewController.h"
#import "MeViewController.h"
#import "ShowTimeViewController.h"
#import "ZHJNavigationController.h"

@interface ZHJTabBarController ()

@end

@implementation ZHJTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设定tabbar文本字体
    NSMutableDictionary *attrsDict = [NSMutableDictionary dictionary];
    attrsDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrsDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 设定tabbar选中的字体
    NSMutableDictionary *selectedAttrsDict = [NSMutableDictionary dictionary];
    selectedAttrsDict[NSFontAttributeName] = attrsDict[NSFontAttributeName];
    selectedAttrsDict[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // 设置tabbar的字体及颜色
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrsDict forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrsDict forState:UIControlStateSelected];
    
    // 设置子控制器
    [self           setupChidVc:[[HomeViewController alloc] init]
                       andTitle:@"主页"
                   andImageName:@"toolbar_home"
           andSelectedImageName:@"toolbar_home_sel"];
    
    [self           setupChidVc:[[ShowTimeViewController alloc] init]
                       andTitle:@"喵播"
                   andImageName:@"toolbar_live"
           andSelectedImageName:@"toolbar_live"];
    [self           setupChidVc:[[MeViewController alloc] init]
                       andTitle:@"个人中心"
                   andImageName:@"toolbar_me"
           andSelectedImageName:@"toolbar_me_sel"];
    
}

- (void)setupChidVc:(UIViewController *)vc andTitle:(NSString *)title andImageName:(NSString *)image andSelectedImageName:(NSString *)selectedImage
{
    // 标题
    vc.navigationItem.title = title;
    // 文字图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    // 给视图控制器包装一个导航栏
    ZHJNavigationController *nav = [[ZHJNavigationController alloc] initWithRootViewController:vc];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
    // 将包装好的nav设置为tabbar的子控制器
    [self addChildViewController:nav];
}


@end
