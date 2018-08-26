//
//  UIView+RYKit.m
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import "UIView+RYKit.h"
#import "RYConstants.h"

@implementation UIView (RYKit)

- (UIView *(^)(CGRect))RYViewframe {
    weak_Self;
    return ^UIView* (CGRect frame) {
        strong_Self;
        strongSelf.frame = frame;
        return strongSelf;
    };
}

- (UIView *(^)(UIColor *))RYViewBackgroundColor {
    weak_Self;
    return ^UIView* (UIColor *backgroundColor) {
        strong_Self;
        strongSelf.backgroundColor = backgroundColor;
        return strongSelf;
    };
}

- (UIView *(^)(CGFloat))RYViewCornerRadius {
    weak_Self;
    return ^UIView* (CGFloat size) {
        strong_Self;
        strongSelf.layer.cornerRadius = size;
        strongSelf.layer.masksToBounds = YES;
        return strongSelf;
    };
}


@end
