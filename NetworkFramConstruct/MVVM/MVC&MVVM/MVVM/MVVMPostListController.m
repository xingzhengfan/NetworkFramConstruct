//
//  MVVMPostListController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/17.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "MVVMPostListController.h"
#import "MVVMPostDetailController.h"

#import "ArticleModel.h"
#import "ArticleListViewModel.h"
#import "ArticleListItemViewModel.h"
#import "ArticleDetailViewModel.h"

#import <ReactiveCocoa.h>
#import <MJRefresh.h>

@interface MVVMPostListController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MVVMPostListController

- (void)viewDidLoad {
    self.hidesBottomBarWhenPushed = YES;
    
    [RACObserve(self.listViewModel, articleListItemViewModels) subscribeNext:^(id x) {
        [self updateView];
    }];
}

- (void)updateView {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
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
        
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [self.listViewModel first];
        }];
        _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            [self.listViewModel next];
        }];
    }
    
    return _tableView;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleListItemViewModel *itemVM = self.listViewModel.articleListItemViewModels[indexPath.row];
    
    ArticleModel *model = [ArticleModel new];
    model.id = itemVM.articleId;
    ArticleDetailViewModel *vm = [[ArticleDetailViewModel alloc] initWithArticleModel:model];
    
    MVVMPostDetailController *controller = [[MVVMPostDetailController alloc] init];
    controller.detailViewModel = vm;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listViewModel.articleListItemViewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    ArticleListItemViewModel * vm = self.listViewModel.articleListItemViewModels[indexPath.row];
    cell.textLabel.text = vm.intro;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
@end
