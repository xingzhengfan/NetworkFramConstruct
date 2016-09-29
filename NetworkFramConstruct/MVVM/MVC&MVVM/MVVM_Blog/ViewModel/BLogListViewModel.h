//
//  BLogListViewModel.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CategoryBlogListDataModel;

@interface BLogListViewModel : NSObject

@property (nonatomic, copy) NSArray *blogListItemViewModels;

- (instancetype)initWithCategoryBlogListDataModel:(CategoryBlogListDataModel *)categoryBlogListDataModel;

- (void)first;
- (void)next;
@end
