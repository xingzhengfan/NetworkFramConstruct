//
//  Target.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/4/19.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "Target.h"

@implementation Target


- (instancetype)init {
    if (self = [super init]) {
        self.age = 10;
    }
    
    return self;
}

- (void)setAge:(NSInteger)age {
    [self willChangeValueForKey:@"age"];
    
    self->_age = age;
    [self didChangeValueForKey:@"age"];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if ([key isEqualToString:@"age"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}
@end
