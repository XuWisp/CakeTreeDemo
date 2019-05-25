//
//  CakeForestView.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeForestView.h"

@interface CakeForestView ()


@end

@implementation CakeForestView

#pragma mark - Lifecycle



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


#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UIButton *)myTreeBtn {
    if (!_myTreeBtn) {
        _myTreeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_myTreeBtn setTitle:@"我的幸福蛋糕树" forState:(UIControlStateNormal)];
    }
    return _myTreeBtn;
}



@end
