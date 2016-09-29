//
//  BlogDetailController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/6/1.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "BlogDetailController.h"
#import "BlogDetailViewModel.h"

#import <ReactiveCocoa.h>

@interface BlogDetailController ()

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation BlogDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RACObserve(self.blogDetailViewModel, content) subscribeNext:^(id x) {
        [self updateView];
    }];
}

- (void)updateView {
    [self.webView loadHTMLString:self.blogDetailViewModel.content baseURL:nil];
}

#pragma mark - getter
- (UIWebView *)webView {
    if (nil == _webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        
        [self.view addSubview:_webView];
    }
    
    return _webView;
}
@end
