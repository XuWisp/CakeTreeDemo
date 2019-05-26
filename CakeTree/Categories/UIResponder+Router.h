//
//  UIResponder+Router.h
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/26.
//  Copyright © 2019 Xush. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end

NS_ASSUME_NONNULL_END
