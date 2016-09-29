//
//  BlogListItemViewModel.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BlogDataModel;

@interface BlogListItemViewModel : NSObject

@property (nonatomic, assign) NSInteger blogId;
@property (nonatomic, copy) NSString *intro;

- (instancetype)initWithBlogDataModel:(BlogDataModel *)blogDataModel;
@end
