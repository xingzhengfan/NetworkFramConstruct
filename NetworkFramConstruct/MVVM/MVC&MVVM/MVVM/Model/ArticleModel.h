//
//  ArticleModel.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/30.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleModel : NSObject

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * desc;
@property (nonatomic, copy) NSString * body;

@property (nonatomic, assign) NSInteger id;

+ (NSArray *)objcetArrayWithKeyValuesArray:(NSArray *)keyValuesArr;
+ (instancetype)objcetWithKeyValue:(NSDictionary *)keyValue;
@end
