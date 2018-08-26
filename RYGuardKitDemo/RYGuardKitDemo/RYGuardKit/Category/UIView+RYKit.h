//
//  UIView+RYKit.h
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RYKit)

- (UIView* (^)(CGRect))RYViewframe;
- (UIView* (^)(UIColor *))RYViewBackgroundColor;

//设置view的切角  默认是剪切的
- (UIView* (^)(CGFloat))RYViewCornerRadius;

@end
