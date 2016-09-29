//
//  BlogDataModel.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogDataModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *body;

+ (instancetype)objectWithKeyValue:(NSDictionary *)keyValue;
+ (NSArray *)objectArrayWithkeyValues:(NSArray *)keyValues;
@end
