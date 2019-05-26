//
//  UIResponder+Router.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/26.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
