//
//  CTImageListView.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/29.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CTImageListView.h"
#import "CTImagePreviewView.h"
#import "CTPreviewScrollView.h"
#import <SDWebImage.h>

@interface CTImageListView ()

// 图片视图数组
@property (nonatomic, strong) NSMutableArray * imageViewsArray;
// 预览视图
@property (nonatomic, strong) CTImagePreviewView * previewView;

@end

@implementation CTImageListView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 小图(九宫格)
        _imageViewsArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
            CTImageView * imageView = [[CTImageView alloc] initWithFrame:CGRectZero];
            imageView.tag = 1000 + i;
            [imageView setClickHandler:^(CTImageView *imageView){
                [self singleTapSmallViewCallback:imageView];
                if (self.singleTapHandler) {
                    self.singleTapHandler(imageView);
                }
            }];
            [_imageViewsArray addObject:imageView];
            [self addSubview:imageView];
        }
        // 预览视图
        _previewView = [[CTImagePreviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }
    return self;
}

#pragma mark - delegate



#pragma mark - event response
- (void)singleTapSmallViewCallback:(CTImageView *)imageView
{
    UIWindow *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    // 解除隐藏
    [window addSubview:_previewView];
    [window bringSubviewToFront:_previewView];
    // 清空
    [_previewView.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 添加子视图
    NSInteger index = imageView.tag - 1000;
    NSInteger count = [_moment.pictureList count];
    CGRect convertRect;
    if (count == 1) {
        [_previewView.pageControl removeFromSuperview];
    }
    for (NSInteger i = 0; i < count; i ++)
    {
        // 转换Frame
        CTImageView *pImageView = (CTImageView *)[self viewWithTag:1000+i];
        convertRect = [[pImageView superview] convertRect:pImageView.frame toView:window];
        // 添加
        CTPreviewScrollView *scrollView = [[CTPreviewScrollView alloc] initWithFrame:CGRectMake(i*_previewView.ct_width, 0, _previewView.ct_width, _previewView.ct_height)];
        scrollView.tag = 100+i;
        scrollView.maximumZoomScale = 2.0;
        scrollView.image = pImageView.image;
        scrollView.contentRect = convertRect;
        // 单击
        [scrollView setTapBigView:^(CTPreviewScrollView *scrollView){
            [self singleTapBigViewCallback:scrollView];
        }];
        // 长按
        [scrollView setLongPressBigView:^(CTPreviewScrollView *scrollView){
            [self longPresssBigViewCallback:scrollView];
        }];
        [_previewView.scrollView addSubview:scrollView];
        if (i == index) {
            [UIView animateWithDuration:0.3 animations:^{
                _previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
                _previewView.pageControl.hidden = NO;
                [scrollView updateOriginRect];
            }];
        } else {
            [scrollView updateOriginRect];
        }
    }
    // 更新offset
    CGPoint offset = _previewView.scrollView.contentOffset;
    offset.x = index * k_screen_width;
    _previewView.scrollView.contentOffset = offset;
}

#pragma mark - 大图单击||长按
- (void)singleTapBigViewCallback:(CTPreviewScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        _previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _previewView.pageControl.hidden = YES;
        scrollView.contentRect = scrollView.contentRect;
        scrollView.zoomScale = 1.0;
    } completion:^(BOOL finished) {
        [_previewView removeFromSuperview];
    }];
}

- (void)longPresssBigViewCallback:(CTPreviewScrollView *)scrollView
{
    
}

#pragma mark - public methods

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (void)setMoment:(Moment *)moment
{
    _moment = moment;
    for (CTImageView * imageView in _imageViewsArray) {
        imageView.hidden = YES;
    }
    // 图片区
    NSInteger count = [moment.pictureList count];
    if (count == 0) {
        self.ct_size = CGSizeZero;
        return;
    }
    // 更新视图数据
    _previewView.pageNum = count;
    _previewView.scrollView.contentSize = CGSizeMake(_previewView.ct_width*count, _previewView.ct_height);
    // 添加图片
    CTImageView * imageView = nil;
    for (NSInteger i = 0; i < count; i++)
    {
        NSInteger rowNum = i / 3;
        NSInteger colNum = i % 3;
        if(count == 4) {
            rowNum = i / 2;
            colNum = i % 2;
        }
        CGFloat imageX = colNum * (kImageWidth + kImagePadding);
        CGFloat imageY = rowNum * (kImageWidth + kImagePadding);
        CGRect frame = CGRectMake(imageX, imageY, kImageWidth, kImageWidth);
        
        // 单张图片需计算实际显示size
        if (count == 1) {
            CGSize singleSize = [Utility getMomentImageSize:CGSizeMake(moment.singleWidth, moment.singleHeight)];
            frame = CGRectMake(0, 0, singleSize.width, singleSize.height);
        }
        imageView = [self viewWithTag:1000+i];
        imageView.hidden = NO;
        imageView.frame = frame;
        // 赋值
        MPicture * picture = [moment.pictureList objectAtIndex:i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:picture.thumbnail]
                     placeholderImage:nil];
    }
    self.ct_width = kTextWidth;
    self.ct_height = imageView.ct_bottom;
}


@end
