//
//  ArticleListViewModel.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CategoryArticleListModel;

@interface ArticleListViewModel : NSObject

@property (nonatomic, copy) NSArray * articleListItemViewModels;

- (void)first;
- (void)next;

- (instancetype)initWithCategoryArticleListModel:(CategoryArticleListModel *)articleListModel;
@end
