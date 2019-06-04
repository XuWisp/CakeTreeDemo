//
//  CakeForestTableViewCell.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/5/28.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeForestTableViewCell.h"
#import "CTImageListView.h"

NSString * const kCakeForestStarBtnClick = @"kCakeForestStarBtnClick";
NSString * const kCakeForestDeleteBtnClick = @"kCakeForestDeleteBtnClick";

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
    self.borderV.edge(UIEdgeInsetsMake(7, 10, 7, 10));
    H[_nameLbl[50]][10][_timeLbl][28].end();
    HA[20][@[_contentLbl,_imgLV]][20].end();
    //H[10][_starBtn[80]].cut();
    H[10][_starBtn[80]][AUUGreaterThan(50)][_deleteBtn[50]][10].end();
    
    VA[7] [@[_nameLbl,_timeLbl].VFL[45]] [_contentLbl] [10] [_imgLV] [@[_starBtn,_deleteBtn].VFL[60]] [7].end();
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    float height = ceilf(self.moment.pictureList.count/3.0)*(kImageWidth + kImagePadding);
//    _imgLV.fixedSize(kScreenW-40, height);
//    NSLog(@"layoutSubviews\n count:%lu \nheight:%f", (unsigned long)self.moment.pictureList.count, height);
//}

#pragma mark - delegate



#pragma mark - event response

- (void)starBtnClick:(UIButton *)btn {
    [self routerEventWithName:kCakeForestStarBtnClick userInfo:@{@"index":@(self.tag)}];
}

- (void)deleteBtnClick:(UIButton *)btn {
    [self routerEventWithName:kCakeForestDeleteBtnClick userInfo:@{@"index":@(self.tag)}];
}

#pragma mark - public methods

- (void)configWithData:(NSDictionary *)data {
    self.nameLbl.text = [NSString stringWithFormat:@"%ld", _moment.userId];
    self.timeLbl.text = [NSString stringWithFormat:@"%ld", (long)_moment.time];
    self.contentLbl.text = _moment.text;
    self.imgLV.moment = _moment;
    // 配置数据时，重新根据图片数量布局
    if (_moment.pictureList.count == 1) {
        CGSize singleSize = [Utility getMomentImageSize:CGSizeMake(_moment.singleWidth, _moment.singleHeight)];
        self.imgLV.fixedSize(singleSize.width, singleSize.height);
    }else {
        float height = ceilf(self.moment.pictureList.count/3.0)*(kImageWidth + kImagePadding);
        self.imgLV.fixedSize(kScreenW-40, height);
    }
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
        _borderV.layer.cornerRadius = 12;
        _borderV.layer.shadowColor = UIColorFromHexA(0x131313, 0.95).CGColor;
        _borderV.layer.shadowOffset  = CGSizeMake(0, 0);// 阴影的范围
        _borderV.layer.shadowOpacity = 0.6;// 阴影透明度
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
        [_starBtn setImage:[UIImage imageNamed:@"ct_icon_great_unselect"] forState:(UIControlStateNormal)];
        [_starBtn setImage:[UIImage imageNamed:@"ct_icon_great"] forState:(UIControlStateSelected)];
        [_starBtn setImageEdgeInsets:UIEdgeInsetsMake(15, 0, 15, 30)];
        _starBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;

        [_starBtn setTitle:@"123" forState:(UIControlStateNormal)];
        [_starBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -30, 0, 0)];
        _starBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_starBtn setTitleColor:UIColorFromHex(0x222222) forState:(UIControlStateNormal)];
        
        [_starBtn addTarget:self action:@selector(starBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _starBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteBtn setTitle:@"删除" forState:(UIControlStateNormal)];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_deleteBtn setTitleColor:UIColorFromHex(0x222222) forState:(UIControlStateNormal)];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deleteBtn;
}



@end
