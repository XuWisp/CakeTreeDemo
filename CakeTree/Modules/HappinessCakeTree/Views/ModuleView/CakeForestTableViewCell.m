//
//  CakeForestTableViewCell.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/28.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeForestTableViewCell.h"
#import "CTImageListView.h"

@interface CakeForestTableViewCell ()

@property (nonatomic, strong) UIView *borderV;
@property (nonatomic, strong) UILabel *nameLbl;
@property (nonatomic, strong) UILabel *timeLbl;
@property (nonatomic, strong) UILabel *contentLbl;
@property (nonatomic, strong) CTImageListView *imgLV;
@property (nonatomic, strong) UIButton *starBtn;
@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation CakeForestTableViewCell

#pragma mark - Lifecycle

#pragma mark - life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.borderV];
        [self.contentView addSubview:self.nameLbl];
        [self.contentView addSubview:self.timeLbl];
        [self.contentView addSubview:self.contentLbl];
        [self.contentView addSubview:self.imgLV];
        [self.contentView addSubview:self.starBtn];
        [self.contentView addSubview:self.deleteBtn];
        [self VFLlayout];
    }
    return self;
}

- (void)VFLlayout {
    NSLog(@"cell layout");
    self.borderV.edge(UIEdgeInsetsMake(7, 10, 7, 10));
    H[_nameLbl[50]][134].end();
    H[_timeLbl[100]][28].end();
    HA[20][@[_contentLbl,_imgLV]][20].end();
    H[10][_starBtn[80]].cut();
    H[_deleteBtn[50]][10].end();
    
    VA[7] [@[_nameLbl,_timeLbl].VFL[45]] [_contentLbl] [_imgLV[200]] [@[_starBtn,_deleteBtn].VFL[60]] [7].end();

    
//    [self addConstraints:[self.borderV constraintsTopInContainer:7]];
//    [self addConstraints:[self.borderV constraintsBottomInContainer:7]];
//    [self addConstraints:[self.borderV constraintsLeftInContainer:10]];
//    [self addConstraints:[self.borderV constraintsRightInContainer:10]];
//
//    [self addConstraints:[self.nameLbl constraintsSize:(CGSizeMake(50, 45))]];
//    [self addConstraint:[self.nameLbl constraintTopEqualToView:self.borderV]];
//    [self addConstraints:[self.nameLbl constraintsRightInContainer:134]];
//
//    [self addConstraints:[self.timeLbl constraintsSize:(CGSizeMake(100, 45))]];
//    [self addConstraint:[self.timeLbl constraintTopEqualToView:self.borderV]];
//    [self addConstraints:[self.timeLbl constraintsRightInContainer:28]];
//
//    [self addConstraints:[self.contentLbl constraintsTop:0 FromView:self.nameLbl]];
//    [self addConstraints:[self.contentLbl constraintsLeftInContainer:20]];
//    [self addConstraints:[self.contentLbl constraintsRightInContainer:20]];
//
//    [self addConstraints:[self.imgLV constraintsSize:(CGSizeMake(300, 200))]];
//    [self addConstraints:[self.imgLV constraintsTop:14 FromView:self.contentLbl]];
//    [self addConstraint:[self.imgLV constraintCenterYEqualToView:self]];
//
//    [self addConstraints:[self.starBtn constraintsSize:(CGSizeMake(80, 60))]];
//    [self addConstraints:[self.starBtn constraintsTop:0 FromView:self.imgLV]];
//    [self addConstraints:[self.starBtn constraintsAssignBottom]];
//    [self addConstraints:[self.starBtn constraintsLeftInContainer:10]];
//
//    [self addConstraints:[self.deleteBtn constraintsSize:(CGSizeMake(50, 60))]];
//    [self addConstraints:[self.deleteBtn constraintsTop:0 FromView:self.imgLV]];
//    [self addConstraints:[self.deleteBtn constraintsRightInContainer:10]];

}

#pragma mark - delegate



#pragma mark - event response

#pragma mark - public methods

- (void)configWithData:(NSDictionary *)data {
    self.nameLbl.text = [NSString stringWithFormat:@"%ld", _moment.userId];
    self.timeLbl.text = [NSString stringWithFormat:@"%ld", (long)_moment.time];
    self.contentLbl.text = _moment.text;
    self.imgLV.moment = _moment;
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UIView *)borderV {
    if (!_borderV) {
        _borderV = [[UIView alloc] init];
        _borderV.backgroundColor = UIColorFromHex(0xFFFAE8);
        _borderV.layer.borderColor = UIColorFromHex(0xFFD52D).CGColor;
        _borderV.layer.borderWidth = 3;
    }
    return _borderV;
}

- (UILabel *)nameLbl {
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.textAlignment = NSTextAlignmentRight;
        _nameLbl.font = [UIFont systemFontOfSize:12];
    }
    return _nameLbl;
}

- (UILabel *)timeLbl {
    if (!_timeLbl) {
        _timeLbl = [[UILabel alloc] init];
        _timeLbl.textAlignment = NSTextAlignmentRight;
        _timeLbl.font = [UIFont systemFontOfSize:12];
    }
    return _timeLbl;
}

- (UILabel *)contentLbl {
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc] init];
        // headerview 约束布局重点 - 1
        _contentLbl.preferredMaxLayoutWidth = kScreenW-40;
        _contentLbl.numberOfLines = 0;
    }
    return _contentLbl;
}

- (CTImageListView *)imgLV {
    if (!_imgLV) {
        _imgLV = [[CTImageListView alloc] init];
    }
    return _imgLV;
}

- (UIButton *)starBtn {
    if (!_starBtn) {
        _starBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _starBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    }
    return _deleteBtn;
}



@end
