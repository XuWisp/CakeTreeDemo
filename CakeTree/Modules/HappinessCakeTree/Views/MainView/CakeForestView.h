//
//  CakeForestView.h
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewDefines.h"
NS_ASSUME_NONNULL_BEGIN

@interface CakeForestView : UIView

@property (nonatomic, weak) id <TargetDelegate> _Nullable targetDelegate;
@property (nonatomic, weak) id <UITableViewDataSource> _Nullable tvDataSource;
@property (nonatomic, weak) id <UITableViewDelegate> _Nullable tvDelegate;

@end

NS_ASSUME_NONNULL_END
