//
//  CTImgCollectionViewCell.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/6/4.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CTImgCollectionViewCell.h"

@implementation CTImgCollectionViewCell

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 9.3;
        self.layer.borderWidth = 1;
        self.layer.borderColor = UIColorFromHex(0xCCCCCC).CGColor;
        self.contentView.backgroundColor = UIColorFromHex(0xFFE8C3);
        [self.contentView addSubview:self.imgV];
        [self VFLlayout];
    }
    return self;
}

- (void)VFLlayout {
    self.imgV.edge(UIEdgeInsetsMake(0, 0, 0, 0));
}


#pragma mark - delegate



#pragma mark - event response

#pragma mark - public methods

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UIImageView *)imgV {
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        _imgV.contentMode = UIViewContentModeScaleAspectFill;
        _imgV.clipsToBounds = YES;
    }
    return _imgV;
}


@end
