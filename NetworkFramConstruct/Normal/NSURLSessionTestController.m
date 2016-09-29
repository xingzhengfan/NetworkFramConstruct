//
//  NSURLSessionTestController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/8/15.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "NSURLSessionTestController.h"
#import "AppDelegate.h"

static NSString * backgroundSessionIdentifier = @"backgroundSessionIdentifier";
static NSString * currentSessionDescription = @"currentSessionDescription";
static NSString * backgroundSessionDescription = @"backgroundSessionDescription";

@interface NSURLSessionTestController () <NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionTaskDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIButton *cancelButton;

@property (nonatomic, strong) UIImageView *downloadImageView;
@property (nonatomic, strong) UILabel *currentProgressLabel;
@property (nonatomic, strong) UIProgressView *downloadProgressView;

/*
 * NSURLSessionDownloadTask
 */
@property (nonatomic, strong) NSURLSession *currentSession;
@property (nonatomic, strong) NSURLSession *backgroundSession;

@property (nonatomic, strong) NSURLSessionDownloadTask *cancelableTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *resumabelTask;
@property (nonatomic, strong) NSURLSessionDownloadTask *backgroundTask;

@property (nonatomic, strong) NSData *partialData;
@end

@implementation NSURLSessionTestController

- (instancetype)init {
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    configuration.allowsCellularAccess = YES;
//    configuration.discretionary = YES;
//    
//    NSOperationQueue *queue = [NSOperationQueue new];
//    
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:queue];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api-weidu-test.ptdev.cn/product/list"]];
//    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
//    request.timeoutInterval = 10;
//    request.HTTPMethod = @"GET";
//    request.allHTTPHeaderFields = @{};
//    
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
//    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://api-weidu-test.ptdev.cn/product/list"]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (!error) {
//            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//            if (dataDict) {
//                NSLog(@"%@",dataDict);
//            }
//        }
//    }];
    
//    [dataTask resume];
    
//    [self p_dataTask_convenience_test];
//    [self p_uploadTask_convenience_test];
//    [self p_downloadTask_convenience_test];
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *cookies = storage.cookies;
    for (NSHTTPCookie *cookie in cookies) {
        NSLog(@"%@",cookie);
    }
    
    NSDictionary *cookieProperties = @{NSHTTPCookieName:@"username",
                                       NSHTTPCookieValue:@"rainbird",
                                       NSHTTPCookieDomain:@"cnrainbird.com",
                                       NSHTTPCookieOriginURL:@"cnrainbird.com"};
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [storage setCookie:cookie];
}

- (void)setupView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"NSURLSession_test";
//    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.downloadImageView];
    [self.view addSubview:self.segmentedControl];
    [self.view addSubview:self.currentProgressLabel];
    [self.view addSubview:self.downloadProgressView];
    [self.view addSubview:self.cancelButton];
}

#pragma mark - 
- (void)p_dataTask_convenience_test {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://blog.csdn.net/u010962810"]] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse.statusCode == 200) {
            [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:nil];
        }
    }];
    [dataTask resume];
}
- (void)p_uploadTask_convenience_test {
    
    NSURL *URL = [NSURL URLWithString:@"http://example.com/upload"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSData *data = [NSData dataWithContentsOfFile:@"/Users/fanxingzheng/Downloads/tj2GEl2C8EOlNqcLFqPorh0bDVPqCOeRzBMl7v-pa5sEAQAAxAAAAEpQ.jpg" options:NSDataReadingMappedIfSafe error:nil];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%ld",data.length);
    }];
    [uploadTask resume];
}
- (void)p_downloadTask_convenience_test {
    
    NSURL *URL = [NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/w%3D2048/sign=6be5fc5f718da9774e2f812b8469f919/8b13632762d0f703b0faaab00afa513d2697c515.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"location = %@",location);
        
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];
        NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
       
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:[fileURL path] isDirectory:NULL]) {
            [fileManager removeItemAtURL:fileURL error:nil];
        }
        
        [fileManager moveItemAtURL:location toURL:fileURL error:NULL];
        NSURLRequest *show_image_request = [NSURLRequest requestWithURL:fileURL];
        [self.webView loadRequest:show_image_request];
    }];
    [downloadTask resume];
}

#pragma mark - NSURLSessionDelegate
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"didBecomeInvalidWithError");
}
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    NSLog(@"didFinishEventsForBackgroundURLSession");
}
#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    NSLog(@"data_task didReceiveResponse");
    
    completionHandler(NSURLSessionResponseAllow);
}
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    NSLog(@"data_task didReceiveData");
    
    NSString *dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"data->%@",dataStr);
    
    NSError *error = nil;
    NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (!error && dataDict) {
        NSLog(@"%@",dataDict);
    }
}
#pragma mark - NSURLSessionTaskDelegate
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSLog(@"task didCompleteWithError");
    
    if (error) {
        NSLog(@"error->%@",error);
        
        self.downloadImageView.image = nil;
        [self p_setDownloadPregressValue:0.0];
    }
}
#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    
    double downloadProgressValue = totalBytesWritten/(double)totalBytesExpectedToWrite;
    [self p_setDownloadPregressValue:downloadProgressValue];
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"didResumeAtOffset:%lld expectedTotalBytes:%lld",fileOffset,expectedTotalBytes);
    
    double downloadProgressValue = fileOffset/(double)expectedTotalBytes;
    [self p_setDownloadPregressValue:downloadProgressValue];
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] objectAtIndex:0];
    NSURL *destinationPath = [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
    NSError *error = nil;
    
    [fileManager removeItemAtURL:destinationPath error:NULL];
    BOOL success = [fileManager copyItemAtURL:location toURL:destinationPath error:&error];
    if (success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithContentsOfFile:destinationPath.path];
            self.downloadImageView.image = image;
            self.downloadImageView.contentMode = UIViewContentModeScaleAspectFill;
        });
    }
    if (downloadTask == self.cancelableTask) {
        self.cancelableTask = nil;
    } else if (downloadTask == self.resumabelTask) {
        self.resumabelTask = nil;
        self.partialData = nil;
    } else if (session == self.backgroundSession) {
        self.backgroundTask = nil;
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        if (appDelegate.backgroundURLSessionCompletionHandler) {
            void(^handle)() = appDelegate.backgroundURLSessionCompletionHandler;
            appDelegate.backgroundURLSessionCompletionHandler = nil;
            handle();
        }
    }
}
#pragma mark - getter
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    
    return _webView;
}
- (UISegmentedControl *)segmentedControl {
    if (!_segmentedControl) {
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"cancelable",@"resumable",@"background"]];
        _segmentedControl.frame = CGRectMake(30, 100, self.view.frame.size.width-60, 30);
        [_segmentedControl addTarget:self action:@selector(p_segmentedDidSelected:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _segmentedControl;
}
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _cancelButton.frame = CGRectMake(30, self.view.frame.size.height-100, self.view.frame.size.width-60, 44);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(p_cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}
- (UIImageView *)downloadImageView {
    if (!_downloadImageView) {
        _downloadImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }
    
    return _downloadImageView;
}
- (UILabel *)currentProgressLabel {
    if (!_currentProgressLabel) {
        _currentProgressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 30)];
        _currentProgressLabel.textAlignment = NSTextAlignmentCenter;
        _currentProgressLabel.font = [UIFont systemFontOfSize:20];
    }
    
    return _currentProgressLabel;
}
- (UIProgressView *)downloadProgressView {
    if (!_downloadProgressView) {
        _downloadProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _downloadProgressView.frame = CGRectMake(30, 270, self.view.frame.size.width-60, 10);
    }
    
    return _downloadProgressView;
}
#pragma mark - getter
- (NSURLSession *)currentSession {
    if (!_currentSession) {
        NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _currentSession = [NSURLSession sessionWithConfiguration:defaultConfig delegate:self delegateQueue:nil];
        _currentSession.sessionDescription = currentSessionDescription;
    }
    
    return _currentSession;
}
- (NSURLSession *)backgroundSession {
    if (!_backgroundSession) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:backgroundSessionIdentifier];
        _backgroundSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        _backgroundSession.sessionDescription = backgroundSessionDescription;
    }
    
    return _backgroundSession;
}
- (NSURLSessionDownloadTask *)cancelableTask {
    if (!_cancelableTask) {
        NSString *imageURLStr = @"http://farm6.staticflickr.com/5505/9824098016_0e28a047c2_b_d.jpg";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];
        
        _cancelableTask = [self.currentSession downloadTaskWithRequest:request];
    }
    
    return _cancelableTask;
}
- (NSURLSessionDownloadTask *)resumabelTask {
    if (!_resumabelTask) {
        if (self.partialData) {
            _resumabelTask = [self.currentSession downloadTaskWithResumeData:self.partialData];
        } else {
            NSString *imageURLStr = @"http://farm3.staticflickr.com/2846/9823925914_78cd653ac9_b_d.jpg";
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];
            
            _resumabelTask = [self.currentSession downloadTaskWithRequest:request];
        }
    }
    
    return _resumabelTask;
}
- (NSURLSessionDownloadTask *)backgroundTask {
    if (!_backgroundTask) {
        NSString *imageURLStr = @"http://farm3.staticflickr.com/2831/9823890176_82b4165653_b_d.jpg";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];
        
        _backgroundTask = [self.backgroundSession downloadTaskWithRequest:request];
    }
    
    return _backgroundTask;
}
#pragma mark -
- (void)p_segmentedDidSelected:(UISegmentedControl *)sender {
    int32_t index = (int32_t)sender.selectedSegmentIndex;
    if (index == 0) {
        [self.cancelableTask resume];
    } else if (index == 1) {
        [self.resumabelTask resume];
    } else if (index == 2) {
        [self.backgroundTask resume];
    }
}
- (void)p_cancelButtonPressed:(UIButton *)sender {
    
    int32_t segmentedControlIndex = (int32_t)self.segmentedControl.selectedSegmentIndex;
    if (segmentedControlIndex == 0) {
        [self.cancelableTask cancel];
        self.cancelableTask = nil;
    } else if (segmentedControlIndex == 1) {
        [self.resumabelTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            self.partialData = resumeData;
            self.resumabelTask = nil;
        }];
    } else if (segmentedControlIndex == 2) {
        [self.backgroundTask cancel];
        self.backgroundTask = nil;
    }
}
#pragma mark - 
- (void)p_setDownloadPregressValue:(double)value {
    NSString *valueStr = [NSString stringWithFormat:@"%.1f%@",value*100,@"%"];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.downloadProgressView.progress = value;
        self.currentProgressLabel.text = valueStr;
    });
}
@end
