//
//  LoginViewModel.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/11.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LoginUser;

@interface LoginViewModel : NSObject

- (instancetype)initWithLoginUser:(LoginUser *)user;

@property (nonatomic, assign, readonly) BOOL canLoginIn;
@end
