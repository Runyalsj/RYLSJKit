//
//  UIImageView+RYKit.m
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import "UIImageView+RYKit.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
@implementation UIImageView (RYKit)
#pragma clang diagnostic pop

#pragma mark - UIImageView
- (UIImageView* (^)(UIImage *))RYImageViewimage {
    weak_Self;
    return ^UIImageView *(UIImage *image) {
        strong_Self;
        strongSelf.image = image;
        return strongSelf;
    };
}

- (UIImageView *(^)(UIColor *))RYImageViewbackgroundColor {
    weak_Self;
    return ^UIImageView *(UIColor *color) {
        strong_Self;
        strongSelf.backgroundColor = color;
        return strongSelf;
    };
}

- (UIImageView *(^)(CGRect))RYImageViewframe {
    weak_Self;
    return ^UIImageView* (CGRect frame) {
        strong_Self;
        strongSelf.frame = frame;
        return strongSelf;
    };
}

- (UIImageView* (^)(BOOL))RYImageViewUserInteractionEnabled {
    weak_Self;
    return ^UIImageView *(BOOL userInteractionEnabled) {
        strong_Self;
        strongSelf.userInteractionEnabled = userInteractionEnabled;
        return strongSelf;
    };
}

- (UIImageView *(^)(UIViewContentMode))RYImageViewContentMode {
    weak_Self;
    return ^UIImageView *(UIViewContentMode mode) {
        strong_Self;
        strongSelf.contentMode = mode;
        return strongSelf;
    };
}


- (UIImageView *(^)(BOOL))RYImageViewClipsToBounds {
    weak_Self;
    return ^UIImageView *(BOOL isClipsToBounds) {
        strong_Self;
        strongSelf.clipsToBounds = isClipsToBounds;
        return strongSelf;
    };
}

- (UIImageView *(^)(CGFloat))RYImageViewCornerRadius {
    weak_Self;
    return ^UIImageView *(CGFloat size) {
        strong_Self;
        strongSelf.layer.cornerRadius = size;
        strongSelf.layer.masksToBounds = YES;
        return strongSelf;
    };
}
@end
