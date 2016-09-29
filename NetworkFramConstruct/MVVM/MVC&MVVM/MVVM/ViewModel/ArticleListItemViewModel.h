//
//  ArticleListItemViewModel.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArticleModel;

@interface ArticleListItemViewModel : NSObject

@property (nonatomic, copy) NSString * intro;
@property (nonatomic, assign) NSInteger articleId;

- (instancetype)initWithArticleModel:(ArticleModel *)model;
@end
