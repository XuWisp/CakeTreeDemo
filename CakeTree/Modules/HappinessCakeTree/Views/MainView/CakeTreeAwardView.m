//
//  CakeTreeAwardView.m
//  CakeTree
//
//  Created by 徐沙洪 on 2019/6/4.
//  Copyright © 2019 Xush. All rights reserved.
//

#import "CakeTreeAwardView.h"

@interface CakeTreeAwardView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableV;


@end

@implementation CakeTreeAwardView

#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tableV];
        [self VFLlayout];
    }
    return self;
}

- (void)VFLlayout {
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"CakeForestTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - event response

#pragma mark - public methods

#pragma mark - private methods
// 正常情况下ViewController里面不应该写这层代码

#pragma mark - getters and setters

- (UITableView *)tableV {
    if (!_tableV) {
        _tableV = [[UITableView alloc] init];
        _tableV.backgroundColor = [UIColor clearColor];
        _tableV.estimatedRowHeight = 120;
        _tableV.dataSource = self;
        _tableV.delegate = self;
        _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableV;
}

@end
