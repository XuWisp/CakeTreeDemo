//
//  CakeTreeEditSaveView.h
//  CakeTree
//
//  Created by 徐沙洪 on 2019/6/3.
//  Copyright © 2019 Xush. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CTEditSaveViewDelegate <NSObject>

@required
- (void)editSaveViewConfirmBtnClick;
- (void)editSaveViewCancelBtnClick;

@end

@interface CakeTreeEditSaveView : UIView

@property (nonatomic, weak) id<CTEditSaveViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
