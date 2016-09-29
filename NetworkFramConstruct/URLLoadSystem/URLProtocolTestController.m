//
//  URLProtocolTestController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/8/23.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "URLProtocolTestController.h"

#import "CustomURLProtocol.h"

@implementation URLProtocolTestController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        
        [NSURLProtocol registerClass:[CustomURLProtocol class]];
    }
    
    return self;
}

- (void)dealloc {
    
    [NSURLProtocol unregisterClass:[CustomURLProtocol class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

#pragma mark - 
- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.cocoachina.com"]]];
    
    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://blog.csdn.net/u010962810"]];
//    request.HTTPBody = [[NSData alloc] initWithBase64EncodedString:@"hahaha" options:NSDataBase64DecodingIgnoreUnknownCharacters];
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        NSLog(@"completion");
//    }];
//    [task resume];
}
@end
