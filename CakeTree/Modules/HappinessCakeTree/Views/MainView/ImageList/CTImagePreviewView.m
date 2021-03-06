//
//  CTImagePreviewView.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/29.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CTImagePreviewView.h"

@interface CTImagePreviewView () <UIScrollViewDelegate>

@end

@implementation CTImagePreviewView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.userInteractionEnabled = YES;
        // 添加子视图
        [self addSubview:self.scrollView];
        // 页面控制
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)layoutSubviews {
    self.scrollView.frame = self.bounds;
    self.pageControl.frame = CGRectMake(0, self.ct_height-self.safeAreaBottomGap-40, kScreenW, 20);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageIndex = scrollView.contentOffset.x / self.ct_width;
    _pageControl.currentPage = _pageIndex;
}

#pragma mark - event response

#pragma mark - public methods

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.userInteractionEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.userInteractionEnabled = false;
    }
    return _pageControl;
}

- (void)setPageNum:(NSInteger)pageNum
{
    _pageNum = pageNum;
    _pageControl.numberOfPages = pageNum;
}


@end
