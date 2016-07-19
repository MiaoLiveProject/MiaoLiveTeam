//
//  AppDelegate.m
//  MiaoLive
//
//  Created by 张杰 on 16/7/16.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import "AppDelegate.h"
#import "ZHJTabBarController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:ZHJScreenBounds];
    
    ZHJTabBarController *tabBarController = [[ZHJTabBarController alloc] init];
    
    self.window.rootViewController = tabBarController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
