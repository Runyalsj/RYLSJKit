//
//  UITableView+RYKit.m
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import "UITableView+RYKit.h"
#import "UIColor+RYKit.h"
#import "RYNetStateView.h"
#import "RYConstants.h"

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

- (void)showNoDataView:(NSArray *)array {
    NSString *bundlePath = [[NSBundle bundleForClass:[RYNetStateView class]].resourcePath
                            stringByAppendingPathComponent:@"/RYKit.bundle"];
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    UIImage *image = [UIImage imageNamed:@"bg_nodata.png"
                                inBundle:resource_bundle
           compatibleWithTraitCollection:nil];
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(( RY_KScreenWidth- 150)/2, (RY_KScreenHeight - 150)/2, 150, 150)];
    imageview.center = self.center;
    imageview.image = image;
    
    self.backgroundView = imageview;
    if (array.count > 0) {
        self.backgroundView.hidden = YES;
    }else {
        self.backgroundView.hidden = NO;
    }
}


@end
