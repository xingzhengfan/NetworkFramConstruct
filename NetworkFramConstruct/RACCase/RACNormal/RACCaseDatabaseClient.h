//
//  RACCaseDatabaseClient.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/18.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
@interface RACCaseDatabaseClient : NSObject


+ (NSArray *)fetchObjectsMatchingPredicate:(NSPredicate *)predicate;
+ (RACSignal *)rac_fetchObjectsMatchingPredicate:(NSPredicate *)predicate;
@end
