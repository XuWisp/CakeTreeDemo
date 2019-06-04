//
//  CakeTreeNickView.h
//  CakeTree
//
//  Created by 徐沙洪 on 2019/6/3.
//  Copyright © 2019 Xush. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CTNickViewDelegate <NSObject>

@required
- (void)nickViewConfirmBtnClick;
- (void)nickViewCancelBtnClick;

@end

@interface CakeTreeNickView : UIView

@property (nonatomic, weak) id<CTNickViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
