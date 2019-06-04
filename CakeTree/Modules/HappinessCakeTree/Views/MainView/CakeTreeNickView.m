//
//  CakeTreeNickView.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/6/3.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeTreeNickView.h"

@interface CakeTreeNickView ()

@property (nonatomic, strong) UIImageView *titleImgV;
@property (nonatomic, strong) UITextField *nickTF;
@property (nonatomic, strong) UIImageView *nickImgV;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation CakeTreeNickView

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
        [self addSubview:self.nickTF];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.confirmBtn];
        [self VFLLayout];
    }
    return self;
}

- (void)VFLLayout {
    // 做布局的事情
    self.titleImgV.fixedSize(84, 20);
    self.confirmBtn.fixedSize(98, 33);
    self.cancelBtn.fixedSize(98, 33);
    self.nickImgV.fixedSize(103, 12);
    H[90] [_titleImgV].cut();
    H[15] [self.nickTF] [15].end();
    H[20] [_cancelBtn] [30] [_confirmBtn].cut();
    @[H,V].VFL[11] [self.nickImgV].cut();
    @[V,V].VFL[17] [self.titleImgV] [20] [self.nickTF[33]] [33] [@[self.confirmBtn, self.cancelBtn]].cut();
}

#pragma mark - delegate

#pragma mark - event response

- (void)cancelBtnClick {
    if (self.delegate) {
        [self.delegate nickViewCancelBtnClick];
    }
}

- (void)confirmBtnClick {
    if (self.delegate) {
        [self.delegate nickViewConfirmBtnClick];
    }
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码
- (void)nickConTextChange:(UITextField *)tf {
    //取消按钮点击权限，并显示提示文字
    if (tf.text.length == 0) {
        self.nickImgV.hidden = NO;
    }else {
        self.nickImgV.hidden = YES;
    }
}

#pragma mark - getters and setters

- (UIImageView *)titleImgV {
    if (!_titleImgV) {
        _titleImgV = [[UIImageView alloc] init];
        _titleImgV.image = [UIImage imageNamed:@"nickViewTitle"];
    }
    return _titleImgV;
}


- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"ct_cancel"] forState:(UIControlStateNormal)];
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _cancelBtn;
}

- (UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setBackgroundImage:[UIImage imageNamed:@"ct_qd"] forState:(UIControlStateNormal)];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _confirmBtn;
}

- (UITextField *)nickTF {
    if (!_nickTF) {
        _nickTF = [[UITextField alloc] init];
        _nickTF.backgroundColor = [UIColor colorWithRed:233/255.0 green:195/255.0 blue:135/255.0 alpha:1.0];
        _nickTF.layer.cornerRadius = 16.5;
        [_nickTF addSubview:self.nickImgV];
        _nickTF.leftView = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 11, 20))];
        _nickTF.leftViewMode = UITextFieldViewModeAlways;
        _nickTF.textColor = UIColorFromHex(0x905800);
        [_nickTF addTarget:self action:@selector(nickConTextChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _nickTF;
}

- (UIImageView *)nickImgV {
    if (!_nickImgV) {
        _nickImgV = [[UIImageView alloc] init];
        _nickImgV.image = [UIImage imageNamed:@"nickView_placehold"];
    }
    return _nickImgV;
}




@end
