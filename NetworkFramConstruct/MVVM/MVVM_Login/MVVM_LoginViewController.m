//
//  MVVM_LoginViewController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/11.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "MVVM_LoginViewController.h"

#import "LoginUser.h"
#import "LoginViewModel.h"

@interface MVVM_LoginViewController ()

@end

@implementation MVVM_LoginViewController

- (void)viewDidLoad {
    
    LoginUser *user = [[LoginUser alloc] initWithUsername:@"thomass" password:@"q"];
    LoginViewModel *viewModel = [[LoginViewModel alloc] initWithLoginUser:user];
    
    NSLog(@"canLoginIn->%d",viewModel.canLoginIn);
    
}
@end
