
//
//  RACCaseClient.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/17.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "RACCaseClient.h"

#import "RACCaseUser.h"

static NSString * avatarURLString = @"http://m.tiebaimg.com/timg?wapp&quality=80&size=b150_150&subsize=20480&cut_x=0&cut_w=0&cut_y=0&cut_h=0&sec=1369815402&srctrace&di=b8f9d8a7b56a01c1bb06c8d008af1174&wh_rate=null&src=http%3A%2F%2Fimgsrc.baidu.com%2Fforum%2Fpic%2Fitem%2F0d338744ebf81a4cd86819c1d42a6059252da664.jpg";

@interface RACCaseClient ()

@property (nonatomic, assign, readwrite) BOOL loginned;
@end

@implementation RACCaseClient

- (RACSignal *)loginIn {
    
    return [RACSignal startEagerlyWithScheduler:RACScheduler.scheduler block:^(id<RACSubscriber> subscriber) {
        [NSThread sleepForTimeInterval:5];
        NSLog(@"LoginSuccess");
        
        [subscriber sendCompleted];
    }];
}
- (RACSignal *)fetchUserRepos {
    return [RACSignal startEagerlyWithScheduler:RACScheduler.scheduler block:^(id<RACSubscriber> subscriber) {
        [NSThread sleepForTimeInterval:5];
        NSLog(@"fetchUserRepos success");
        
        [subscriber sendCompleted];
    }];
}
- (RACSignal *)fetchOrgRepos {
    return [RACSignal startEagerlyWithScheduler:RACScheduler.scheduler block:^(id<RACSubscriber> subscriber) {
        [NSThread sleepForTimeInterval:3];
        NSLog(@"fetchOrgRepos success");
        
        [subscriber sendCompleted];
    }];
}

- (RACSignal *)loginInUser{
    return [RACSignal startEagerlyWithScheduler:RACScheduler.scheduler block:^(id<RACSubscriber> subscriber) {
        [NSThread sleepForTimeInterval:3];
        BOOL loginState = YES;
        
        if (loginState) {
            NSLog(@"loginInUser success");
            [subscriber sendNext:[RACCaseUser new]];
            
            [subscriber sendCompleted];
        } else {
            NSLog(@"loginInUser fali");
            [subscriber sendError:[NSError errorWithDomain:@"login fail" code:500 userInfo:nil]];
        }
    }];
} 
- (RACSignal *)loadCachedMessagesForUser:(RACCaseUser *)user{
    return [RACSignal startEagerlyWithScheduler:RACScheduler.scheduler block:^(id<RACSubscriber> subscriber) {
        [NSThread sleepForTimeInterval:3];
        BOOL loginState = YES;
        
        if (loginState) {
            NSLog(@"loadCachedMessagesForUser success");
            
            [subscriber sendNext:@[@"fanxingzheng",@"Thomas"]];
            
            [subscriber sendCompleted];
        } else {
            NSLog(@"loadCachedMessagesForUser fali");
            [subscriber sendError:[NSError errorWithDomain:@"loadCachedMessagesForUser fail" code:500 userInfo:nil]];
        }
    }];
}
- (RACSignal *)fetchMessageAfterMessage:(NSString *)message{
    return [RACSignal startEagerlyWithScheduler:RACScheduler.scheduler block:^(id<RACSubscriber> subscriber) {
        [NSThread sleepForTimeInterval:3];
        BOOL loginState = YES;
        
        if (loginState) {
            NSLog(@"fetchMessageAfterMessage success");
            
            [subscriber sendNext:[message componentsSeparatedByString:@""]];
            
            [subscriber sendCompleted];
        } else {
            NSLog(@"fetchMessageAfterMessage fali");
            [subscriber sendError:[NSError errorWithDomain:@"fetchMessageAfterMessage fail" code:500 userInfo:nil]];
        }
    }];
}

- (void)loginInUserWithSuccess:(void (^)(RACCaseUser *))successBlock failure:(void (^)(NSError *))failureBlock {
    [NSThread sleepForTimeInterval:3];
    BOOL loginState = YES;
    
    if (loginState) {
        NSLog(@"traditional_loginInSuccess");
        if (successBlock) {
            successBlock([RACCaseUser new]);
        }
    } else {
        NSLog(@"traditional_loginInFailure");
        if (failureBlock) {
            failureBlock([NSError errorWithDomain:@"traditional_loginFail" code:500 userInfo:nil]);
        }
    }
}
- (void)loadCachedMessagesForUser:(RACCaseUser *)user success:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock {
    [NSThread sleepForTimeInterval:3];
    BOOL loadState = YES;
    
    if (loadState) {
        NSLog(@"traditional_loadCachedMessagesSuccess");
        if (successBlock) {
            successBlock(@[@"fanxingzheng",@"Thomas"]);
        }
    } else {
        NSLog(@"traditional_loadCachedMessagesFail");
        if (failureBlock) {
            failureBlock([NSError errorWithDomain:@"traditional_loadCachedMessagesFail" code:500 userInfo:nil]);
        }
    }
}
- (void)fetchMessageAfterMessage:(NSString *)message success:(void (^)(NSArray *))successBlock failureBlock:(void (^)(NSError *))failureBlock {
    [NSThread sleepForTimeInterval:3];
    BOOL fetchMessageState = YES;
    
    if (fetchMessageState) {
        NSLog(@"traditional_fetchMessageSuccess");
        if (successBlock) {
            successBlock([message componentsSeparatedByString:@""]);
        }
    } else {
        NSLog(@"traditional_fetchMessageFail");
        if (failureBlock) {
            failureBlock([NSError errorWithDomain:@"traditional_fetchMessageFail" code:500 userInfo:nil]);
        }
    }
}

- (RACSignal *)fetchUserAvatarWithUsername:(NSString *)username {
    return [RACSignal startEagerlyWithScheduler:RACScheduler.scheduler block:^(id<RACSubscriber> subscriber) {
        [NSThread sleepForTimeInterval:3];
        NSLog(@"fetchUserAvatarWithUsername success");
        
        RACCaseUser *user = [RACCaseUser new];
        user.avatarURL = [NSURL URLWithString:avatarURLString];
        [subscriber sendNext:user];
        
        [subscriber sendCompleted];
    }];
}


- (void)traditional_loginWithUsername:(NSString *)username password:(NSString *)password success:(void(^)(void))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    if ([username hasPrefix:@"T"] && [password hasPrefix:@"q"]) {
        NSLog(@"login success!");
        self.loginned = YES;
        if (successBlock) {
            successBlock();
        }
    } else {
        NSLog(@"login fail!");
        if (failureBlock) {
            failureBlock([NSError errorWithDomain:@"login fail" code:500 userInfo:nil]);
        }
    }
    
}
- (RACSignal *)rac_loginWithUsername:(NSString *)username password:(NSString *)password {
    
    return [RACSignal startEagerlyWithScheduler:RACScheduler.scheduler block:^(id<RACSubscriber> subscriber) {
        if ([username hasPrefix:@"T"] && [password hasPrefix:@"q"]) {
            NSLog(@"login success!");
            self.loginned = YES;
            
            [subscriber sendCompleted];
        } else {
            NSLog(@"login fail!");
            
            [subscriber sendError:[NSError errorWithDomain:@"login fail" code:500 userInfo:nil]];
        }
    }];
}

#pragma mark - logout

- (void)traditional_logout {
    self.loginned = NO;
}
@end
