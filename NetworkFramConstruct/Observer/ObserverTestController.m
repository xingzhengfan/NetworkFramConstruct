//
//  ObserverTestController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/20.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "ObserverTestController.h"

#import <objc/runtime.h>
#import <objc/objc.h>

#import "Observer.h"
#import "Target.h"
#import "TargetWarpper.h"
#import "Foo.h"


#define Keypath(keypath) (strchr(#keypath, '.'),+1)

@implementation ObserverTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    testObserve();
    
    testIsa_swizzling();
}

#pragma mark -
void
testObserve() {
    Observer *observer = [[Observer alloc] init];
    
    Target *target = [[Target alloc] init];
    [target addObserver:observer forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:(__bridge void *)[Target class]];
    
    target.age = 25;
    
    [target removeObserver:observer forKeyPath:@"age"];
    
    TargetWarpper *warpper = [[TargetWarpper alloc] initWithTarget:target];
    [warpper addObserver:observer forKeyPath:@"information" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:(__bridge void*)[Target class]];
    target.age = 30;
    target.grade = 5;
    
    [warpper removeObserver:observer forKeyPath:@"information"];
}

static NSArray *
ClassMethodNames(Class c){
    
    NSMutableArray *arr = [NSMutableArray array];
    unsigned int methodCount = 0;
    Method *methodList = class_copyMethodList(c, &methodCount);
    unsigned int i;
    for (i = 0; i < methodCount; ++i) {
        [arr addObject:NSStringFromSelector(method_getName(methodList[i]))];
    }
    
    return arr;
}

static void
PrintDescription(NSString *name, id obj) {
    
    struct objc_object *objc = (__bridge struct objc_object*)obj;
    NSString *str = [NSString stringWithFormat:@"\n\t%@: %@\n\tNSObject class %s\n\tlibobjc class %s\n\timplements methods <%@>",
                     name,
                     obj,
                     class_getName([obj class]),
                     class_getName(objc->isa),
                     [ClassMethodNames(objc->isa) componentsJoinedByString:@","]];
    
    NSLog(@"%@",str);
}

void
testIsa_swizzling() {
    Foo *anything = [Foo new];
    Foo *x = [Foo new];
    Foo *y = [Foo new];
    Foo *xy = [Foo new];
    Foo *control = [Foo new];
    
    [x addObserver:anything forKeyPath:@"x" options:0 context:NULL];
    [y addObserver:anything forKeyPath:@"y" options:0 context:NULL];
    
    [xy addObserver:anything forKeyPath:@"x" options:0 context:NULL];
    [xy addObserver:anything forKeyPath:@"y" options:0 context:NULL];
    
    
    PrintDescription(@"control", control);
    PrintDescription(@"x", x);
    PrintDescription(@"y", y);
    PrintDescription(@"xy", xy);
    
    NSLog(@"\n\tUsing NSObject methods, normal setX: is %p, overridden setX: is %p\n",
          [control methodForSelector:@selector(setX:)],
          [x methodForSelector:@selector(setX:)]);
    NSLog(@"\n\tUsing libobjc functions, nomal setX: is %p, overridden setX: is %p\n",
          method_getImplementation(class_getInstanceMethod(object_getClass(control), @selector(setX:))),
          method_getImplementation(class_getInstanceMethod(object_getClass(x), @selector(setX:))));
    
    [x removeObserver:anything forKeyPath:@"x"];
    [y removeObserver:anything forKeyPath:@"y"];
    [xy removeObserver:anything forKeyPath:@"x"];
    [xy removeObserver:anything forKeyPath:@"y"];
}
@end
