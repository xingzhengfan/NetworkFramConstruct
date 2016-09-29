//
//  BlogDetailViewModel.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BlogDataModel;

@interface BlogDetailViewModel : NSObject

@property (nonatomic, assign) NSInteger blogId;
@property (nonatomic, copy) NSString *content;

- (instancetype)initWithBlogDataModel:(BlogDataModel *)blogDataModel;
@end
