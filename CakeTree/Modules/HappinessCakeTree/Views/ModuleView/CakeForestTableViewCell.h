//
//  CakeForestTableViewCell.h
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/28.
//  Copyright © 2019 Xush. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CakeForestTableViewCell : UITableViewCell

@property (nonatomic,strong) Moment * moment;
- (void)configWithData:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END
