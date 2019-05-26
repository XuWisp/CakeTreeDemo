//
//  CakeForestView.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeForestView.h"
#import "UIResponder+Router.h"

NSString * const kCakeForestMyTreeBtnClick = @"kCakeForestMyTreeBtnClick";

@interface CakeForestView ()

@property (nonatomic, strong) UIButton *myTreeBtn;
@property (nonatomic, strong) UITableView *tableV;

@end

@implementation CakeForestView

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.myTreeBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 做布局的事情
    [self.myTreeBtn centerEqualToView:self];
    [self.myTreeBtn setCt_size:CGSizeMake(300, 300)];
}

#pragma mark - delegate



#pragma mark - event response

- (void)btnClick:(id)sender {
    [self.myTreeBtn routerEventWithName:kCakeForestMyTreeBtnClick userInfo:@{}];
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UIButton *)myTreeBtn {
    if (!_myTreeBtn) {
        _myTreeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_myTreeBtn setTitle:@"我的幸福蛋糕树" forState:(UIControlStateNormal)];
        [_myTreeBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _myTreeBtn;
}

- (UITableView *)tableV {
    if (!_tableV) {
        _tableV = [[UITableView alloc] init];
        _tableV.dataSource = self.tvDataSource;
        _tableV.delegate = self.tvDelegate;
    }
    return _tableV;
}


@end
