//
//  CakeForestViewController.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeForestViewController.h"
#import "CakeTreeViewController.h"
#import "ZLPhotoBrowser.h"
#import "CakeTreeEditViewController.h"
#import <zhPopupController/zhPopupController.h>

#import "CakeForestView.h"
#import "CakeForestHeaderView.h"
#import "CakeTreeNickView.h"

extern NSString * const kCakeForestMyTreeBtnClick;
extern NSString * const kCakeForestPunchBtnClick;
extern NSString * const kCakeForestStarBtnClick;
extern NSString * const kCakeForestDeleteBtnClick;

@interface CakeForestViewController () <CTNickViewDelegate>

@property (nonatomic, strong) CakeForestView * mainV;
@property (nonatomic, strong) CakeTreeNickView * nickV;
@property (nonatomic, strong) NSDictionary * eventStrategy;

@end

@implementation CakeForestViewController


#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // 只做addSubview的事情
    [self.view addSubview:self.mainV];
    // 初始化
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [MomentUtil initMomentData];
    });
    UIButton *btn = [[UIButton alloc] initWithFrame:(CGRectMake(0, 0, kScreenH, 100))];
    [btn addTarget:self action:@selector(adddata) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

- (void)adddata {
    [self.mainV configWithData:@{}];
    self.nickV.frame = CGRectMake(0,0,262.5,173);
    self.zh_popupController = [zhPopupController new];
    self.zh_popupController.dismissOnMaskTouched = NO;
    self.zh_popupController.dismissOppositeDirection = YES;
    self.zh_popupController.slideStyle = zhPopupSlideStyleShrinkInOut1;
    [self.zh_popupController presentContentView:self.nickV duration:0.75 springAnimated:YES];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // 做布局的事情
    [self.mainV fill];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Notification的监听之类的事情
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CTNickViewDelegate

- (void)nickViewConfirmBtnClick {
    NSLog(@"\nnickViewConfirmBtnClick");
}

- (void)nickViewCancelBtnClick {
    [self.zh_popupController dismiss];
}

#pragma mark - event response
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&userInfo atIndex:2];
    [invocation invoke];

    
    // 如果需要让事件继续往上传递，则调用下面的语句
    // [super routerEventWithName:eventName userInfo:userInfo];
}

- (void)treeBtnClick:(NSDictionary *)userInfo {
    CakeTreeViewController *ctVC = [[CakeTreeViewController alloc] init];
    [self.navigationController pushViewController:ctVC animated:YES];
}

- (void)punchBtnClick:(NSDictionary *)userInfo {
    // 自己需要在这个地方进行图片或者视频的保存
    ZLPhotoActionSheet *ac = [[ZLPhotoActionSheet alloc] init];
    // 相册参数配置，configuration有默认值，可直接使用并对其属性进行修改
    ac.configuration.maxSelectCount = 9;
    //如调用的方法无sender参数，则该参数必传
    ac.sender = self;
    // 选择回调
    [ac setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        //your codes
        CakeTreeEditViewController *vc = [[CakeTreeEditViewController alloc] init];
        [self showViewController:vc sender:nil];
        NSDictionary *dic = @{
                              @"images" : [images mutableCopy],
                              @"assets" : [assets mutableCopy],
                              @"isOriginal" : @(isOriginal),
                              @"text" : @"",
                              };
        [vc configWithData:dic];
    }];
    // 调用相册
    [ac showPreviewAnimated:YES];
}

- (void)starBtnClick:(NSDictionary *)userInfo {
    NSLog(@"\nstar\n%@", userInfo);
}

- (void)deleteBtnClick:(NSDictionary *)userInfo {
    NSLog(@"\ndelete\n%@", userInfo);
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (CakeForestView *)mainV {
    if (!_mainV) {
        _mainV = [[CakeForestView alloc] init];
    }
    return _mainV;
}

- (CakeTreeNickView *)nickV {
    if (!_nickV) {
        _nickV = [[CakeTreeNickView alloc] init];
        _nickV.delegate = self;
    }
    return _nickV;
}

- (NSDictionary *)eventStrategy {
    if (_eventStrategy == nil) {
        _eventStrategy = @{
                           kCakeForestMyTreeBtnClick : [self createInvocationWithSelector:@selector(treeBtnClick:)],
                           kCakeForestPunchBtnClick : [self createInvocationWithSelector:@selector(punchBtnClick:)],
                           kCakeForestStarBtnClick : [self createInvocationWithSelector:@selector(starBtnClick:)],
                           kCakeForestDeleteBtnClick : [self createInvocationWithSelector:@selector(deleteBtnClick:)],
                           };
    }
    return _eventStrategy;
}

@end
