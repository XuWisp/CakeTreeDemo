//
//  CakeTreeView.h
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CakeTreeView : UIView

- (void)addTreeLevelImageByLevel:(NSUInteger)level;
- (void)treeLevelUpToLevel:(NSUInteger)level;

@end

NS_ASSUME_NONNULL_END
