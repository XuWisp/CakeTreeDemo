//
//  CakeTreeViewController.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeTreeViewController.h"

#import "CakeTreeView.h"

@interface CakeTreeViewController ()

@end

@implementation CakeTreeViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // 只做addSubview的事情
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // 做布局的事情
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Notification的监听之类的事情
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - delegate



#pragma mark - event response


#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters



@end
