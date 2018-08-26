//
//  UIButton+RYKit.h
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (RYKit)

#pragma mark - UIView
- (UIButton* (^)(CGRect))RYButtonFrame;
- (UIButton* (^)(UIColor *))RYButtonBackgroundColor;


- (UIButton* (^)(NSString *))RYButtonTitle;
- (UIButton* (^)(UIColor *))RYButtonTitleColor;
- (UIButton* (^)(UIImage *))RYButtonImage;
- (UIButton* (^)(UIImage *))RYButtonBackgroundImage;


//设置button的切角  默认是剪切的
- (UIButton* (^)(CGFloat))RYButtonCornerRadius;
//字体大小
- (UIButton* (^)(CGFloat))RYButtonLabelFont;
- (UIButton* (^)(CGFloat))RYButtonBorderWidth;
- (UIButton* (^)(UIColor *))RYButtonBorderColor;


- (UIButton *(^)(UIEdgeInsets))RYButtonContentEdgeInsets;
- (UIButton *(^)(UIEdgeInsets))RYButtonTitleEdgeInsets;

- (UIButton *(^)(BOOL))RYButtonHidden;
@end
