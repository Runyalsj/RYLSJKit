//
//  UIButton+RYKit.m
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import "UIButton+RYKit.h"
#import "RYConstants.h"

@implementation UIButton (RYKit)

- (UIButton *(^)(CGRect))RYButtonFrame {
    weak_Self;
    return ^UIButton *(CGRect rect) {
        strong_Self;
        strongSelf.frame = rect;
        return strongSelf;
    };
}

- (UIButton *(^)(NSString *))RYButtonTitle {
    weak_Self;
    return ^UIButton *(NSString *title) {
        strong_Self;
        [strongSelf setTitle:title forState:UIControlStateNormal];
        return strongSelf;
    };
}

- (UIButton *(^)(UIColor *))RYButtonTitleColor {
    weak_Self;
    return ^UIButton *(UIColor *color) {
        strong_Self;
        [strongSelf setTitleColor:color forState:UIControlStateNormal];
        return strongSelf;
    };
}

- (UIButton *(^)(CGFloat))RYButtonCornerRadius {
    weak_Self;
    return ^UIButton *(CGFloat size) {
        strong_Self;
        strongSelf.layer.cornerRadius = size;
        strongSelf.layer.masksToBounds = YES;
        return strongSelf;
    };
}

- (UIButton *(^)(UIImage *))RYButtonImage {
    weak_Self;
    return ^UIButton *(UIImage *image) {
        strong_Self;
        [strongSelf setImage:image forState:UIControlStateNormal];
        return strongSelf;
    };
}

- (UIButton *(^)(UIImage *))RYButtonBackgroundImage {
    weak_Self;
    return ^UIButton *(UIImage *image) {
        strong_Self;
        [strongSelf setBackgroundImage:image forState:UIControlStateNormal];
        return strongSelf;
    };
}

- (UIButton *(^)(CGFloat))RYButtonLabelFont {
    weak_Self;
    return ^UIButton *(CGFloat labelFont) {
        strong_Self;
        [strongSelf.titleLabel setFont:[UIFont systemFontOfSize:labelFont]];
        return strongSelf;
    };
}

- (UIButton *(^)(UIColor *))RYButtonBackgroundColor {
    weak_Self;
    return ^UIButton *(UIColor *color) {
        strong_Self;
        [strongSelf setBackgroundColor:color];
        return strongSelf;
    };
}

- (UIButton *(^)(UIEdgeInsets))RYButtonTitleEdgeInsets {
    weak_Self;
    return ^UIButton *(UIEdgeInsets titleEdgeInsets) {
        strong_Self;
        strongSelf.titleEdgeInsets = titleEdgeInsets;
        return strongSelf;
    };
}

- (UIButton *(^)(UIEdgeInsets))RYButtonContentEdgeInsets {
    weak_Self;
    return ^UIButton *(UIEdgeInsets contentEdgeInsets) {
        strong_Self;
        strongSelf.contentEdgeInsets = contentEdgeInsets;
        return strongSelf;
    };
}

- (UIButton *(^)(CGFloat))RYButtonBorderWidth {
    weak_Self;
    return ^UIButton *(CGFloat borderWidth) {
        strong_Self;
        strongSelf.layer.borderWidth = borderWidth;
        return strongSelf;
    };
}

- (UIButton *(^)(UIColor *))RYButtonBorderColor {
    weak_Self;
    return ^UIButton *(UIColor *borderColor) {
        strong_Self;
        strongSelf.layer.borderColor = borderColor.CGColor;
        return strongSelf;
    };
}

- (UIButton *(^)(BOOL))RYButtonHidden {
    weak_Self;
    return ^UIButton *(BOOL hidden) {
        strong_Self;
        strongSelf.hidden = hidden;
        return strongSelf;
    };
}

@end
