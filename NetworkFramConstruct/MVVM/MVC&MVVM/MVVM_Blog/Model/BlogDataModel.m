//
//  BlogDataModel.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "BlogDataModel.h"

@implementation BlogDataModel

+ (instancetype)objectWithKeyValue:(NSDictionary *)keyValue {
    BlogDataModel *item = [BlogDataModel new];
    [item setValuesForKeysWithDictionary:keyValue];
    
    return item;
}

+ (NSArray *)objectArrayWithkeyValues:(NSArray *)keyValues {
    NSMutableArray *objects = [NSMutableArray array];
    for (NSDictionary *keyValue in keyValues) {
        [objects addObject:[BlogDataModel objectWithKeyValue:keyValue]];
    }
    
    return [objects copy];
}


#pragma mark - KVC
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"key:%@ value:%@",key,value);
}
@end
