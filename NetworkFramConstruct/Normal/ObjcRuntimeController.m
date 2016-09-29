//
//  ObjcRuntimeController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/20.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "ObjcRuntimeController.h"

#import <objc/runtime.h>
#import <objc/objc.h>

@implementation ObjcRuntimeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    testAllocateClass();
}

#pragma mark - 
BOOL
CreateClassDefinition(const char *name, const char *superclassName) {
    
#if 0
    struct objc_class *meta_class;
    struct objc_class *super_class;
    struct objc_class *new_class;
    struct objc_class *root_class;
    va_list agrs;
    
    super_class = (struct objc_class *)objc_lookUpClass(superclassName);
    if (super_class == nil) {
        return NO;
    }
    
    if (objc_lookUpClass(name) != nil) {
        return NO;
    }
    
    root_class = super_class;
    while (root_class->super_class != nil) {
        root_class = root_class->super_class;
    }
    
    new_class = calloc(2, sizeof(struct objc_class));
    meta_class = &new_class[1];
    
    new_class->isa = meta_class;
    new_class->info = CLS_CLASS:
    meta_class->info = CLS_META;
    
    new_class->name = malloc(strlen(name)+1);
    strcpy((char *)new_class->name, name);
    meta_class->name = new_class->name;
    
    new_class->methodLists = calloc(1, sizeof(struct objc_method_list *));
    meta_class->methodLists = calloc(1, sizeof(struct objc_method_list *));
    
    new_class->super_class = super_class;
    meta_class->super_class = super_class->isa;
    meta_class->isa = (void *)root_class->isa;
    
    
    objc_addClass(new_class);
#endif
    return YES;
}

void
ReportFunction(id self, SEL _cmd) {
    NSLog(@">> This object is %p", self);
    NSLog(@">> Class is %@, and super is %@", [self class], [self superclass]);
    
    Class prevClass = NULL;
    int count = 1;
    for (Class currentClass = [self class]; currentClass; ++count) {
        prevClass = currentClass;
        
        NSLog(@">> Following the isa pointer %d times gives %p",count, currentClass);
        
        currentClass = object_getClass(currentClass);
        if (prevClass == currentClass) {
            break;
        }
    }
    
    NSLog(@" >> NSObject's class is %p",[NSObject class]);
    NSLog(@" >> NSObject's meta class is %p",object_getClass([NSObject class]));
}

void
testAllocateClass() {
    Class newClass = objc_allocateClassPair([NSString class], "NSStringSubClass", 0);
    class_addMethod(newClass, @selector(report), (IMP)ReportFunction, "v@:");
    objc_registerClassPair(newClass);
    
    id instanceOfNewClass = [[newClass alloc] init];
    [instanceOfNewClass performSelector:@selector(report)];
}
@end
