//
//  CakeTreeView.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeTreeView.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

@interface CakeTreeView ()

@property (nonatomic, strong) UIScrollView *scrollV;
@property (nonatomic, strong) UIImageView *backgroundImgV;
@property (nonatomic, strong) UIImageView *giftImgV;
@property (nonatomic, strong) FLAnimatedImageView *beeGIFImgV;

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
        [_scrollV addSubview:self.beeGIFImgV];
    }
    return _scrollV;
}

- (FLAnimatedImageView *)beeGIFImgV {
    if (!_beeGIFImgV) {
        //GIF 转 NSData
        //Gif 路径
        NSString *pathForFile = [[NSBundle mainBundle] pathForResource: @"Resources/image/bee" ofType:@"gif"];
        //转成NSData
        NSData *dataOfGif = [NSData dataWithContentsOfFile: pathForFile];
        //初始化FLAnimatedImage对象
        FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:dataOfGif];
        //初始化FLAnimatedImageView对象
        FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
        //设置GIF图片
        imageView.animatedImage = image;
    }
    return _beeGIFImgV;
}

@end
