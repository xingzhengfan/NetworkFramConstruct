//
//  MVCPostlistController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/16.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "MVCPostlistController.h"
#import "MVCPostDetailController.h"

#import "MVCArticleModel.h"

#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MBProgressHUD.h>
#import <Masonry.h>

@interface MVCPostlistController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *articles;
@property (nonatomic, assign) NSInteger page;
@end

@implementation MVCPostlistController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    
//    [self.tableView.mj_header beginRefreshing];
}

- (void)p_updateView {
    [self.tableView reloadData];
}

- (void)p_updateData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"http://www.ios122.com/find_php/index.php?viewController=YFPostListViewController&model[category]=%@&model[page]=%ld",self.categoryName,(long)self.page++] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        if (1 == self.page) {
            self.articles = nil;
        }
        
        [self.articles addObjectsFromArray:[MVCArticleModel objcetArrayWithKeyValuesArray:responseObject]];
        
        [self p_updateView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力";
        [hud hide:YES afterDelay:2];
    }];
}

- (NSMutableArray *)articles {
    if (nil == _articles) {
        _articles = [NSMutableArray arrayWithCapacity:42];
    }
    
    return _articles;
}

- (UITableView *)tableView{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        [self.view addSubview:_tableView];
        
//        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
//        }];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        NSString *cellReuseIdentifier = NSStringFromClass([UITableViewCell class]);
        [_tableView registerClass:NSClassFromString(cellReuseIdentifier) forCellReuseIdentifier:cellReuseIdentifier];
        
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            self.page = 0;
            [self p_updateData];
        }];
        _tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
            [self p_updateData];
        }];
    }
    
    return _tableView;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MVCArticleModel *item = self.articles[indexPath.row];
    
    MVCPostDetailController *controller = [[MVCPostDetailController alloc] init];
    controller.id = item.id;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    
    MVCArticleModel *item = self.articles[indexPath.row];
    cell.textLabel.text = item.desc;
    
    return cell;
}
@end
