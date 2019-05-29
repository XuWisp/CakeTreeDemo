//
//  CTImageListView.h
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/29.
//  Copyright © 2019 Xush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTImageView.h"
#import "Moment.h"

NS_ASSUME_NONNULL_BEGIN

@interface CTImageListView : UIView

// 动态
@property (nonatomic,strong) Moment * moment;
// 点击小图
@property (nonatomic, copy) void (^singleTapHandler)(CTImageView *imageView);

@end

NS_ASSUME_NONNULL_END
