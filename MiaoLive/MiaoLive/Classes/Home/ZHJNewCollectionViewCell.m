//
//  ZHJNewCollectionViewCell.m
//  MiaoLive
//
//  Created by 张杰 on 16/7/18.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import "ZHJNewCollectionViewCell.h"
#import <UIImageView+WebCache.h>

@interface ZHJNewCollectionViewCell()

/** 主播所在地址 */
@property (weak, nonatomic) IBOutlet UIButton *positionButton;
/** 主播的星星等级 */
@property (weak, nonatomic) IBOutlet UIImageView *starImageView;
/** 主播昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
/** 主播的头像 */
@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;
@end

@implementation ZHJNewCollectionViewCell


- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

// 只要有人调用ZHJNew的set方法就更行ui
- (void)setModelNew:(ZHJNew *)modelNew
{
    _modelNew = modelNew;
    
    // 1.更新地址
    self.positionButton.titleLabel.text = modelNew.position;
    self.positionButton.userInteractionEnabled = NO;
    
    // 2.更新昵称
    self.nickNameLabel.text = modelNew.nickname;
    
    // 3.更新头像
    [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:modelNew.photo]];
    
    // 4.更新new
    if (modelNew.newStar == 0){   // 如果newStar = 0 说明是新人
        self.starImageView.image = [UIImage imageNamed:@"flag_new_33x17_"];
    } else { // 能来到这里说明已经不是新人
        self.starImageView.image = [self starLevelImage:modelNew];
    }
    
}

// 用来获取主播等级的图片
- (UIImage *)starLevelImage:(ZHJNew *)model
{
    UIImage *startImage = [[UIImage alloc] init];
    switch (model.starlevel) {
        case 1:
            startImage = [UIImage imageNamed:@"girl_star1_40x19"];
            break;
        case 2:
            startImage = [UIImage imageNamed:@"girl_star2_40x19"];
            break;
        case 3:
            startImage = [UIImage imageNamed:@"girl_star3_40x19"];
            break;
        case 4:
            startImage = [UIImage imageNamed:@"girl_star4_40x19"];
            break;
        case 5:
            startImage = [UIImage imageNamed:@"girl_star5_40x19"];
            break;
        default:
            break;
    }
    return startImage;
}

// 创建一个快速构造方法
+ (instancetype)cell
{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

@end
