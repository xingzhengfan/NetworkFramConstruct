//
//  BLogListViewModel.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "BLogListViewModel.h"
#import "CategoryBlogListDataModel.h"
#import "BlogDataModel.h"
#import "BlogListItemViewModel.h"

#import <AFNetworking.h>
#import <ReactiveCocoa.h>

@interface BLogListViewModel ()

@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSNumber *page;
@property (nonatomic, copy) NSString *requestPath;
@property (nonatomic, strong) AFHTTPSessionManager *client;
@end

@implementation BLogListViewModel

- (instancetype)initWithCategoryBlogListDataModel:(CategoryBlogListDataModel *)categoryBlogListDataModel {
    if (self = [super init]) {
        [RACObserve(categoryBlogListDataModel, category) subscribeNext:^(NSString * category) {
            self.category = category;
        }];
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.client = [AFHTTPSessionManager manager];
    self.client.requestSerializer = [AFJSONRequestSerializer serializer];
    self.client.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [RACObserve(self, page) subscribeNext:^(NSNumber * page) {
        self.requestPath = [NSString stringWithFormat:@"http://www.ios122.com/find_php/index.php?viewController=YFPostListViewController&model[category]=%@&model[page]=%ld",self.category,page.integerValue];
    }];
    
    [RACObserve(self, requestPath) subscribeNext:^(NSString * requestPath) {
        [self.client GET:requestPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                NSArray *blogDataModels = [BlogDataModel objectArrayWithkeyValues:responseObject];
                
                NSMutableArray *blogItemViewModels = [NSMutableArray array];
                for (BlogDataModel *dataModel in blogDataModels) {
                    [blogItemViewModels addObject:[[BlogListItemViewModel alloc] initWithBlogDataModel:dataModel]];
                }
                self.blogListItemViewModels = [blogItemViewModels copy];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error->%@",error);
        }];
    }];
}

- (void)first {
    self.page = @0;
}

- (void)next {
    self.page = @(self.page.intValue+1);
}
@end
