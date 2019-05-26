//
//  ViewDefines.h
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#ifndef ViewDefines_h
#define ViewDefines_h

/*************************************************************************************/
/// View基本协议，降低View的耦合性，将View子视图的响应事件
@protocol LayoutDelegate <NSObject>

@required
/// 传递View子视图的布局事件
- (void)layoutSubviews;
//getter是个工厂，生产对象过程中只适合那种不需要其它上下文的对象，当对象的赋值跟其它上下文有关时，就不适合在getter里做。
//背景色可以在getter里做，但是frame布局必须要在viewwillappear里面，因为只有在viewwillappear的时候才知道view的大小。这跟vc的生命周期上下文相关。
//如果是autolayout，那就得另开方法在viewdidload的最后去做。
//包括如果是点击事件导致的属性值改变，这很明显也不可能在getter里做。
//要正确理解工厂模式，才能正确使用getter。

@end

/*************************************************************************************/

#endif /* ViewDefines_h */
