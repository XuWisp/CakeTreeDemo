//
//  CakeForestViewController.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeForestViewController.h"
#import "CakeTreeViewController.h"

#import "CakeForestView.h"

@interface CakeForestViewController () <TargetDelegate>

@property (nonatomic, strong) CakeForestView * mainV;

@end

@implementation CakeForestViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // 只做addSubview的事情
    [self.view addSubview:self.mainV];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // 做布局的事情
    [self.mainV fill];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Notification的监听之类的事情
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TargetDelegate

- (void)eventResponseWithSender:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        CakeTreeViewController *ctVC = [[CakeTreeViewController alloc] init];
        [self.navigationController pushViewController:ctVC animated:YES];
    }
}

#pragma mark - event response


#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (CakeForestView *)mainV {
    if (!_mainV) {
        _mainV = [[CakeForestView alloc] init];
        _mainV.targetDelegate = self;
    }
    return _mainV;
}


@end
