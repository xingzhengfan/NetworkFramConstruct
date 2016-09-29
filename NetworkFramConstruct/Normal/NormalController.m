//
//  NormalController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/20.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "NormalController.h"

@implementation NormalController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a = 2;
    int b = 0;
    int r =(a?  : (b=3));
    printf("\nr=%d,a=%d,b=%d",r,a,b);
    printf("\n %d",a=3);
    
    NSString *str = @"abc";
    
    //    NSString *string = @encode()();
    //    [str addObserver:self forKeyPath:@"str.length" options:NSKeyValueObservingOptionNew context:nil];
    printf("\n %d",addNotis(1, 4));
    
    testBridge();
    testCopy_mutableCopy();
}

#pragma mark -
int
addNotis(int a, int b) {
    return a+b;
}

void
testCopy_mutableCopy() {
    
    NSMutableString *originStr = [NSMutableString stringWithString:@"originStr"];
    NSString *strCopy = [originStr copy];
    NSMutableString *mStrCopy = [originStr copy];
    NSMutableString *mstrMcopy = [originStr mutableCopy];
    printf("\n%p \n%p \n%p \n%p",originStr,strCopy,mStrCopy,mstrMcopy);
}
void
testBridge() {
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.baidu.com?s?wd=android"];
    CFURLRef ref = (__bridge CFURLRef)url;
    NSURL *url_a = (__bridge_transfer NSURL*)ref;
    
    CFURLRef ref_a = (__bridge_retained CFURLRef)url_a;
    CFRelease(ref_a);
    
    NSString *text = @"text";
    CFStringRef cfString = CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)text, NULL, CFSTR("thames town"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSString *ocString = (__bridge_transfer NSString *)cfString;
    NSLog(@"%@",ocString);
}
@end
