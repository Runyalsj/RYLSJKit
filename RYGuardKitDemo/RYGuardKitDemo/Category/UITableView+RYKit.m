//
//  UITableView+RYKit.m
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import "UITableView+RYKit.h"
#import "UIColor+RYKit.h"

@implementation UITableView (RYKit)

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style
               separatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
                    automatic:(BOOL)automatic {
    if (self = [self initWithFrame:frame style:style]) {
        self.estimatedSectionFooterHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.backgroundColor = UIColorHex(#f0f0f0);
        self.tableHeaderView = self.tableFooterView =  ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.01, 0.01)];
            view;
        });
        self.showsVerticalScrollIndicator = false;
        self.estimatedRowHeight = 44;
        if (automatic) {
            self.rowHeight = UITableViewAutomaticDimension;
        }
    }
    return self;
}
@end
