//
//  HeaderModel.m
//  FlowerTown
//
//  Created by 兔兔 on 2018/8/13.
//  Copyright © 2018年 HuaZhen. All rights reserved.
//

#import "HeaderModel.h"
@implementation HeaderModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.userId = @"6666666";
        self.mobile_id = @"1234";
        self.origin = 2;
        self.token = @"123456";
        self.api_version = @"2.0";
    }
    return self;
}
@end
