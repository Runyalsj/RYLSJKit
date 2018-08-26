//
//  ViewController.m
//  RYGuardKitDemo
//
//  Created by 兔兔 on 2018/8/26.
//  Copyright © 2018年 tutu. All rights reserved.
//

#import "ViewController.h"
#import "RYKitHear.h"
#import "RYNetStateView.h"

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *dataSoureArr;
@end

@implementation ViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain separatorStyle:UITableViewCellSeparatorStyleNone automatic:true];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:UITableViewCell.reuseId];
    }
    return _tableView;
}

- (NSArray *)dataSoureArr {
    if (!_dataSoureArr) {
        _dataSoureArr = [NSArray array];
    }
    return _dataSoureArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    [self setLayouts];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setUpViews {
    [self.view addSubview:self.tableView];
    //[self.tableView showNoDataView:self.dataSoureArr];
    RYNetStateView *view = [[RYNetStateView alloc] initWithFrame:UIScreen.mainScreen.bounds];
    //[view showLoadFailedNoticeWithAction:@selector(tryRefresh) isWeb:false];
    view.hidden = false;
    view.tryButtonBlock = ^(UIButton *sender) {
        NSLog(@"重新请求");
    };
    [self.tableView addSubview:view];
}

- (void)tryRefresh {
    NSLog(@"重新尝试");
}

- (void)setLayouts {
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        //make.edges.mas_equalTo(self.view);
        make.top.right.left.bottom.mas_equalTo(self.view);
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.dataSoureArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCell.reuseId forIndexPath:indexPath];
    cell.textLabel.text = @"runya";
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
