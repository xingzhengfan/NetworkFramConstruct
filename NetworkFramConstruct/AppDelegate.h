//
//  AppDelegate.h
//  NetworkFramConstruct
//
//  Created by so on 16/3/17.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (copy) void (^backgroundURLSessionCompletionHandler)();
@end

