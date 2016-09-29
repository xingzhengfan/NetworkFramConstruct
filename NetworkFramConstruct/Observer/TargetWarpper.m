//
//  TargetWarpper.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/4/19.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "TargetWarpper.h"
#import "Target.h"

@implementation TargetWarpper

@synthesize target = _target;

- (id)initWithTarget:(Target *)target {
    if (self = [super init]) {
        self->_target = target;
    }
    return self;
}

- (void)dealloc {
    self->_target = nil;
}

- (NSString *)information {
    return [NSString stringWithFormat:@"%ld#%ld",_target.grade,_target.age];
}

- (void)setInformation:(NSString *)information {
    NSArray *arr = [information componentsSeparatedByString:@"#"];
    
    _target.grade = [arr[0] integerValue];
    _target.age = [arr[1] integerValue];
}

+ (NSSet *)keyPathsForValuesAffectingInformation {
    NSSet *keyPaths = [NSSet setWithObjects:@"target.grade", @"target.age", nil];
    
    return keyPaths;
}

@end
