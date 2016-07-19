//
//  ZHJNew.h
//  MiaoLive
//
//  Created by 张杰 on 16/7/18.
//  Copyright © 2016年 zhangjie. All rights reserved.
//  home中最新界面的models
/*
 {
 "code": "100",
 "msg": "success",
 "data": {
 "totalPage": 17,
 "list": [
 {
 "nickname": "涩面",
 "photo": "http://liveimg.9158.com/pic/avator/2016-05-07/20160507191229717_250.png",
 "sex": 0,
 "starlevel": 0,
 "allnum": 0,
 "new": 0,
 "roomid": 60211530,
 "useridx": 60472973,
 "flv": "http://hdl.9158.com/live/847dacd1c3e5d6a24f9143f86c2e2068.flv",
 "serverid": 3,
 "position": ""
 },
 {
 */
#import <Foundation/Foundation.h>

@interface ZHJNew : NSObject
/** 直播地址 */
@property (nonatomic, copy  ) NSString   *flv;
/** 昵称 */
@property (nonatomic, copy  ) NSString   *nickname;
/** 照片地址 */
@property (nonatomic, copy  ) NSString   *photo;
/** 所在地区 */
@property (nonatomic, copy  ) NSString   *position;
/** 房间号 */
@property (nonatomic, copy  ) NSString   *roomid;
/** 用户id */
@property (nonatomic, copy  ) NSString   *useridx;
/** 是否是新人 */
@property (nonatomic, assign) NSUInteger newStar;
/** 服务器号 */
@property (nonatomic, assign) NSUInteger serverid;
/** 性别 */
@property (nonatomic, assign) NSUInteger sex;
/** 等级 */
@property (nonatomic, assign) NSUInteger starlevel;

@end
