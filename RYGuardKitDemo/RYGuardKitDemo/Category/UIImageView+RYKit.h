//
//  UIImageView+RYKit.h
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RYConstants.h"

@interface UIImageView (RYKit)

#pragma mark - UIView
- (UIImageView* (^)(CGRect))RYImageViewframe;
- (UIImageView* (^)(UIColor *))RYImageViewbackgroundColor;

#pragma mark - UIView
- (UIImageView* (^)(UIImage *))RYImageViewimage;
- (UIImageView* (^)(BOOL))RYImageViewUserInteractionEnabled;

- (UIImageView* (^)(UIViewContentMode))RYImageViewContentMode;
- (UIImageView* (^)(BOOL))RYImageViewClipsToBounds;
//设置imageView的切角  默认是剪切的
- (UIImageView* (^)(CGFloat))RYImageViewCornerRadius;

@end
