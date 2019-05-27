//
//  CakeTreeViewController.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeTreeViewController.h"

#import "CakeTreeView.h"

extern NSString * const kCakeTreeLvlUpBtnClick;

@interface CakeTreeViewController ()

@property (nonatomic, strong) CakeTreeView *mainV;
@property (nonatomic, strong) NSDictionary * eventStrategy;
@property (nonatomic, assign) NSUInteger level;

@end

@implementation CakeTreeViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mainV];
    [self layoutViewSubviews];
    [self.mainV addTreeLevelImageByLevel:0];
}

- (void)layoutViewSubviews {
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

#pragma mark - delegate



#pragma mark - event response

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&userInfo atIndex:2];
    [invocation invoke];    
}

- (void)treeLvlUpBtnClick:(NSDictionary *)userInfo {
    if (self.level < 6) {
        self.level++;
        [self.mainV treeLevelUpToLevel:self.level];
        return;
    }
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (CakeTreeView *)mainV {
    if (!_mainV) {
        _mainV = [[CakeTreeView alloc] init];
    }
    return _mainV;
}

- (NSDictionary *)eventStrategy {
    if (_eventStrategy == nil) {
        _eventStrategy = @{
                           kCakeTreeLvlUpBtnClick : [self createInvocationWithSelector:@selector(treeLvlUpBtnClick:)],
                           };
    }
    return _eventStrategy;
}

@end
