//
//  CakeTreeEditViewController.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeTreeEditViewController.h"
#import <zhPopupController/zhPopupController.h>
#import "ZLPhotoBrowser.h"
#import "UIViewController+CakeTree.h"

#import "CakeTreeEditView.h"
#import "CakeTreeEditSaveView.h"

extern NSString * const kCakeTreeEditSelectCV;

@interface CakeTreeEditViewController ()

@property (nonatomic, strong) CakeTreeEditView *mainV;

@property (nonatomic, copy) NSDictionary *dataDic;
@property (nonatomic, strong) NSDictionary * eventStrategy;

@end

@implementation CakeTreeEditViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    CakeTreeEditSaveView *view = [[CakeTreeEditSaveView alloc] init];
//    view.frame= CGRectMake(0, 0, 263, 132);
//    self.zh_popupController = [zhPopupController new];
//    self.zh_popupController.dismissOnMaskTouched = NO;
//    self.zh_popupController.dismissOppositeDirection = YES;
//    self.zh_popupController.slideStyle = zhPopupSlideStyleShrinkInOut2;
//    [self.zh_popupController presentContentView:view duration:0.75 springAnimated:YES];
    [self.view addSubview:self.mainV];
    [self layoutViewSubviews];
    [self setCakeTreeBackBtn];
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

- (void)didSelectItemAtIndexPath:(NSDictionary *)userInfo {
    NSIndexPath *indexPath = userInfo[@"indexPath"];
    NSArray *images = self.dataDic[@"images"];
    ZLPhotoActionSheet *actionSheet = [[ZLPhotoActionSheet alloc] init];
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = self;
    if (images.count<9 &&
        indexPath.row == images.count) {
        // 点到加图时
        actionSheet.configuration.maxSelectCount = 9-images.count;
        [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            NSMutableArray *imageMArr = self.dataDic[@"images"];
            [imageMArr addObjectsFromArray:images];
            NSMutableArray *assetMArr = self.dataDic[@"assets"];
            [assetMArr addObjectsFromArray:assets];
            NSDictionary *dic = @{
                                  @"images" : imageMArr,
                                  @"assets" : assetMArr,
                                  @"isOriginal" : @(isOriginal),
                                  @"text" : @"",
                                  };
            [self configWithData:dic];
        }];
        // 调用相册
        [actionSheet showPreviewAnimated:YES];
    }else {
        @zl_weakify(self);
        [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            @zl_strongify(self);
            NSDictionary *dic = @{
                                  @"images" : images,
                                  @"assets" : assets,
                                  @"isOriginal" : @(isOriginal),
                                  @"text" : self.dataDic[@"text"],
                                  };
            
            [self configWithData:dic];
        }];
        BOOL isOriginal = [self.dataDic[@"isOriginal"] integerValue];
        [actionSheet previewSelectedPhotos:self.dataDic[@"images"] assets:self.dataDic[@"assets"] index:indexPath.row isOriginal:isOriginal];
    }
}

#pragma mark - public methods

- (void)configWithData:(NSDictionary *)data {
    self.dataDic = data;
    [self.mainV configWithData:data];
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (CakeTreeEditView *)mainV {
    if (!_mainV) {
        _mainV = [[CakeTreeEditView alloc] init];
    }
    return _mainV;
}

- (NSDictionary *)eventStrategy {
    if (_eventStrategy == nil) {
        _eventStrategy = @{
                           kCakeTreeEditSelectCV : [self createInvocationWithSelector:@selector(didSelectItemAtIndexPath:)],
                           };
    }
    return _eventStrategy;
}


@end
