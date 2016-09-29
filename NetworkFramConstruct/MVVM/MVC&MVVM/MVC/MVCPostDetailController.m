//
//  MVCPostDetailController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/16.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "MVCPostDetailController.h"

#import "MVCArticleModel.h"

#import <AFNetworking.h>
#import <MBProgressHUD.h>

@interface MVCPostDetailController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) MVCArticleModel *article;
@end

@implementation MVCPostDetailController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self p_updateData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self p_updateData];
}

- (UIWebView *)webView {
    if (nil == _webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        
        [self.view addSubview:_webView];
    }
    
    return _webView;
}

- (void)p_updateView {
    [self.webView loadHTMLString:self.article.body baseURL:nil];
}

- (void)p_updateData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"http://www.ios122.com/find_php/index.php?viewController=YFPostViewController&model[id]=%ld",self.id] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        
        self.article = [MVCArticleModel objcetWithKeyValue:responseObject];
        [self p_updateView];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"加载成功";
        [hud hide:YES afterDelay:2];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您的网络不给力";
        [hud hide:YES afterDelay:2];
    }];
}
@end
