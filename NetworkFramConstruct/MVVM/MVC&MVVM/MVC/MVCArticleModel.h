//
//  MVCArticleModel.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/16.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVCArticleModel : NSObject

+ (NSArray *)objcetArrayWithKeyValuesArray:(NSArray *)keyValuesArr;
+ (instancetype)objcetWithKeyValue:(NSDictionary *)keyValue;

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *body;
@end
