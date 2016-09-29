//
//  ArticleDetailViewModel.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/31.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ArticleModel;

@interface ArticleDetailViewModel : NSObject

@property (nonatomic, assign) NSInteger articleId;
@property (nonatomic, copy) NSString *content;

- (instancetype)initWithArticleModel:(ArticleModel *)articleModel;

@end
