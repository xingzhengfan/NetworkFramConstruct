//
//  ArticleDetailViewModel.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/31.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "ArticleDetailViewModel.h"
#import "ArticleModel.h"

#import <ReactiveCocoa.h>
#import <AFNetworking.h>

@interface ArticleDetailViewModel ()
@property (nonatomic, strong) AFHTTPSessionManager * client;
@property (nonatomic, copy) NSString * requestPath;
@end

@implementation ArticleDetailViewModel
- (instancetype)initWithArticleModel:(ArticleModel *)articleModel {
    self = [super init];
    if (nil != self) {
        [RACObserve(articleModel, id) subscribeNext:^(id x) {
            self.articleId = [x integerValue];
        }];
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.client = [AFHTTPSessionManager manager];
    self.client.requestSerializer = [AFJSONRequestSerializer serializer];
    self.client.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [[RACObserve(self, articleId) filter:^BOOL(id value) {
        return value;
    }] subscribeNext:^(NSNumber * articleId) {
        self.requestPath = [NSString stringWithFormat:@"http://www.ios122.com/find_php/index.php?viewController=YFPostViewController&model[id]=%ld",articleId.integerValue];
    }];
    
    [[RACObserve(self, requestPath) filter:^BOOL(id value) {
        return value;
    }] subscribeNext:^(NSString * path) {
        [self.client GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            ArticleModel *model = [ArticleModel objcetWithKeyValue:responseObject];
            self.content = model.body;
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }];
}
@end
