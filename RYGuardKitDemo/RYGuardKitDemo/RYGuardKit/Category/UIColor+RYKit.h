//
//  UIColor+RYKit.h
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif

@interface UIColor (RYKit)


+ (nullable UIColor *)colorWithHexString:(NSString *)hexStr;

@end
