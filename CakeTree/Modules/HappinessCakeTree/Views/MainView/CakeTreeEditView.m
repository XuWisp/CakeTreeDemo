//
//  CakeTreeEditView.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeTreeEditView.h"
#import <zhPopupController/zhPopupController.h>

#import "CTImgCollectionViewCell.h"

NSString * const kCakeTreeEditSelectCV = @"kCakeTreeEditSelectCV";

@interface CakeTreeEditView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView *headerV;
@property (nonatomic, strong) UIImageView *releaseImgV;
@property (nonatomic, strong) UILabel *imgLbl;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) UIView *footerV;
@property (nonatomic, strong) UILabel *textLbl;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *releaseBtn;

@property (nonatomic, strong) NSMutableArray *cvMArr;

@end

@implementation CakeTreeEditView

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.collectionView];
        // --
        [self.headerV addSubview:self.releaseImgV];
        [self.headerV addSubview:self.imgLbl];
        // --
        [self.footerV addSubview:self.textLbl];
        [self.footerV addSubview:self.textView];
        [self.footerV addSubview:self.releaseBtn];
        [self VFLlayout];
    }
    return self;
}

- (void)VFLlayout {
    //header
    H[16][self.imgLbl][self.releaseImgV[91]].end();
    V[@(KStatusBarHeight+13)] [self.releaseImgV[34]] [self.imgLbl[38]].end();

    //footer
    @[H,H].VFL[16] [@[self.textView, self.textLbl]] [16].end();
    self.releaseBtn.fixedSize(109, 39);
    H[@(kScreenW/2.0-109/2.0)][self.releaseBtn].cut();
    V[0][self.textLbl[38]][self.textView[138]][36][self.releaseBtn].end();
}

- (void)headerVFLlayout {
    H[0] [self.headerV] [0].end();
    V[0] [self.headerV].cut();
}

- (void)footerVFLlayout {
    H[0] [self.footerV] [0].end();
    V[0] [self.footerV].cut();
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.cvMArr.count<9) {
        return self.cvMArr.count+1;
    }
    return self.cvMArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CTImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    if (self.cvMArr.count<9 &&
        self.cvMArr.count == indexPath.row) {
        cell.imgV.image = [UIImage imageNamed:@"ct_icon_add"];
        cell.imgV.contentMode = UIViewContentModeCenter;
    }else {
        cell.imgV.contentMode = UIViewContentModeScaleAspectFill;
        UIImage *img = self.cvMArr[indexPath.row];
        cell.imgV.image = img;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {  //header
        UICollectionReusableView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sHeader" forIndexPath:indexPath];
        [headerV addSubview:self.headerV];
        [self headerVFLlayout];
        return headerV;
    }
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {  //footer
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sFooter" forIndexPath:indexPath];
        [footer addSubview:self.footerV];
        [self footerVFLlayout];
        return footer;
    }
    return [UICollectionReusableView new];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self routerEventWithName:kCakeTreeEditSelectCV userInfo:@{@"indexPath":indexPath}];
}

#pragma mark - event response

#pragma mark - public methods

- (void)configWithData:(NSDictionary *)data {
    self.cvMArr = [data[@"images"] mutableCopy];
    [self.collectionView reloadData];
    self.textView = data[@"text"];
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码
- (UILabel *)createLbl {
    UILabel *lbl = [[UILabel alloc] init];
    lbl.font = [UIFont systemFontOfSize:13];
    lbl.textColor = UIColorFromHex(0x444444);
    return lbl;
}

#pragma mark - getters and setters

- (UIView *)headerV {
    if (!_headerV) {
        _headerV = [[UIView alloc] init];
    }
    return _headerV;
}

- (UIView *)footerV {
    if (!_footerV) {
        _footerV = [[UIView alloc] init];
    }
    return _footerV;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((width-60)/3, (width-60)/3);
        layout.minimumInteritemSpacing = 13;
        layout.minimumLineSpacing = 13;
        layout.sectionInset = UIEdgeInsetsMake(0, 16, 8, 16);
        layout.headerReferenceSize = CGSizeMake(kScreenW, KStatusBarHeight+84);
        layout.footerReferenceSize = CGSizeMake(kScreenW, KMagrinBottom+280);
        _collectionView = [[UICollectionView alloc] initWithFrame:kScreenRect collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[CTImgCollectionViewCell class] forCellWithReuseIdentifier:@"ImageCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"sHeader"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"sFooter"];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (UIImageView *)releaseImgV {
    if (!_releaseImgV) {
        _releaseImgV = [[UIImageView alloc] init];
        _releaseImgV.image = [UIImage imageNamed:@"ct_fabuImg"];
    }
    return _releaseImgV;
}

- (UILabel *)imgLbl {
    if (!_imgLbl) {
        _imgLbl = [self createLbl];
        _imgLbl.text = @"图片";
    }
    return _imgLbl;
}

- (UILabel *)textLbl {
    if (!_textLbl) {
        _textLbl = [self createLbl];
        _textLbl.text = @"文字内容";
    }
    return _textLbl;
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = UIColorFromHex(0x905800);
        _textView.backgroundColor = [UIColor colorWithRed:233/255.0 green:195/255.0 blue:135/255.0 alpha:1.0];
        _textView.layer.borderWidth = 0.5;
        _textView.layer.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0].CGColor;
        _textView.layer.cornerRadius = 9.3;
    }
    return _textView;
}

- (UIButton *)releaseBtn {
    if (!_releaseBtn) {
        _releaseBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_releaseBtn setBackgroundImage:[UIImage imageNamed:@"ct_fabuBtn"] forState:(UIControlStateNormal)];
    }
    return _releaseBtn;
}

- (NSMutableArray *)cvMArr {
    if (!_cvMArr) {
        _cvMArr = [[NSMutableArray alloc] init];
    }
    return _cvMArr;
}


@end
