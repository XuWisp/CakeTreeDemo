//
//  CTImagePreviewView.h
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/29.
//  Copyright © 2019 Xush. All rights reserved.
//
//  朋友圈动态 > 图片预览视图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTImagePreviewView : UIView

// 横向滚动视图
@property (nonatomic,strong) UIScrollView *scrollView;
// 页码指示
@property (nonatomic,strong) UIPageControl *pageControl;
// 页码数目
@property (nonatomic,assign) NSInteger pageNum;
// 页码索引
@property (nonatomic,assign) NSInteger pageIndex;

@end

NS_ASSUME_NONNULL_END
