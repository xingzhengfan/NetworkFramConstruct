//
//  ArticleListItemViewModel.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "ArticleListItemViewModel.h"
#import <ReactiveCocoa.h>

#import "ArticleModel.h"

@implementation ArticleListItemViewModel


- (instancetype)initWithArticleModel:(ArticleModel *)model {
    self = [super init];
    if (nil != self) {
        RAC(self, intro) = [RACSignal combineLatest:@[RACObserve(model, title), RACObserve(model, desc)] reduce:^id(NSString * title, NSString * desc){
            NSString *intro = [NSString stringWithFormat:@"标题:%@,内容:%@",title,desc];
            return intro;
        }];
        
        [RACObserve(model, id) subscribeNext:^(id x) {
            self.articleId = [x integerValue];
        }];
    }
    
    return self;
}
@end
