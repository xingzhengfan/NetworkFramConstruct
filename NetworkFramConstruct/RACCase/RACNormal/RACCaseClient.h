//
//  RACCaseClient.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/17.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
@class RACCaseUser;

@interface RACCaseClient : NSObject

- (RACSignal *)loginIn;
- (RACSignal *)fetchUserRepos;
- (RACSignal *)fetchOrgRepos;

- (RACSignal *)loginInUser;
- (RACSignal *)loadCachedMessagesForUser:(RACCaseUser *)user;
- (RACSignal *)fetchMessageAfterMessage:(NSString *)message;

- (void)loginInUserWithSuccess:(void(^)(RACCaseUser *))successBlock
                       failure:(void(^)(NSError *))failureBlock;
- (void)loadCachedMessagesForUser:(RACCaseUser *)user
                          success:(void(^)(NSArray *))successBlock
                     failureBlock:(void(^)(NSError *))failureBlock;
- (void)fetchMessageAfterMessage:(NSString *)message
                         success:(void(^)(NSArray *))successBlock
                    failureBlock:(void(^)(NSError *))failureBlock;

- (RACSignal *)fetchUserAvatarWithUsername:(NSString *)username;


@property (nonatomic, assign, readonly) BOOL loginned;
- (void)traditional_loginWithUsername:(NSString *)username
                             password:(NSString *)password
                              success:(void(^)(void))successBlock
                              failure:(void(^)(NSError *error))failureBlock;
- (RACSignal *)rac_loginWithUsername:(NSString *)username
                            password:(NSString *)password;


#pragma mark - logout
- (void)traditional_logout;
@end
