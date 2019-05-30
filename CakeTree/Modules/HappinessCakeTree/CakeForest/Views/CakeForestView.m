//
//  CakeForestView.m
//  CakeTree
//
//  Created by xush on 2019/5/25.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeForestView.h"
#import "CakeForestHeaderView.h"
#import "CakeForestTableViewCell.h"

#import "UILabel+String.h"

NSString * const kCakeForestMyTreeBtnClick = @"kCakeForestMyTreeBtnClick";

@interface CakeForestView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *backgroundImgV;
@property (nonatomic, strong) UITableView *tableV;
@property (nonatomic, strong) UIButton *myTreeBtn;
@property (nonatomic, strong) CakeForestHeaderView *tvHeaderV;

@property (nonatomic, strong) NSMutableArray * momentList;  // 朋友圈动态列表

@end

@implementation CakeForestView

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorFromHex(0x5DBFB0);
        [self addSubview:self.backgroundImgV];
        [self addSubview:self.tableV];
        [self addSubview:self.myTreeBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 做布局的事情
    [self.myTreeBtn centerEqualToView:self];
    [self.myTreeBtn setCt_size:CGSizeMake(100, 20)];
    
    [self.backgroundImgV fill];
    [self.backgroundImgV setSize:(CGSizeMake(375, 410)) screenType:(UIScreenType_iPhone6)];
    
    [self.tableV fill];
    
    [self.tvHeaderV fill];
    [self.tvHeaderV setCt_height:280];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.momentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"CakeForestTableViewCell";
    CakeForestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[CakeForestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.moment = self.momentList[indexPath.row];
    [cell configWithData:@{}];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - event response

- (void)btnClick:(id)sender {
    [self.myTreeBtn routerEventWithName:kCakeForestMyTreeBtnClick userInfo:@{}];
}

#pragma mark - public methods

- (void)configWithData:(NSDictionary *)data {
    [self.momentList addObjectsFromArray:[MomentUtil getMomentList:0 pageNum:10]];
    [self.tableV reloadData];
}

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UIImageView *)backgroundImgV {
    if (!_backgroundImgV) {
        _backgroundImgV = [[UIImageView alloc] init];
        _backgroundImgV.image = [UIImage imageNamed:@"bg_forest"];
    }
    return _backgroundImgV;
}

- (UIButton *)myTreeBtn {
    if (!_myTreeBtn) {
        _myTreeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_myTreeBtn setTitle:@"我的幸福蛋糕树" forState:(UIControlStateNormal)];
        [_myTreeBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _myTreeBtn;
}

- (UITableView *)tableV {
    if (!_tableV) {
        _tableV = [[UITableView alloc] init];
        _tableV.backgroundColor = [UIColor clearColor];
        _tableV.tableHeaderView = self.tvHeaderV;
        _tableV.estimatedRowHeight = 300;
        _tableV.dataSource = self;
        _tableV.delegate = self;
    }
    return _tableV;
}

- (CakeForestHeaderView *)tvHeaderV {
    if (!_tvHeaderV) {
        _tvHeaderV = [[CakeForestHeaderView alloc] init];
    }
    return _tvHeaderV;
}

- (NSMutableArray *)momentList {
    if (!_momentList) {
        _momentList = [NSMutableArray array];
    }
    return _momentList;
}


@end
