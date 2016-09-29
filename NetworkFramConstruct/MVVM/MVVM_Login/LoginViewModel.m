//
//  LoginViewModel.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/11.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginUser.h"

@implementation LoginViewModel

- (instancetype)initWithLoginUser:(LoginUser *)user {
    if (self = [super init]) {
        self->_canLoginIn = [self p_validCanLoginInWithUsername:user.username password:user.password];
    }
    
    return self;
}

- (BOOL)p_validCanLoginInWithUsername:(NSString *)username password:(NSString *)password {
    if ([username isEqualToString:@"thomas"] && [password isEqualToString:@"q"]) {
        return YES;
    }
    
    return NO;
}
@end
