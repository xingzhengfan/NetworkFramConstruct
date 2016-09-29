//
//  BlogListController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "BlogListController.h"

#import "BlogListViewModel.h"
#import "BlogListItemViewModel.h"
#import "BlogDetailViewModel.h"

#import "BlogDataModel.h"

#import "BlogDetailController.h"

#import <ReactiveCocoa.h>
#import <MJRefresh.h>

@interface BlogListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation BlogListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RACObserve(self.blogListViewModel, blogListItemViewModels) subscribeNext:^(id x) {
        [self updateView];
    }];
}

- (void)updateView {
    
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - getter
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [self.view addSubview:_tableView];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        
        _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            [self.blogListViewModel next];
        }];
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [self.blogListViewModel first];
        }];
    }
    
    return _tableView;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BlogListItemViewModel *listItemViewModel = self.blogListViewModel.blogListItemViewModels[indexPath.row];
    
    BlogDataModel *dataModel = [BlogDataModel new];
    dataModel.id = listItemViewModel.blogId;
    BlogDetailViewModel *detailViewModel = [[BlogDetailViewModel alloc] initWithBlogDataModel:dataModel];
    
    BlogDetailController *controller = [[BlogDetailController alloc] init];
    controller.blogDetailViewModel = detailViewModel;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.blogListViewModel.blogListItemViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    BlogListItemViewModel *listItemViewModel = self.blogListViewModel.blogListItemViewModels[indexPath.row];
    cell.textLabel.text = listItemViewModel.intro;
    
    return cell;
}
@end
