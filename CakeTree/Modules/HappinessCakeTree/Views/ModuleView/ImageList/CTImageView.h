//
//  CTImageView.h
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/29.
//  Copyright © 2019 Xush. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTImageView : UIImageView

// 点击小图
@property (nonatomic, copy) void (^clickHandler)(CTImageView *imageView);

@end

NS_ASSUME_NONNULL_END
