//
//  ZHJNewCollectionViewCell.h
//  MiaoLive
//
//  Created by 张杰 on 16/7/18.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHJNew.h"
@interface ZHJNewCollectionViewCell : UICollectionViewCell

+ (instancetype)cell;
@property (nonatomic, strong)ZHJNew *modelNew;

@end
