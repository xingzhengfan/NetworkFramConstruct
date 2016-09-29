//
//  BlogDetailViewModel.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "BlogDetailViewModel.h"
#import "BlogDataModel.h"

#import <AFNetworking.h>
#import <ReactiveCocoa.h>

@interface BlogDetailViewModel ()

@property (nonatomic, copy) NSString *requestPath;
@property (nonatomic, strong) AFHTTPSessionManager *client;
@end

@implementation BlogDetailViewModel

- (instancetype)initWithBlogDataModel:(BlogDataModel *)blogDataModel {
    if (self = [super init]) {
        [RACObserve(blogDataModel, id) subscribeNext:^(id x) {
            self.blogId = [x integerValue];
        }];
        
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.client = [AFHTTPSessionManager manager];
    self.client.requestSerializer = [AFJSONRequestSerializer serializer];
    self.client.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [RACObserve(self, blogId) subscribeNext:^(NSNumber * blogId) {
        self.requestPath = [NSString stringWithFormat:@"http://www.ios122.com/find_php/index.php?viewController=YFPostViewController&model[id]=%ld",blogId.integerValue];
    }];
    
    [RACObserve(self, requestPath) subscribeNext:^(NSString * requestPath) {
        [self.client GET:requestPath parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                BlogDataModel *dataModel = [BlogDataModel objectWithKeyValue:responseObject];
                self.content = dataModel.body;
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error->%@",error);
        }];
    }];
}
@end
