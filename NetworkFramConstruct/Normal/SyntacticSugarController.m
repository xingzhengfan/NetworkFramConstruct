//
//  SyntacticSugarController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/8/31.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "SyntacticSugarController.h"
#import "TargetWarpper.h"
#import "Target.h"

#define Keypath(keypath) (strchr(#keypath, '.') + 1)

@interface SyntacticSugarController ()

@property (nonatomic, strong) TargetWarpper *target;

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation SyntacticSugarController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    test_feature();
    
    self.target = [TargetWarpper new];
    self.target.target = [Target new];
    self.target.target.age = 1;
    self.target.target.grade = 1;
    
    [self.target addObserver:self forKeyPath:@"information.length" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
    self.target.target.age = 12;
    self.target.target.grade = 12;

    
    self.imageView = ({
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, 100, 100);
        imageView.backgroundColor = [UIColor redColor];
        [self.view addSubview:imageView];
        
        imageView;
    });
}

char * obtain_c_string();

void test_feature() {
    
    NSLog(@"%@",@"foo".class);
    NSLog(@"%@",@("foo").class);
    NSLog(@"%@",@(obtain_c_string()).class);
    NSLog(@"%@",@"aaa");
    NSLog(@"%@",@("aaa"));
}

char * obtain_c_string() {
    return "c_string";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    NSLog(@"%@ -- %@",keyPath,change);
}
@end
