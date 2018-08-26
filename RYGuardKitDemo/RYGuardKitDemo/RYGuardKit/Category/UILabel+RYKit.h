//
//  UILabel+RYKit.h
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (RYKit)

// 加上lable是为了区分View之间的耦合程度  label也是集成View的
- (UILabel* (^)(CGRect))RYLabelFrame;
- (UILabel * (^)(UIColor *))RYLabelTextColor; //设置文字颜色
- (UILabel * (^)(CGFloat))RYLabelFont;    //设置字体大小
- (UILabel * (^)(NSString *))RYLabelText; //设置文字
- (UILabel * (^)(NSTextAlignment))RYLabelTextAligment; //设置位置
- (UILabel * (^)(NSInteger))RYLabelNumberOfLines; //这是line属性

@end
