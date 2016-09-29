//
//  ImiateFollowController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/8/25.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "ImiateFollowController.h"

@interface ImiateFollowController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITableView *listView;
@end

@implementation ImiateFollowController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark -
- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.listView];
}

#pragma mark -
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 60)];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 120, 20)];
        title.textAlignment = NSTextAlignmentLeft;
        title.font = [UIFont systemFontOfSize:18];
        title.textColor = [UIColor blackColor];
        title.text = @"Who to follow";
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(140, 10, 60, 40);
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitle:@"Refresh" forState:UIControlStateNormal];
        
        [_topView addSubview:title];
        [_topView addSubview:button];
    }
    
    return _topView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 124, self.view.frame.size.width, 40)];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 200, 15)];
        title.textAlignment = NSTextAlignmentLeft;
        title.font = [UIFont systemFontOfSize:12];
        title.textColor = [UIColor blackColor];
        title.text = @"Popular accounts. Find friends";
        
        [_bottomView addSubview:title];
    }
    
    return _bottomView;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}
@end
