//
//  LoginUser.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/11.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "LoginUser.h"

@implementation LoginUser

- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password {
    if (self = [super init]) {
        self->_username = [username copy];
        self->_password = [password copy];
    }
    
    return self;
}
@end
