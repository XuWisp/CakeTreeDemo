//
//  CTAddImgCollectionViewCell.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/6/4.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CTAddImgCollectionViewCell.h"

@implementation CTAddImgCollectionViewCell

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 9.3;
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColorFromHex(0xCCCCCC).CGColor;
        self.contentView.backgroundColor = UIColorFromHex(0xFFE8C3);
        [self.contentView addSubview:self.addImgV];
        [self VFLlayout];
    }
    return self;
}

- (void)VFLlayout {
    self.addImgV.edge(UIEdgeInsetsMake(20, 20, 20, 20));
}


#pragma mark - delegate



#pragma mark - event response

#pragma mark - public methods

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UIImageView *)addImgV {
    if (!_addImgV) {
        _addImgV = [[UIImageView alloc] init];
        _addImgV.image = [UIImage imageNamed:@"ct_icon_add"];
        _addImgV.contentMode = UIViewContentModeScaleAspectFill;
        _addImgV.clipsToBounds = YES;
    }
    return _addImgV;
}

@end
