//
//  RYNetStateView.h
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol netStatueViewDelegate <NSObject>

- (void)netStateViewWithAction:(SEL)action;

@end

@interface RYNetStateView : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (strong, nonatomic) UIImageView *netImage;

@property (strong, nonatomic) UILabel *netLabel;

@property (strong, nonatomic) UIButton *button;

@property (nonatomic, weak) id<netStatueViewDelegate> delegate;

@property (nonatomic ,copy) void(^tryButtonBlock)(UIButton *); //重新请求

- (void)showLoadFailedNoticeWithAction:(SEL)action isWeb:(BOOL)isWeb;

@end
