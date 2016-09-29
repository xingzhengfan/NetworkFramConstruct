//
//  UseXibController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/9/8.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "UseXibController.h"

@interface UseXibController ()

@end

@implementation UseXibController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
- (IBAction)centerButtonBeTapped:(UIButton *)sender {
    NSLog(@"be tapped!");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
