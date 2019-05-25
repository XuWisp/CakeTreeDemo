//
//  CakeTreeView.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeTreeView.h"

@interface CakeTreeView ()

@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIImageView *backgroundImgV;
@property (nonatomic, strong) UIImageView *giftImgV;
@property (nonatomic, strong) UIProgressView *progressV;
@property (nonatomic, strong) UILabel *levelLbl;
@property (nonatomic, strong) UIButton *ticketBtn;

@end

@implementation CakeTreeView


#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.scrollV];
        [self addSubview:self.backgroundImgV];
    }
    return self;
}

#pragma mark - delegate



#pragma mark - event response


#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UIScrollView *)scrollV {
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc] init];
        _scrollV.backgroundColor = [UIColor whiteColor];
        [_scrollV addSubview:self.backgroundImgV];
    }
    return _scrollV;
}

@end
