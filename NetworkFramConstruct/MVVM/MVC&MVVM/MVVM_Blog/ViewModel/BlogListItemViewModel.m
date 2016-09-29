//
//  BlogListItemViewModel.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "BlogListItemViewModel.h"
#import "BlogDataModel.h"

#import <ReactiveCocoa.h>

@implementation BlogListItemViewModel

- (instancetype)initWithBlogDataModel:(BlogDataModel *)blogDataModel {
    if (self = [super init]) {
        RAC(self, intro) = [RACSignal combineLatest:@[RACObserve(blogDataModel, title), RACObserve(blogDataModel, desc)] reduce:^id(NSString *title, NSString *desc){
            return [NSString stringWithFormat:@"标题:%@, 内容:%@",title,desc];
        }];
        
        [RACObserve(blogDataModel, id) subscribeNext:^(id x) {
            self.blogId = [x integerValue];
        }];
    }
    
    return self;
}
@end
