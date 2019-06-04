//
//  UIViewController+CakeTree.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/6/3.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "UIViewController+CakeTree.h"

@implementation UIViewController (CakeTree)

#pragma mark - life cycle

#pragma mark - delegate



#pragma mark - event response

- (void)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - public methods

- (void)setCakeTreeBackBtn {
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"ct_icon_back"] forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    H [10][backBtn[40]].cut();
    V [@(KStatusBarHeight+10)][backBtn[40]].cut();
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters




@end
