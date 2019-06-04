//
//  CakeForestHeaderView.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/28.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeForestHeaderView.h"
#import "UILabel+String.h"

NSString * const kCakeForestPunchBtnClick = @"kCakeForestPunchBtnClick";

@interface CakeForestHeaderView ()

@property (nonatomic, strong) UIImageView *titleImgV;
@property (nonatomic, strong) UILabel *activitylbl;
@property (nonatomic, strong) UIButton *punchBtn;

@end

@implementation CakeForestHeaderView

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.titleImgV];
        [self addSubview:self.activitylbl];
        [self addSubview:self.punchBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 做布局的事情
    
    [self.titleImgV setCt_size:(CGSizeMake(192, 168))];
    [self.titleImgV centerXEqualToView:self];
    [self.titleImgV setCt_top:28];

    [self.activitylbl fillWidth];
    [self.activitylbl setCt_height:40];
    [self.activitylbl setCt_centerY:200];
    
    [self.punchBtn setCt_size:(CGSizeMake(109, 39))];
    [self.punchBtn centerXEqualToView:self];
    [self.punchBtn setCt_top:227];
}

#pragma mark - delegate



#pragma mark - event response

- (void)punchBtnClick {
    [self routerEventWithName:kCakeForestPunchBtnClick userInfo:@{}];
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UIImageView *)titleImgV {
    if (!_titleImgV) {
        _titleImgV = [[UIImageView alloc] init];
        _titleImgV.image = [UIImage imageNamed:@"ct_forest"];
    }
    return _titleImgV;
}

- (UILabel *)activitylbl {
    if (!_activitylbl) {
        _activitylbl = [[UILabel alloc] init];
        _activitylbl.numberOfLines = 0;
        _activitylbl.font = [UIFont systemFontOfSize:11];
        _activitylbl.textAlignment = NSTextAlignmentCenter;
        [_activitylbl setText:@"活动时间\n2019.7.1-2019.12.31" lineSpacing:8];
    }
    return _activitylbl;
}

- (UIButton *)punchBtn {
    if (!_punchBtn) {
        _punchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_punchBtn setBackgroundImage:[UIImage imageNamed:@"ct_daka"] forState:(UIControlStateNormal)];
        [_punchBtn addTarget:self action:@selector(punchBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _punchBtn;
}

@end
