//
//  ArticleListViewModel.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//
#import "ArticleListViewModel.h"
#import "CategoryArticleListModel.h"
#import "ArticleListItemViewModel.h"
#import "ArticleModel.h"

#import <ReactiveCocoa.h>
#import <AFNetworking.h>

@interface ArticleListViewModel ()
@property (nonatomic, strong) AFHTTPSessionManager * client;
@property (nonatomic, assign) NSNumber * nextPage;
@property (nonatomic, copy) NSString * category;
@property (nonatomic, copy) NSString * requestPath;
@end

@implementation ArticleListViewModel

- (instancetype)initWithCategoryArticleListModel:(CategoryArticleListModel *)articleListModel {
    self = [super init];
    if (nil != self) {
        [RACObserve(articleListModel, category) subscribeNext:^(NSString * name) {
            self.category = name;
        }];
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.client = [AFHTTPSessionManager manager];
    self.client.requestSerializer = [AFJSONRequestSerializer serializer];
    self.client.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [RACObserve(self, nextPage) subscribeNext:^(NSNumber * number) {
        self.requestPath = [NSString stringWithFormat:@"http://www.ios122.com/find_php/index.php?viewController=YFPostListViewController&model[category]=%@&model[page]=%ld",self.category,self.nextPage.integerValue];
    }];
    
    [[RACObserve(self, requestPath) filter:^BOOL(id value) {
        return value;
    }] subscribeNext:^(NSString * path) {
        NSMutableArray *articles = [NSMutableArray arrayWithCapacity:42];
        
        [self.client GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            for (NSDictionary *dict in responseObject) {
                ArticleModel *model = [ArticleModel objcetWithKeyValue:dict];
                ArticleListItemViewModel *viewModel = [[ArticleListItemViewModel alloc] initWithArticleModel:model];
                [articles addObject:viewModel];
            }
            self.articleListItemViewModels = articles;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }];
}

- (void)first {
    self.nextPage = @0;
}

- (void)next {
    self.nextPage = [NSNumber numberWithInt:self.nextPage.intValue+1];
}
@end
