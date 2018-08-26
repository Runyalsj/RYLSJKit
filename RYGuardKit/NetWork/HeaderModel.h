//
//  HeaderModel.h
//  FlowerTown
//
//  Created by 兔兔 on 2018/8/13.
//  Copyright © 2018年 HuaZhen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeaderModel : NSObject
@property(nonatomic,copy) NSString *userId;//用户ID
@property (nonatomic,copy) NSString * mobile_id;//设备号
@property (nonatomic,assign) NSInteger  origin;//0未知,1安卓,2IOS
@property (nonatomic,copy) NSString * version;//当前APP版本
@property (nonatomic,copy) NSString * api_version;//当前api版本
//@property (nonatomic,copy) NSString * channel;//来源渠道 苹果使用：@"App Store"
//@property (nonatomic,copy) NSString * clientId;//客户端唯一标示，后台用来判断是否更换设备
@property (nonatomic,assign) NSInteger  versioncode;//内部维护的应用版本 随版本递增
@property (nonatomic,copy) NSString * mobile_model;//手机型号
@property (nonatomic,copy) NSString * mobile_brand;//手机品牌
@property (nonatomic,copy) NSString * token;//用户登录后分配的登录Token
@end
