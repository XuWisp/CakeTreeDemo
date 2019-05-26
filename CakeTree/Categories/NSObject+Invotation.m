//
//  NSObject+Invotation.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/26.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "NSObject+Invotation.h"

@implementation NSObject (Invotation)

- (NSInvocation *)createInvocationWithSelector:(SEL)aSelector {
    NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    if (!signature) {
        NSString *info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance", [self class], NSStringFromSelector(aSelector)];
        @throw [[NSException alloc] initWithName:@"remind:" reason:info userInfo:nil];
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = self;
    invocation.selector = aSelector;
    
    return  invocation;
}

@end
