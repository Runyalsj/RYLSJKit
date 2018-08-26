//
//  RYNetStateView.m
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import "RYNetStateView.h"
#import "RYConstants.h"
#import "RYKitHear.h"
#import <AFNetworking/AFNetworking.h>

@interface RYNetStateView()

@property (assign, nonatomic) SEL action;
@property (strong, nonatomic) UIImage *bgImage;
@end


@implementation RYNetStateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.hidden = YES;
        self.backgroundColor = [UIColor whiteColor];
        NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath
                                stringByAppendingPathComponent:@"/RYKit.bundle"];
        NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
        self.bgImage = [UIImage imageNamed:@"bg_noserver.png"
                                  inBundle:resource_bundle
             compatibleWithTraitCollection:nil];
        [self addSubview:self.netImage];
        [self addSubview:self.netLabel];
        [self addSubview:self.button];
        [self monitorNetworkStatus];
    }
    return self;
}


- (UIImageView *)netImage {
    if (!_netImage) {
        _netImage = UIImageView.new
        .RYImageViewframe(CGRectMake((RY_KScreenWidth - 266/2)/2, 150, 266/2, 204/2))
        .RYImageViewimage(self.bgImage);
    }
    return _netImage;
}


- (UILabel *)netLabel {
    if (!_netLabel) {
        _netLabel = UILabel.new
        .RYLabelFrame(CGRectMake(0, CGRectGetMaxY(self.netImage.frame), RY_KScreenWidth, 40))
        .RYLabelTextColor([UIColor lightGrayColor])
        .RYLabelNumberOfLines(0)
        .RYLabelFont(14)
        .RYLabelText(@"网络似乎断了，请刷新重试")
        .RYLabelTextAligment(NSTextAlignmentCenter);
    }
    return _netLabel;
}

- (UIButton *)button {
    if (!_button) {
        _button = UIButton.new
        .RYButtonFrame(CGRectMake(RY_KScreenWidth/2 - 280/4, CGRectGetMaxY(self.netImage.frame) + 40, 280/2, 75/2))
        .RYButtonTitle(@"刷新")
        .RYButtonTitleColor([UIColor lightGrayColor])
        .RYButtonLabelFont(16)
        .RYButtonCornerRadius(75/4);
        [_button addTarget:self action:@selector(tryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}


#pragma mark ————— 网络状态监听 —————
- (void)monitorNetworkStatus
{
    WS(weakSelf);
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    [RYNetworkHelper networkStatusWithBlock:^(RYNetworkStatusType networkStatus) {
        switch (networkStatus) {
                // 未知网络
            case RYNetworkStatusUnknown:
                RYLog(@"网络环境：未知网络");
                weakSelf.hidden = NO;
                weakSelf.netImage.image = self.bgImage;
                weakSelf.netLabel.text = @"网络似乎断了，请刷新重试";
                // 无网络
            case RYNetworkStatusNotReachable:
                RYLog(@"网络环境：无网络");
                weakSelf.hidden = NO;
                weakSelf.netImage.image = self.bgImage;
                weakSelf.netLabel.text = @"网络似乎断了，请刷新重试";
                break;
                // 手机网络
            case RYNetworkStatusReachableViaWWAN:
                RYLog(@"网络环境：手机自带网络");
                weakSelf.hidden = NO;
                weakSelf.netImage.image = self.bgImage;
                weakSelf.netLabel.text = @"网络似乎断了，请刷新重试";
                // 无线网络
            case RYNetworkStatusReachableViaWiFi:
                RYLog(@"网络环境：WiFi");
                weakSelf.hidden = NO;
                weakSelf.netImage.image = self.bgImage;
                weakSelf.netLabel.text = @"网络似乎断了，请刷新重试";
                break;
        }
    }];
}



//- (void)netState {
//    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
//    [manager startMonitoring];
//    switch (manager.networkReachabilityStatus) {
//        case AFNetworkReachabilityStatusUnknown: {
//            NSLog(@"未知网络");
//            self.hidden = NO;
//            self.netImage.image = self.bgImage;
//            self.netLabel.text = @"网络似乎断了，请刷新重试";
//        }
//            break;
//        case AFNetworkReachabilityStatusNotReachable: {
//            NSLog(@"没有网络");
//            self.hidden = NO;
//            self.netImage.image = self.bgImage;
//            self.netLabel.text = @"网络似乎断了，请刷新重试";
//        }
//            break;
//        case AFNetworkReachabilityStatusReachableViaWWAN: {
//            NSLog(@"手机自带网络");
//            self.netImage.image = self.bgImage;
//            self.netLabel.text = @"网络似乎断了，请刷新重试";
//            [self serverStatus];
//        }
//            break;
//        case AFNetworkReachabilityStatusReachableViaWiFi: {
//            NSLog(@"WIFI");
//            self.netImage.image = self.bgImage;
//            self.netLabel.text = @"网络似乎断了，请刷新重试";
//            [self serverStatus];
//        }
//            break;
//    }
//}

- (void)serverStatus {
    
    self.netImage.image = self.bgImage;
    self.netLabel.text = @"服务器维护中，请刷新重试";
    self.hidden = NO;
//    KZWRequestServerstatus *requestServerstatus = [KZWRequestServerstatus new];
//    [requestServerstatus startRequestComplete:^(id object, NSError *error) {
//        if (error.code == 500) {
//            self.netImage.image = self.bgImage;
//            self.netLabel.text = @"服务器维护中，请刷新重试";
//            self.hidden = NO;
//        }
//    }];
}

- (void)showLoadFailedNoticeWithAction:(SEL)action isWeb:(BOOL)isWeb {
    _action = action;
    if (isWeb) {
        [self monitorNetworkStatus];
    }else{
        [self monitorNetworkStatus];
        self.hidden = NO;
    }
}


//重新请求
- (void)tryButtonClick:(UIButton *)sender {
    !_tryButtonBlock ?:_tryButtonBlock(sender);
}



//- (void)removeNotice(UIButton *)sender {
////    if (self.action) {
////        if ([self.delegate respondsToSelector:@selector(netStateViewWithAction:)]) {
////            [self.delegate netStateViewWithAction:self.action];
////        }
////        self.action = nil;
////    }
//
//}


@end
