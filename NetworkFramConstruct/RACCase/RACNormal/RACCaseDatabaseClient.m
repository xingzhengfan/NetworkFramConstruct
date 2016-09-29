//
//  RACCaseDatabaseClient.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/18.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "RACCaseDatabaseClient.h"

@implementation RACCaseDatabaseClient

+ (NSArray *)fetchObjectsMatchingPredicate:(NSPredicate *)predicate {
    return @[@"fanxingzheng",@"Thomas"];
}

+ (RACSignal *)rac_fetchObjectsMatchingPredicate:(NSPredicate *)predicate {
    return [RACSignal startEagerlyWithScheduler:RACScheduler.scheduler block:^(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@[@"fanxingzheng",@"Thomas"]];
        [subscriber sendCompleted];
    }];
}
@end
