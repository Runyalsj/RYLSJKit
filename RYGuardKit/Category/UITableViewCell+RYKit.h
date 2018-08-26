//
//  UITableViewCell+RYKit.h
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableViewCell (RYKit)
///返回当前cell的标识符
+ (NSString *)reuseId;
@end

@interface UICollectionViewCell (RYKit)
//标识符
+ (NSString *)reuseId;
@end



