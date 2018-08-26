//
//  UILabel+RYKit.m
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import "UILabel+RYKit.h"
#import "RYConstants.h"

@implementation UILabel (RYKit)


- (UILabel *(^)(CGRect))RYLabelFrame {
    weak_Self;
    return ^UILabel *(CGRect rect) {
        strong_Self;
        strongSelf.frame = rect;
        return strongSelf;
    };
}

- (UILabel *(^)(UIColor *))RYLabelTextColor {
    weak_Self;
    return ^UILabel *(UIColor *color) {
        strong_Self;
        strongSelf.textColor = color;
        return strongSelf;
    };
}

-(UILabel *(^)(CGFloat))RYLabelFont {
    weak_Self;
    return ^UILabel* (CGFloat fontSize) {
        strong_Self;
        strongSelf.font = [[UIDevice currentDevice].systemVersion integerValue] < 9 ? [UIFont systemFontOfSize:fontSize]: [UIFont fontWithName:@"PingFang SC" size:fontSize];
        return strongSelf;
    };
}

- (UILabel *(^)(NSString *))RYLabelText {
    weak_Self;
    return ^UILabel *(NSString *text) {
        strong_Self;
        strongSelf.text = text;
        return strongSelf;
    };
}


- (UILabel *(^)(NSTextAlignment))RYLabelTextAligment {
    weak_Self;
    return ^UILabel *(NSTextAlignment textAligment) {
        strong_Self;
        strongSelf.textAlignment = textAligment;
        return strongSelf;
    };
}

-(UILabel *(^)(NSInteger))RYLabelNumberOfLines {
    weak_Self;
    return ^UILabel *(NSInteger num) {
        strong_Self;
        strongSelf.numberOfLines = num;
        return strongSelf;
    };
}

@end
