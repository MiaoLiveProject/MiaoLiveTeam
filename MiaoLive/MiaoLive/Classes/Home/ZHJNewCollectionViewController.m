//
//  ZHJNewCollectionViewController.m
//  MiaoLive
//
//  Created by 张杰 on 16/7/17.
//  Copyright © 2016年 zhangjie. All rights reserved.
//

#import "ZHJNewCollectionViewController.h"
#import "ZHJNewCollectionViewCell.h"
#import "ZHJRefreshGifHeader.h"
#import "ZHJNetworkTool.h"
#import "ZHJNew.h"
#import "ZHJTopWindow.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <MBProgressHUD.h>

@interface ZHJNewCollectionViewController ()

// 存放一次的数据
@property (nonatomic, strong) NSMutableArray *firstNewData;
// 存放所有的模型数据
@property (nonatomic, strong) NSMutableArray *allNewData;

// 用于保存请求参数
@property (nonatomic, assign) NSInteger page;

@end

static NSString * const NewCellID = @"ZHJNewCollectionCell";

@implementation ZHJNewCollectionViewController

#pragma mark - 懒加载
- (NSMutableArray *)firstNewData
{
    if (!_firstNewData) {
        _firstNewData = [NSMutableArray array];
    }
    return _firstNewData;
}

- (NSMutableArray *)allNewData
{
    if (!_allNewData) {
        _allNewData = [NSMutableArray array];
    }
    return _allNewData;
}


#pragma mark - view的方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupRefreshControl];
    
    [ZHJTopWindow show];

    // 设置背景yanse
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 注册collectionView
   [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ZHJNewCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NewCellID];
}


#pragma mark - 初始化方法

- (void)setupMBProgressHUD
{
    
}

- (void)setupRefreshControl
{
    // 设置默认的
    self.page = 1;
    
    self.collectionView.mj_header = [ZHJRefreshGifHeader headerWithRefreshingBlock:^{
        // 恢复page为第1页
        self.page = 1;
        self.allNewData = [NSMutableArray array];
        [self loadNewData];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.page++;
        [self loadNewData];
    }];
    
    // 一开始就让他开始刷新
    [self.collectionView.mj_header beginRefreshing];
}


#pragma mark - 内部控制方法

// 获取数据
- (void)loadNewData
{
    // 从服务器获取数据
    [[ZHJNetworkTool shareTool]GET:[NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld",self.page] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // 监听进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 成功返回数据时回调
        // 停止刷新
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        // 如果返回的数据msg为fail，说明全部的数据已经加载完毕
        if([responseObject[@"msg"] isEqualToString:@"fail"])
        {
            NSLog(@"全部数据加载完毕");
            // 提示用户已经没有数据了
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        // 字典转模型
        self.firstNewData = [ZHJNew mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        // 加入的数组中
        [self.allNewData addObjectsFromArray:self.firstNewData];
        
        [self.collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败回调
        // 如果请求失败则页码－1（如果是第一页则不－1）
        if(self.page != 1)
        {
            self.page--;
        }
        
        // 停止刷新
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        ZJLog(@"数据请求失败: %@",error);
    }];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView :(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.allNewData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZHJNewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NewCellID forIndexPath:indexPath];

    cell.modelNew = self.allNewData[indexPath.row];
    
    return cell;
}


@end
