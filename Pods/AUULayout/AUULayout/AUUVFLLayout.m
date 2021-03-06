//
//  AUUVFLLayout.m
//  AUULayout
//
//  Created by JyHu on 2017/3/31.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUVFLLayout.h"
#import <objc/runtime.h>

@interface NSArray (__AUUPrivate)
@end
@implementation NSArray (__AUUPrivate)

/**
 操作数组中的所有元素，并重新返回一个数组
 
 @param map 数据转换的block
 @param cls 要判断的数据类型，如果为nil，则所有的数据类型都可进行操作
 @return 转换后的数组
 */
- (NSArray *)map:(id (^)(id obj, NSUInteger index))map checkClass:(Class)cls {
    NSMutableArray *results = [[NSMutableArray alloc] init];
    if (self && self.count > 0) {
        for (NSUInteger i = 0; i < self.count; i ++) {
            id cur = self[i];
            if (!cls || (cls && [cur isKindOfClass:cls])) {
                id temp = map(cur, i);
                if (temp) {
                    [results addObject:temp];
                }
            }
        }
    }
    return results;
}
@end

@interface AUULayoutAssistant ()
// 是否需要调试log
@property (assign, nonatomic) BOOL needDebugLod;
// 是否需要自动的将重复的旧约束设置时效
@property (assign, nonatomic) BOOL needAutoCoverRepetitionLayoutConstrants;
// 缓存的全局的处理重复约束的block
@property (copy, nonatomic) AUURepetitionLayoutConstrantsHandler repetitionLayoutConstrantsHandler;
@end

@implementation AUULayoutAssistant

+ (instancetype)sharedInstance {
    static AUULayoutAssistant *assistant = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        assistant = [[AUULayoutAssistant alloc] init];
    });
    return assistant;
}

+ (void)enableDebugLog:(BOOL)enable {
    [AUULayoutAssistant sharedInstance].needDebugLod = enable;
}

+ (void)setNeedAutoCoverRepetitionLayoutConstrants:(BOOL)autoCover {
    [AUULayoutAssistant sharedInstance].needAutoCoverRepetitionLayoutConstrants = autoCover;
}

+ (void)setRepetitionLayoutConstrantsHandler:(AUURepetitionLayoutConstrantsHandler)repetitionLayoutConstrantsHandler {
    [AUULayoutAssistant sharedInstance].repetitionLayoutConstrantsHandler = repetitionLayoutConstrantsHandler;
}

@end

@implementation UIView (AUUAssistant)
- (void)removeAllConstrants {
    for (NSLayoutConstraint *layoutConstrant in self.constraints) {
        layoutConstrant.active = NO;
    }
    [self removeConstraints:self.constraints];
}
@end


@interface NSLayoutConstraint (AUUAssistant)
@end
@implementation NSLayoutConstraint (AUUAssistant)

- (BOOL)similarTo:(NSLayoutConstraint *)layoutConstrant {
    // 如果第一个视图不一样则不类似 如果第一个attribute不一样则不类似
    if (![self.firstItem isEqual:layoutConstrant.firstItem] || self.firstAttribute != layoutConstrant.firstAttribute) {
        return NO;
    }
    
    if ((!self.secondItem && !layoutConstrant.secondItem) ||
        (self.secondItem && layoutConstrant.secondItem &&
         [self.secondItem isEqual:layoutConstrant.secondItem] &&
         self.secondAttribute == layoutConstrant.secondAttribute)) {
        return YES;
    }
    
    return NO;
}

@end


// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#pragma mark - 为布局扩展下标法的基类
#pragma mark -
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation AUUBaseVFLLayout

- (instancetype)objectAtIndexedSubscript:(NSInteger)idx {
    return self[@(idx)];
}

@end

#pragma clang diagnostic pop

@interface AUUVFLLayout() <NSCopying>

// VFL语句中相关的视图，在主VFL中表示的是容器视图，在子VFL中表示的是当前要设置宽高属性的视图
@property (weak, nonatomic, readwrite) UIView *sponsorView;

// VFL语句，在主VFL中表示的是当前的完整的VFL语句，在子VFL中表示的是当前要设置的视图的宽高属性
@property (retain, nonatomic) NSMutableString *pri_VFLString;

// VFL语句中保存视图的字典
@property (retain, nonatomic) NSMutableDictionary <NSString *, UIView *> *layoutKits;

// 缓存视图到字典中，并返回为视图生成的HashKey
- (NSString *)cacheView:(UIView *)view;

@end



@implementation AUUVFLLayout

- (NSMutableDictionary<NSString *,UIView *> *)layoutKits {
    if (!_layoutKits) {
        _layoutKits = [[NSMutableDictionary alloc] init];
    }
    return _layoutKits;
}

// 缓存视图到字典中，并返回为视图生成的HashKey
- (NSString *)cacheView:(UIView *)view {
    if (view.superview && [view.superview isKindOfClass:[UIView class]]) {
        // viewcontroller的view不可以设置这个属性，否则会出问题
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    NSString *key = [NSString stringWithFormat:@"COM_AUU_VFL_%@%@", NSStringFromClass([view class]), @([view hash])];
    [self.layoutKits setObject:view forKey:key];
    return key;
}

- (id)copyWithZone:(NSZone *)zone {
    AUUVFLLayout *layoutConstrants = [[[self class] allocWithZone:zone] init];
    layoutConstrants.sponsorView = self.sponsorView;
    layoutConstrants.pri_VFLString = [self.pri_VFLString mutableCopy];
    layoutConstrants.layoutKits = [self.layoutKits mutableCopy];
    return layoutConstrants;
}

@end

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#pragma mark - 对主VFL语句设置属性的类
#pragma mark -
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@implementation AUUVFLConstraints

- (instancetype)initWithDirection:(NSString *)direction {
    if (self = [super init]) {
        self.pri_VFLString = [direction mutableCopy];
    }
    return self;
}

- (NSString *(^)())end {
    return [^{
        // 以父视图的末尾结束当前的vfl语句
        [self.pri_VFLString appendString:@"|"];
        return self.cut();
    } copy];
}

- (NSString *(^)())cut {
    return [^{
        // 结束VFL语句，并设置到具体的视图上
        NSArray *currentInstalledConstrants = [NSLayoutConstraint constraintsWithVisualFormat:self.pri_VFLString options:NSLayoutFormatDirectionMask metrics:nil views:self.layoutKits];

        for (UIView *view in self.layoutKits.allValues) {
            for (NSLayoutConstraint *oldLayoutConstrant in view.superview.constraints) {
                for (NSLayoutConstraint *newLayoutConstrant in currentInstalledConstrants) {
                    if ([newLayoutConstrant similarTo:oldLayoutConstrant] && oldLayoutConstrant.active) {
                        // 处理有冲突的约束
                        if ([AUULayoutAssistant sharedInstance].repetitionLayoutConstrantsHandler) {
                            [AUULayoutAssistant sharedInstance].repetitionLayoutConstrantsHandler(oldLayoutConstrant, newLayoutConstrant);
                        } else if ([AUULayoutAssistant sharedInstance].needAutoCoverRepetitionLayoutConstrants) {
                            oldLayoutConstrant.active = NO;
                        }
                    }
                }
            }
        }
        if ([AUULayoutAssistant sharedInstance].needDebugLod) {
            NSLog(@"VFL %@", self.pri_VFLString);
        }
        
        [self.sponsorView addConstraints:currentInstalledConstrants];
        return self.pri_VFLString;
    } copy];
}

- (instancetype)objectForKeyedSubscript:(id)key {
    if ([key isKindOfClass:[NSNumber class]] || [key isKindOfClass:[NSString class]]){
        // 设置两个视图的间距
        [self.pri_VFLString appendFormat:@"%@-(%@)-", (self.pri_VFLString && self.pri_VFLString.length == 2 ? @"|" : @""), key];
    } else {
        if ([key isKindOfClass:[UIView class]]) {
            // 设置相邻的视图
            [self.pri_VFLString appendFormat:@"[%@]", [self cacheView:key]];
        } else if ([key isKindOfClass:[AUUSubVFLConstraints class]]) {
            // 设置相邻视图，和相邻视图其宽高属性的子VFL语句
            AUUSubVFLConstraints *subConstrants = (AUUSubVFLConstraints *)key;
            [self.layoutKits addEntriesFromDictionary:subConstrants.layoutKits];
            [self.pri_VFLString appendFormat:@"[%@(%@)]", [self cacheView:subConstrants.sponsorView], subConstrants.pri_VFLString];
        }
    }
    return self;
}

- (NSString *)cacheView:(UIView *)view {
    if (view.superview && [view.superview isKindOfClass:[UIView class]]) {
        // 当前VFL语句操作的父视图
        self.sponsorView = view.superview;
    }
    NSAssert1(view.nextResponder, @"当前视图[%@]没有被添加到需要的父视图上，无法进行自动布局", view);
    return [super cacheView:view];
}

@end

@implementation AUUHorizontalVFLConstraints
- (instancetype)init {
    return [self initWithDirection:@"H:"];
}
@end
@implementation AUUVerticalVFLConstraints
- (instancetype)init {
    return [self initWithDirection:@"V:"];
}
@end

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#pragma mark - 对子视图设置VFL布局的类，及对UIView扩充的一些方法
#pragma mark -
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@implementation AUUSubVFLConstraints

- (instancetype)objectForKeyedSubscript:(id)key {
    if ([key isKindOfClass:[NSNumber class]]) {
        // 设置宽高属性为具体的值，此处的VFL只作为附属的设置，不会作为累计的VFL，所以不需要可变的string
        self.pri_VFLString = (NSMutableString *)[NSString stringWithFormat:@"%@", key];
    } else if ([key isKindOfClass:[UIView class]]) {
        // 设置与某视图宽高相等
        self.pri_VFLString = (NSMutableString *)[NSString stringWithFormat:@"%@", [self cacheView:key]];
    } else if ([key isKindOfClass:[NSString class]]) {
        // 设置宽高的属性
        self.pri_VFLString = key;
    }
    return self;
}

@end

@implementation UIView (AUUVFLSpace)

- (AUUSubVFLConstraints *)VFL {
    AUUSubVFLConstraints *VFLConstrants = objc_getAssociatedObject(self, _cmd);
    if (!VFLConstrants) {
        VFLConstrants = [[AUUSubVFLConstraints alloc] init];
        objc_setAssociatedObject(self, _cmd, VFLConstrants, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    VFLConstrants.sponsorView = self;
    return VFLConstrants;
}

#if kUIViewUseVFLSubscriptLayout
// 将`UIView`的下标法做的操作转到其命名空间下实现
- (id)objectForKeyedSubscript:(id)key {
    return self.VFL[key];
}
- (id)objectAtIndexedSubscript:(NSInteger)idx {
    return self.VFL[idx];
}
#endif

@end

@implementation UIView (AUUVFLLayout)
// 设置视图在父视图上距离上下左右的位置
- (NSArray *(^)(UIEdgeInsets))edge {
    return [^(UIEdgeInsets insets){
        return @[H[@(insets.left)][self][@(insets.right)].end(),
                 V[@(insets.top)][self][@(insets.bottom)].end()];
    } copy];
}
// 设置为指定的大小
- (NSArray *(^)(CGFloat, CGFloat))fixedSize {
    return [^(CGFloat width, CGFloat height){
        return @[H[self.VFL[@(width)]].cut(), V[self.VFL[@(height)]].cut()];
    } copy];
}

@end

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#pragma mark - 对批量属性操作的类及辅助方法
#pragma mark -
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@interface AUUGroupVFLConstrants ()
/**
 要批量操作的对象数组
 */
@property (retain, nonatomic) NSArray *layoutObjects;
@end
@implementation AUUGroupVFLConstrants

- (instancetype)objectForKeyedSubscript:(id)key {
    if (!self.layoutObjects || self.layoutObjects.count == 0) {
        self.layoutObjects = [key isKindOfClass:[NSArray class]] ? key : @[key];
    } else {
        if ([key isKindOfClass:[NSArray class]]) {
            // 如果是数组，则需要一个个的对应着去设定
            if ([key count] > 0) {
                if ([key count] > self.layoutObjects.count) {
                    // 先暂存一份最后的一个值，避免在block内拼接的时候取了上一个已被拼接的数据
                    id lastObject = [[self.layoutObjects lastObject] copy];
                    self.layoutObjects = [key map:^id(id obj, NSUInteger index) {
                        return [(index < self.layoutObjects.count ? self.layoutObjects[index] : lastObject) objectForKeyedSubscript:key[index]];
                    } checkClass:nil];
                } else {
                    self.layoutObjects = [self.layoutObjects map:^id(id obj, NSUInteger index) {
                        return [[self.layoutObjects objectAtIndex:index] objectForKeyedSubscript:(index < [key count] ? key[index] : [key lastObject])];
                    } checkClass:nil];
                }
            }
        } else if ([key isKindOfClass:[AUUGroupVFLConstrants class]]) {
            // 如果是 AUUGroupVFLConstrants 类型，则说明是子vfl中的批量设定，需要返回设定的结果列表，然后一一匹配
            return self[((AUUGroupVFLConstrants *)key).layoutObjects];
        } else {
            // 如果是其他类型的话，比如字符串、数值对象、视图等，需要遍历着去操作
            self.layoutObjects = [self.layoutObjects map:^id(AUUVFLLayout *obj, NSUInteger index) {
                return obj[key];
            } checkClass:nil];
        }
    }
    return self;
}

- (NSArray *(^)())end {
    return [^{
        return [self.layoutObjects map:^id(AUUVFLConstraints *obj, NSUInteger index) {
            // 调用 AUUVFLConstraints 的end属性一个个的去结束vfl语句并设定
            return obj.end();
        } checkClass:[AUUVFLConstraints class]];
    } copy];
}

- (NSArray *(^)())cut {
    return [^{
        return [self.layoutObjects map:^id(AUUVFLConstraints *obj, NSUInteger index) {
            // 调用 AUUVFLConstraints 的cut属性一个个的去结束vfl语句并设定
            return obj.cut();
        } checkClass:[AUUVFLConstraints class]];
    } copy];
}

@end

@implementation NSArray (AUUVFLSpace)
- (AUUGroupVFLConstrants *)VFL {
    AUUGroupVFLConstrants *groupConstrants = objc_getAssociatedObject(self, _cmd);
    if (!groupConstrants) {
        groupConstrants = [[AUUGroupVFLConstrants alloc] init];
        objc_setAssociatedObject(self, _cmd, groupConstrants, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    groupConstrants.layoutObjects = self;
    return groupConstrants;
}

@end
