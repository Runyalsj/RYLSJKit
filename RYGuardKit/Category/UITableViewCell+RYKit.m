//
//  UITableViewCell+RYKit.m
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import "UITableViewCell+RYKit.h"

@implementation UITableViewCell (RYKit)
+ (NSString *)reuseId {
    return NSStringFromClass(self);
}
@end


@implementation UICollectionViewCell (RYKit)
+ (NSString *)reuseId {
    return NSStringFromClass(self);
}
@end
