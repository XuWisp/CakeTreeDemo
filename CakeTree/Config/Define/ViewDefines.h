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
@protocol ViewTarget <NSObject>

@required

- (void)

@optional

- (void)
- (NSDictionary *_Nullable)reformParams:(NSDictionary *_Nullable)params;
- (NSInteger)loadDataWithParams:(NSDictionary *_Nullable)params;

@end

/*************************************************************************************/


#endif /* ViewDefines_h */
