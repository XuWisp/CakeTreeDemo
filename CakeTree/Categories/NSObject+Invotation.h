//
//  NSObject+Invotation.h
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/26.
//  Copyright © 2019 Xush. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Invotation)

- (NSInvocation *)createInvocationWithSelector:(SEL)aSelector;

@end

NS_ASSUME_NONNULL_END
