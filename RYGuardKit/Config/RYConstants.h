//
//  RYConstants.h
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


#pragma mark 宏定义

#define RY_KScreenWidth [UIScreen mainScreen].bounds.size.width
#define RY_KScreenHeight [UIScreen mainScreen].bounds.size.height

#ifdef DEBUG
#define RYLog(...) printf("[%s] %s [第%d行]: %s\n", __TIME__ ,__PRETTY_FUNCTION__ ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#else
#define RYLog(...)
#endif

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self
#define weak_Self __weak typeof(self) weakSelf = self
#define strong_Self __strong typeof((weakSelf)) strongSelf = (weakSelf)

// iPhone X
#define  RY_iPhoneX (RY_KScreenWith == 375.f && RY_KScreenHeight == 812.f ? YES : NO)

// Status bar height.
#define  RY_StatusBarHeight      (RY_iPhoneX ? 44.f : 20.f)

#define  RY_PersonrHeight      (RY_iPhoneX ? 44.f : 30.f)


// Navigation bar height.
#define  RY_NavigationBarHeight  44.f

// Tabbar height.
#define  RY_TabbarHeight         (RY_iPhoneX ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  RY_TabbarSafeBottomMargin         (RY_iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  RY_StatusBarAndNavigationBarHeight  (RY_iPhoneX ? 88.f : 64.f)

#define RY_ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

