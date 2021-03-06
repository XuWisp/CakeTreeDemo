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
#import "LRAnimationProgress.h"

NSString * const kCakeTreeLvlUpBtnClick = @"kCakeTreeLvlUpBtnClick";

@interface CakeTreeView ()

@property (nonatomic, strong) UIImageView *backgroundImgV;
@property (nonatomic, strong) NSArray *lvlImgVArr;
@property (nonatomic, strong) UIImageView *giftImgV;
@property (nonatomic, strong) YLImageView *lvlUpGIFImgV;
@property (nonatomic, strong) YLImageView *beeGIFImgV;

@property (nonatomic, strong) UIView *pv_backgroundView;
@property (nonatomic, strong) LRAnimationProgress *progressV;
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
        
        [self addSubview:self.pv_backgroundView];
        [self.pv_backgroundView addSubview:self.progressV];
        [self addSubview:self.levelLbl];
        [self addSubview:self.ticketBtn];
        [self addSubview:self.lvlUpBtn];
        [self VFLlayout];
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
    
    [self.pv_backgroundView setSize:(CGSizeMake(304, 19)) screenType:(UIScreenType_iPhone6)];
    [self.pv_backgroundView centerXEqualToView:self];
    [self.pv_backgroundView bottomInContainer:97 shouldResize:NO];
    self.pv_backgroundView.layer.cornerRadius = self.pv_backgroundView.ct_height/2;
    
    [self.progressV setSize:(CGSizeMake(300, 15)) screenType:(UIScreenType_iPhone6)];
    [self.progressV centerEqualToView:self.pv_backgroundView];
    self.progressV.progressCornerRadius = self.progressV.ct_height/2;

    [self.levelLbl fillWidth];
    self.levelLbl.ct_height = 18;
    [self.levelLbl fromTheTop:17 ofView:self.pv_backgroundView];
    
    [self.ticketBtn setSize:(CGSizeMake(109, 39)) screenType:(UIScreenType_iPhone6)];
    [self.ticketBtn right:19 FromView:self];
    [self.ticketBtn fromTheTop:39 ofView:self.pv_backgroundView];
}

- (void)VFLlayout {
    @[H,H,H,H,H].VFL[0] [@[_backgroundImgV,_beeGIFImgV,_giftImgV,_lvlUpGIFImgV,_levelLbl]] [0].end();
    H[35][_pv_backgroundView][35].end();
    H[_ticketBtn[109]][19].end();
    
    V[0][_backgroundImgV[@(kScreenW*1623/750)]].cut();
    @[V,V,V].VFL[0][@[_beeGIFImgV,_giftImgV,_lvlUpGIFImgV].VFL[@(kScreenW*1334/750)]].cut();
    V[_pv_backgroundView[19]] [17] [_levelLbl[18]] [7] [_ticketBtn[39]] [@(20+KMagrinBottom)].end();
    
    self.progressV.edge(UIEdgeInsetsMake(2, 2, 2, 2));
    self.lvlUpBtn.edge(UIEdgeInsetsMake(200, 2, 200, 2));
    self.pv_backgroundView.layer.cornerRadius = 19/2;
    self.progressV.progressCornerRadius = 15/2;
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
    self.levelLbl.text = [NSString stringWithFormat:@"%ld / 6", level];
    for (int i= 0; i<=level; i++) {
        UIImageView *imgV = [[UIImageView alloc] init];
        imgV.image = [UIImage imageNamed:self.lvlImgVArr[i]];
        [self insertSubview:imgV belowSubview:self.giftImgV];
        
        H[0][imgV][0].end();
        V[0][imgV[@(kScreenW*1334/750)]].cut();
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
    [self.progressV setProgress:level/6.0 animated:YES];
    self.levelLbl.text = [NSString stringWithFormat:@"%ld / 6", level];
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

- (UIView *)pv_backgroundView {
    if (!_pv_backgroundView) {
        _pv_backgroundView = [[UIView alloc] init];
        _pv_backgroundView.backgroundColor = UIColorFromHexA(0x000000, 0.5);
    }
    return _pv_backgroundView;
}

- (LRAnimationProgress *)progressV {
    if (!_progressV) {
        _progressV = [[LRAnimationProgress alloc] init];
        _progressV.backgroundColor = [UIColor clearColor];
        _progressV.progressTintColor = LRColorWithRGB(0xfca71e);
        _progressV.stripesWidth = 4;
        _progressV.hideAnnulus = YES;
        _progressV.stripesOrientation = LRStripesOrientationRight;
        _progressV.stripesColor = LRColorWithRGB(0xe3863d);
        _progressV.trackTintColor = LRColorWithRGBA(0x000000, 0.1);
        _progressV.progressViewInset = 3;
    }
    return _progressV;
}

- (UILabel *)levelLbl {
    if (!_levelLbl) {
        _levelLbl = [[UILabel alloc] init];
        _levelLbl.textColor = UIColorFromHex(0xFFD754);
        _levelLbl.font = [UIFont boldSystemFontOfSize:18];
        _levelLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _levelLbl;
}

- (UIButton *)ticketBtn {
    if (!_ticketBtn) {
        _ticketBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_ticketBtn setBackgroundImage:[UIImage imageNamed:@"ct_reward"] forState:(UIControlStateNormal)];
    }
    return _ticketBtn;
}

@end
