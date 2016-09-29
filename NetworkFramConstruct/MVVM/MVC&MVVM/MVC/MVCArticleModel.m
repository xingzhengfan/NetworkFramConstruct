//
//  MVCArticleModel.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/16.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "MVCArticleModel.h"

@implementation MVCArticleModel

+ (NSArray *)objcetArrayWithKeyValuesArray:(NSArray *)keyValuesArr {
    NSMutableArray *objcetArr = [NSMutableArray array];
    
    [keyValuesArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull keyValue, NSUInteger idx, BOOL * _Nonnull stop) {
        [objcetArr addObject:[MVCArticleModel objcetWithKeyValue:keyValue]];
    }];
    
    return objcetArr;
}

+ (instancetype)objcetWithKeyValue:(NSDictionary *)keyValue {
    MVCArticleModel *item = [MVCArticleModel new];
    [item setValuesForKeysWithDictionary:keyValue];
    
    return item;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"%@",key);
}
@end
