//
//  ZHJNetworkTool.m
//  MiaoLive
//
//  Created by 张杰 on 16/7/18.
//  Copyright © 2016年 zhangjie. All rights reserved.
//  自定义的网络工具类

#import "ZHJNetworkTool.h"

static ZHJNetworkTool *_manager;
@implementation ZHJNetworkTool

+ (instancetype)shareTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _manager = [ZHJNetworkTool manager];
        // 设置超时时间
        _manager.requestSerializer.timeoutInterval = 5.f;
        // 设置可接受数据的type
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _manager;
}

@end
