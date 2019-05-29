//
//  CakeTreeView.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeTreeView.h"
#import "YLGIFImage.h"
#import "YLImageView.h"

NSString * const kCakeTreeLvlUpBtnClick = @"kCakeTreeLvlUpBtnClick";

@interface CakeTreeView ()

@property (nonatomic, strong) UIImageView *backgroundImgV;
@property (nonatomic, strong) NSArray *lvlImgVArr;
@property (nonatomic, strong) UIImageView *giftImgV;
@property (nonatomic, strong) YLImageView *lvlUpGIFImgV;
@property (nonatomic, strong) YLImageView *beeGIFImgV;

@property (nonatomic, strong) UIProgressView *progressV;
@property (nonatomic, strong) UILabel *levelLbl;
@property (nonatomic, strong) UIButton *ticketBtn;

@property (nonatomic, strong) UIButton *lvlUpBtn;

@end

@implementation CakeTreeView


#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroundImgV];
        [self addSubview:self.giftImgV];
        [self addSubview:self.lvlUpGIFImgV];
        [self addSubview:self.beeGIFImgV];
        
        [self addSubview:self.progressV];
        [self addSubview:self.levelLbl];
        [self addSubview:self.ticketBtn];
        [self addSubview:self.lvlUpBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [self.backgroundImgV fill];
    [self.backgroundImgV setCt_height:kScreenW*1623/750];
    
    [self.beeGIFImgV fill];
    [self.beeGIFImgV setCt_height:kScreenW*1334/750];
    self.giftImgV.frame = self.beeGIFImgV.frame;
    self.lvlUpGIFImgV.frame = self.beeGIFImgV.frame;
    
    [self.lvlUpBtn fill];
    [self.lvlUpBtn setSize:CGSizeMake(375, 300) screenType:(UIScreenType_iPhone6)];
}

#pragma mark - delegate



#pragma mark - event response

- (void)lvlUpBtnClick:(UIButton *)btn {
    [self routerEventWithName:kCakeTreeLvlUpBtnClick userInfo:@{}];
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - public methods
- (void)addTreeLevelImageByLevel:(NSUInteger)level {
    CGRect frame = CGRectMake(0, 0, kScreenW, kScreenW*1334/750);
    for (int i= 0; i<=level; i++) {
        UIImageView *imgV = [[UIImageView alloc] initWithFrame:frame];
        imgV.image = [UIImage imageNamed:self.lvlImgVArr[i]];
        [self insertSubview:imgV belowSubview:self.giftImgV];
    }
}

- (void)treeLevelUpToLevel:(NSUInteger)level {
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:self.giftImgV.frame];
    imgV.image = [UIImage imageNamed:self.lvlImgVArr[level]];
    [self insertSubview:imgV belowSubview:self.giftImgV];
    imgV.alpha= 0;
    YLGIFImage *gifImage = (YLGIFImage *)[YLGIFImage imageNamed:@"lvlup.gif"];
    gifImage.loopCount = 1;
    self.lvlUpGIFImgV.image = gifImage;
    [UIView animateWithDuration:2 animations:^{
        imgV.alpha= 1;
    } completion:nil];
}

#pragma mark - getters and setters

- (UIImageView *)backgroundImgV {
    if (!_backgroundImgV) {
        _backgroundImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"caketree_background"]];
    }
    return _backgroundImgV;
}

- (YLImageView *)lvlUpGIFImgV {
    if (!_lvlUpGIFImgV) {
        _lvlUpGIFImgV = [[YLImageView alloc] init];
    }
    return _lvlUpGIFImgV;

}

- (YLImageView *)beeGIFImgV {
    if (!_beeGIFImgV) {
        _beeGIFImgV = [[YLImageView alloc] init];
        YLGIFImage *gifImage = (YLGIFImage *)[YLGIFImage imageNamed:@"bee.gif"];
        gifImage.loopCount = 1;
        _beeGIFImgV.image = gifImage;
    }
    return _beeGIFImgV;
}

- (UIImageView *)giftImgV {
    if (!_giftImgV) {
        _giftImgV = [[UIImageView alloc] init];
        _giftImgV.image = [UIImage imageNamed:@"caketree_gift"];
    }
    return _giftImgV;
}

- (UIButton *)lvlUpBtn {
    if (!_lvlUpBtn) {
        _lvlUpBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_lvlUpBtn setTitle:@"升级" forState:(UIControlStateNormal)];
        [_lvlUpBtn addTarget:self action:@selector(lvlUpBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _lvlUpBtn;
}

- (NSArray *)lvlImgVArr {
    if (!_lvlImgVArr) {
        _lvlImgVArr = @[@"lvl0", @"lvl1", @"lvl2", @"lvl3", @"lvl4", @"lvl5", @"lvl6", ];
    }
    return _lvlImgVArr;
}

@end
