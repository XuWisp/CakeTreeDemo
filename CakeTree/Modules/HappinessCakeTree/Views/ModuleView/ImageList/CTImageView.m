//
//  CTImageView.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/29.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CTImageView.h"

@interface CTImageView ()


@end

@implementation CTImageView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor lightGrayColor];
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds  = YES;
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCallback:)];
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

#pragma mark - delegate



#pragma mark - event response

- (void)singleTapGestureCallback:(UIGestureRecognizer *)gesture
{
    if (self.clickHandler) {
        self.clickHandler(self);
    }
}

#pragma mark - public methods

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters



@end
