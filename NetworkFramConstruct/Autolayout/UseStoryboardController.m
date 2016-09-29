//
//  UseStoryboardController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/9/8.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "UseStoryboardController.h"

@interface UseStoryboardController ()

@end

@implementation UseStoryboardController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstButtonClick:(UIButton *)sender {
    
    [self performSegueWithIdentifier:@"toFirst" sender:nil];
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
