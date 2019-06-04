//
//  CakeTreeEditSaveView.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/6/3.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeTreeEditSaveView.h"

@interface CakeTreeEditSaveView ()

@property (nonatomic, strong) UIImageView *titleImgV;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation CakeTreeEditSaveView

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xFFFAE8);
        self.layer.shadowColor = [UIColor colorWithRed:19/255.0 green:19/255.0 blue:19/255.0 alpha:0.15].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,4);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 3;
        self.layer.borderWidth = 3;
        self.layer.borderColor = [UIColor colorWithRed:255/255.0 green:213/255.0 blue:45/255.0 alpha:1.0].CGColor;
        self.layer.cornerRadius = 18;
        [self addSubview:self.titleImgV];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.confirmBtn];
        [self VFLLayout];
    }
    return self;
}

- (void)VFLLayout {
    // 做布局的事情
    self.titleImgV.fixedSize(183, 20);
    self.confirmBtn.fixedSize(98, 33);
    self.cancelBtn.fixedSize(98, 33);
    H[38] [_titleImgV].cut();
    H[20] [_cancelBtn] [30] [_confirmBtn].cut();
    @[V,V].VFL[30] [self.titleImgV] [30] [@[self.confirmBtn, self.cancelBtn]].cut();
}

#pragma mark - delegate

#pragma mark - event response

- (void)cancelBtnClick {
    if (self.delegate) {
        [self.delegate editSaveViewCancelBtnClick];
    }
}

- (void)confirmBtnClick {
    if (self.delegate) {
        [self.delegate editSaveViewConfirmBtnClick];
    }
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UIImageView *)titleImgV {
    if (!_titleImgV) {
        _titleImgV = [[UIImageView alloc] init];
        _titleImgV.image = [UIImage imageNamed:@"editSaveViewTitle"];
    }
    return _titleImgV;
}


- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"ct_notsave"] forState:(UIControlStateNormal)];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"ct_save"] forState:(UIControlStateNormal)];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _confirmBtn;
}



@end
