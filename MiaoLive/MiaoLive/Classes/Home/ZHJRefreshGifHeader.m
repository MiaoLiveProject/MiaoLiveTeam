//
//  ZHJRefreshGifHeader.m
//  MiaoLive
//
//  Created by 张杰 on 16/7/19.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import "ZHJRefreshGifHeader.h"

@implementation ZHJRefreshGifHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
        NSArray *imagesArray = @[[UIImage imageNamed:@"reflesh1_60x55"],[UIImage imageNamed:@"reflesh2_60x55"],[UIImage imageNamed:@"reflesh3_60x55"]];
        [self setImages:imagesArray forState: MJRefreshStateRefreshing];
        [self setImages:imagesArray forState: MJRefreshStatePulling];
        [self setImages:imagesArray forState: MJRefreshStateIdle];
    }
    return self;
}

@end
