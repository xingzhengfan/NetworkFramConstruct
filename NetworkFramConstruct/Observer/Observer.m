//
//  Observer.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/4/19.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "Observer.h"
#import "Target.h"

#import <objc/runtime.h>

@implementation Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"age"]) {
        Class classInfo = (__bridge Class)context;
        
        NSString *className = [NSString stringWithCString:object_getClassName(classInfo) encoding:NSUTF8StringEncoding];
        
        NSLog(@">> class %@->age changed",className);
        NSLog(@"old age is %@",[change objectForKey:@"old"]);
        NSLog(@"new age is %@",[change objectForKey:@"new"]);
    } else if ([keyPath isEqualToString:@"information"]) {
        Class classInfo = (__bridge Class)context;
        
        NSString *className = [NSString stringWithCString:object_getClassName(classInfo) encoding:NSUTF8StringEncoding];
        
        NSLog(@">> class %@->information changed",className);
        NSLog(@"old age is %@",[change objectForKey:@"old"]);
        NSLog(@"new age is %@",[change objectForKey:@"new"]);
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
@end
