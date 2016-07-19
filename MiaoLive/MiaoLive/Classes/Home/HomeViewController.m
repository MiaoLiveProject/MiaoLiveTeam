//
//  HomeViewController.m
//  MiaoLive
//
//  Created by 张杰 on 16/7/16.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import "HomeViewController.h"
#import "ZHJHotTableViewController.h"
#import "ZHJNewCollectionViewController.h"
#import "ZHJCareViewController.h"
#import <Masonry.h>

@interface HomeViewController ()<UIScrollViewDelegate>

/* 顶部标签栏下面红色指示器 */
@property(nonatomic, strong) UIView *indicator;
/* 顶部标签栏view */
@property(nonatomic, weak) UIView *titlesView;
/* 用来记录选中的button */
@property (nonatomic, weak) UIButton *selectedButton;
/*底部的所有内容*/
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupChildVcs];
    
    [self setupTopTitles];
    
    [self setupScrollView];
}

#pragma mark - 基本配置

- (void)setupChildVcs
{
    ZHJHotTableViewController *hotVc = [[ZHJHotTableViewController alloc] init];
    [self addChildViewController:hotVc];
    
    ZHJNewCollectionViewController *NewVc = [[ZHJNewCollectionViewController alloc] initWithCollectionViewLayout:[self flowLayout]];
    [self addChildViewController:NewVc];
    
    ZHJCareViewController *CareVc = [[ZHJCareViewController alloc] init];
    [self addChildViewController:CareVc];
}

// 设置导航栏左右的按钮
- (void)setupNav
{
    // 创建左边按钮
    UIBarButtonItem *leftButtonItem = [UIBarButtonItem itemWithImageName:@"search_15x14" highImage:nil target:self action:@selector(leftButtonItemClick)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    // 创建右边按钮
    UIBarButtonItem *rightButtonItem = [UIBarButtonItem itemWithImageName:@"head_crown_24x24" highImage:nil target:self action:@selector(rightButtonItemClick)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

// 设置顶部的标签栏
- (void)setupTopTitles
{
    // 创建顶部标签栏
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor clearColor];
    titleView.frame = CGRectMake(0, 0, self.view.width - 100, 44);
    self.navigationItem.titleView = titleView;
    self.titlesView = titleView;

    // 创建标签栏指示器
    self.indicator = [[UIView alloc] init];
    self.indicator.backgroundColor = [UIColor whiteColor];
    self.indicator.tag = -1;
    self.indicator.height = 2;
    self.indicator.y = titleView.height - self.indicator.height;
    
    // 创建顶部标签栏里的button
    NSArray *titlesName = @[@"最热",@"最新",@"关注"];
    CGFloat height = titleView.height;
    CGFloat width = titleView.width / 3.0;
    
    for (int i = 0; i < titlesName.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.tag = i;
        button.frame = CGRectMake(i * width , 0 , width , height );
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [button setTitle:titlesName[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateDisabled)];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [titleView addSubview:button];
        
        // 如果是第一个button就直接设置为选中的状态，并保存选中的状态
        if (button.tag == 0)
        {
            button.enabled = NO;
            self.selectedButton = button;
            [button.titleLabel sizeToFit];
            self.indicator.width = button.width;
            self.indicator.centerX = button.centerX;
        }
    }
    [titleView addSubview:self.indicator];
}

// 初始化底层的滚动视图
- (void)setupScrollView
{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = CGRectMake(0, 0, ZHJScreenW, ZHJScreenH - ZHJTabbarHeight - ZHJNavBarHeight - ZHJStatusBarHeight);
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    contentView.showsVerticalScrollIndicator = NO;
    contentView.showsHorizontalScrollIndicator = NO;
    // 把滚动视图放到最底层
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    // 监听结束后的UIScrollView方法
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark - 内部控制方法
- (void)leftButtonItemClick
{
    NSLog(@"点击了左边的button");
}

- (void)rightButtonItemClick
{
    NSLog(@"点击了右边的button");
}

// 顶部标签栏的按钮点击方法
- (void)titleClick:(UIButton *)button
{
    // 把之前的button设置为非选中状态
    self.selectedButton.enabled = YES;
    // 把现在的button设置为选中状态
    button.enabled = NO;
    // 并把现在的button传递给用于记录选中button的button
    self.selectedButton = button;
    
    // 给indicator设置动画
    [UIView animateWithDuration:0.3 animations:^{
        self.indicator.centerX = button.centerX;
    }];
    
    //滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

#pragma mark - 设置collectionViewLayout

- (UICollectionViewFlowLayout *)flowLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置头部size
    layout.headerReferenceSize = CGSizeZero;
    
    // 设置itemSize
    CGFloat margin = 1;
    CGFloat width = (ZHJScreenW - margin * 2) / 3;
    CGFloat height = width;
    layout.itemSize = CGSizeMake(width, height);
    // 横向间距
    layout.minimumLineSpacing = margin;
    // 纵向间距
    layout.minimumInteritemSpacing = margin;
    // 设置uicollectionview 边距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    return layout;
}

#pragma mark -scrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    [scrollView addSubview:vc.view];
    
    NSString *vcStr = NSStringFromClass([vc class]);
    
    NSLog(@"这是第%ld页的%@控制器",index,vcStr);
}

//监听停止减速的消息
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self scrollViewDidEndScrollingAnimation:scrollView];
    [self titleClick:self.titlesView.subviews[index]];
}

@end
