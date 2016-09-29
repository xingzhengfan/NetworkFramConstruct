//
//  MVVMPostDetailController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/17.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "MVVMPostDetailController.h"
#import "ArticleDetailViewModel.h"
#import <ReactiveCocoa.h>

@interface MVVMPostDetailController ()

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation MVVMPostDetailController

- (void)viewDidLoad {
    [RACObserve(self.detailViewModel, content) subscribeNext:^(id x) {
        [self updateView];
    }];
}

- (void)updateView {
    [self.webView loadHTMLString:self.detailViewModel.content baseURL:nil];
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
