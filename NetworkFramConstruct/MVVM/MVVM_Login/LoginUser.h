//
//  LoginUser.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/11.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginUser : NSObject

@property (nonatomic, copy, readonly) NSString *username;
@property (nonatomic, copy, readonly) NSString *password;

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password;
@end
