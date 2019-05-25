//
//  AppMacro.h
//  CASAMIEL
//
//  Created by 徐沙洪 on 2017/12/12.
//  Copyright © 2017年 徐沙洪. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

static const CGFloat iPhone6SPHiFi = 1242.f;
static const CGFloat iPhone6SPWidth = 414.f;
static const CGFloat HiFi = 750.f; // 高保真


#define kFit(x) ((x) / (iPhone6SPWidth) * (kScreenW))
#define kImg(x) ((x) / (iPhone6SPHiFi) * (iPhone6SPWidth))
#define kImgFit(x) ((x) / (iPhone6SPHiFi) * (iPhone6SPWidth) / (iPhone6SPWidth) * (kScreenW))

//状态栏样式
#define kStatusBarStyle UIStatusBarStyleLightContent

// 字体
#define defaultFont(s) [UIFont fontWithName:@"STHeitiSC-Light" size:s]

#pragma mark - CommonMacro
///------ 应用程序BundleID ------
#define kAppBundleID ([[NSBundle mainBundle] bundleIdentifier])
///------ 应用程序版本号version ------
#define kAppVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

///------ iOS系统版本号 ------
#define iOS_Version ([[[UIDevice currentDevice] systemVersion] floatValue])

///------ 区分Debug和Release ------
#ifdef DEBUG //处于开发阶段

#else //处于发布阶段

#endif


///------ 替换NSLog使用，debug模式下可以打印很多方法名、行信息(方便查找)，release下不会打印 ------
#ifdef DEBUG
//-- 区分设备和模拟器,
//解决Product -> Scheme -> Run -> Arguments -> OS_ACTIVITY_MODE为disable时，真机下 Xcode Debugger 不打印的bug ---
#if TARGET_OS_IPHONE
/*iPhone Device*/
#define DLog(format, ...) printf("%s:Dev: %s [Line %d]\n%s\n\n", [DATE_STRING UTF8String], __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String])
#else
/*iPhone Simulator*/
#define DLog(format, ...) NSLog((@":Sim: %s [Line %d]\n%@\n\n"), __PRETTY_FUNCTION__, __LINE__, [NSString stringWithFormat:format, ##__VA_ARGS__])
#endif
#else
#define DLog(...)
#endif


///Weak-Strong Dance
///省掉多处编写__weak __typeof(self) weakSelf = self; __strong __typeof(weakSelf) strongSelf = weakSelf;代码的麻烦 ------
/**
 使用说明
 Synthsize a weak or strong reference.
 
 Example:
 @weakify(self)
 [self doSomething^{
 @strongify(self)
 if (!self) return;
 ...
 }];
 
 */
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

///------ 区分ARC和非ARC ------
#if  __has_feature(objc_arc)
//ARC
#else
//非ARC
#endif

///------ 区分设备和模拟器 ------
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

///当前日期字符串
#define DATE_STRING \
({NSDateFormatter *fmt = [[NSDateFormatter alloc] init];\
[fmt setDateFormat:@"YYYY-MM-dd hh:mm:ss"];\
[fmt stringFromDate:[NSDate date]];})

///iPhone 手机没装 iTunes Store 时也可以跳转到 AppStore，id 为你的 App 在iTunes Store上生成的链接里面的对应id, itunes connect 上的 App 信息里面也可以找到该 id
//评论页
#define kAppReviewOnAppStore @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?mt=8&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software&id="
//详情页
#define kAppDetailOnAppStore @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id="
/// TODO: Relpace this with its application identifier

#define kTmallAPPStore @"tmall://page.tm/shop?shopId="
#define kTaobaoAPPStore @"taobao://shop.m.taobao.com/shop/shop_index.htm?shop_id="
#define kTmallAPPItem @"tmall://tmallclient/?{\"action\":\"item:id=%@\"}"
#define kTaobaoAPPItem @"taobao://item.taobao.com/item.htm?id=%@"
#define kTmallURLStore @"https://keshamier.tmall.com"

///------ other ------
#define kAppDelegate ([[UIApplication sharedApplication] delegate])
#define kAppWindow (kAppDelegate.window)
#define kAppRootViewController (kAppWindow.rootViewController)

#define UserDefaults ([NSUserDefaults standardUserDefaults])
#define NotificationCenter ([NSNotificationCenter defaultCenter])

///------ 获取当前语言 ------
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

///------ 沙盒路径 ------
#define PATH_OF_HOME        NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

///------ 尺寸 ------
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kScreenRect   [UIScreen mainScreen].bounds

#define kGetNaviBarHeight self.navigationController.navigationBar.frame.size.height
#define kGetStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kGetTabBarHeight self.tabBarController.tabBar.frame.size.height
#define kGetToolBarHeight self.navigationController.toolBar.frame.size.height

#define KStatusBarAndNavigationBarHeight (IPHONE_X ? 88.f : 64.f)
#define KStatusBarHeight (IPHONE_X ? 44.f : 20.f)
#define KTabbarHeight (IPHONE_X ? 83.f : 49.f)
#define KMagrinBottom (IPHONE_X ? 34.f : 0.f)

///------ iOS Device Type ------
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 判断是否为iPhone X 系列  这样写消除了在Xcode10上的警告。
#define IPHONE_X \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
//判断设备是否是iPad
#define iPadDevice (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

///------ RGB颜色 ------
#define RGB(r, g, b) RGBA(r, g, b, 1)
#define RGBA(r, g, b, a) ([UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:a])
#define RandomColor ([UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1])
// UI整体文字色调 与背景颜色对应
#define UIColorFromHex(hexValue)        UIColorFromHexA(hexValue, 1.0f)
#define UIColorFromHexA(hexValue, a)     [UIColor colorWithRed:(((hexValue & 0xFF0000) >> 16))/255.0f green:(((hexValue & 0xFF00) >> 8))/255.0f blue:((hexValue & 0xFF))/255.0f alpha:a]

///------ 有效性验证<字符串、数组、字典等> ------
#define VALID_STRING(str)      ((str) && ([(str) isKindOfClass:[NSString class]]) && ([(str) length] > 0))
#define VALID_ARRAY(arr)       ((arr) && ([(arr) isKindOfClass:[NSArray class]]) && ([(arr) count] > 0))
#define VALID_DICTIONARY(dict) ((dict) && ([(dict) isKindOfClass:[NSDictionary class]]) && ([(dict) count] > 0))
#define VALID_NUMBER(number)   ((number) && ([(number) isKindOfClass:NSNumber.class]))

// c语言 适配全局变量
#ifdef __cplusplus
#define UIKIT_EXTERN        extern "C" __attribute__((visibility ("default")))
#else
#define UIKIT_EXTERN            extern __attribute__((visibility ("default")))
#endif

// 跳转到其他APP
#define kOpenUrl(url)

#endif /* AppMacro_h */
