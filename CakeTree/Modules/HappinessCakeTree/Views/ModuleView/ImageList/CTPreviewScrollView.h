//
//  CTPreviewScrollView.h
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/29.
//  Copyright © 2019 Xush. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTPreviewScrollView : UIScrollView

// 显示的大图
@property (nonatomic,strong) UIImageView *imageView;
// 原始Frame
@property (nonatomic,assign) CGRect originRect;
// 过程Frame
@property (nonatomic,assign) CGRect contentRect;
// 图片
@property (nonatomic,strong) UIImage *image;
// 点击大图(关闭预览)
@property (nonatomic, copy) void (^tapBigView)(CTPreviewScrollView *scrollView);
// 长按大图
@property (nonatomic, copy) void (^longPressBigView)(CTPreviewScrollView *scrollView);

// 更新Frame
- (void)updateOriginRect;

@end

NS_ASSUME_NONNULL_END
