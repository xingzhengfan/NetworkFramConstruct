//
//  MainTestController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/4/22.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "MainTestController.h"

#import "Normal/NormalController.h"
#import "Normal/ObjcRuntimeController.h"
#import "Normal/MsgPackTestController.h"
#import "Observer/ObserverTestController.h"
#import "Normal/NSURLSessionTestController.h"
#import "URLLoadSystem/URLProtocolTestController.h"
#import "Normal/SyntacticSugarController.h"

#import "MVVM_LoginViewController.h"
#import "MVCPostlistController.h"

#import "MVVMPostListController.h"
#import "ArticleListViewModel.h"
#import "CategoryArticleListModel.h"

#import "BlogListController.h"
#import "BLogListViewModel.h"
#import "CategoryBlogListDataModel.h"

#import "RACCase/RACNormal/RACCaseController.h"
#import "RACCase/ReactiveInstantiate/ImiateFollowController.h"

#import "UseXibController.h"
#import "UseXib_Cell_Controller.h"
#import "DivideEquleController.h"
#import "T1Controller.h"
#import "T2Controller.h"
#import "T3Controller.h"
#import "T4Controller.h"
#import "T5Controller.h"

static NSString * MainTestTableCellIdentifier = @"MainTestTableCellIdentifier";

@interface MainTestController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MainTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.backgroundColor = [UIColor purpleColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (UITableView *)tableView {
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableView registerClass:NSClassFromString(@"UITableViewCell") forCellReuseIdentifier:MainTestTableCellIdentifier];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [self.view addSubview:_tableView];
    }
    
    return _tableView;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    } else if (section == 1) {
        return 7;
    } else if (section == 2) {
        return 1;
    } else if (section == 3) {
        return 9;
    }
    
    return 0;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"MVVV & MVC - test";
    } else if (section == 1) {
        return @"Objective C - normal test";
    } else if (section == 2) {
        return @"Reactive";
    } else if (section == 3) {
        return @"AutoLayout";
    }
    
    return @"title";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MainTestTableCellIdentifier];
    if (cell) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"RACCaseController_test";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"MVC_framework_network_test";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"MVVM_framework_network_test";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"MVVM_LoginController_test";
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"MVVM_framework_network_test_blog";
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"normal_test";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"observer_test";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"objc-runtime_test";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"msgPack_test";
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"NSURLSession_test";
        } else if (indexPath.row == 5) {
            cell.textLabel.text = @"NSURLProtocol_test";
        } else if (indexPath.row == 6) {
            cell.textLabel.text = @"syntactic_sugar_test";
        }
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"ImiateFollow";
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"use xib";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"use storyboard";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"use xib cell";
        } else if (indexPath.row == 3) {
            cell.textLabel.text = @"divide into equle parts";
        } else if (indexPath.row == 4) {
            cell.textLabel.text = @"layout_table_1";
        } else if (indexPath.row == 5) {
            cell.textLabel.text = @"layout_table_2";
        } else if (indexPath.row == 6) {
            cell.textLabel.text = @"layout_table_3";
        } else if (indexPath.row == 7) {
            cell.textLabel.text = @"layout_table_4";
        } else if (indexPath.row == 8) {
            cell.textLabel.text = @"layout_table_5";
        }
    }
    
    return cell;
}
#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[RACCaseController alloc] init] animated:YES];
        } else if (indexPath.row == 1) {
            MVCPostlistController *controller = [[MVCPostlistController alloc] init];
            controller.categoryName = @"network";
            [self.navigationController pushViewController:controller animated:YES];
        } else if (indexPath.row == 2) {
            
            CategoryArticleListModel *model = [CategoryArticleListModel new];
            model.category = @"network";
            
            ArticleListViewModel *vm = [[ArticleListViewModel alloc] initWithCategoryArticleListModel:model];
            
            MVVMPostListController *controller = [[MVVMPostListController alloc] init];
            controller.listViewModel = vm;
            
            [self.navigationController pushViewController:controller animated:YES];
        } else if (indexPath.row == 3) {
            [self.navigationController pushViewController:[[MVVM_LoginViewController alloc] init] animated:YES];
        } else if (indexPath.row == 4) {
            
            CategoryBlogListDataModel *model = [CategoryBlogListDataModel new];
            model.category = @"network";
            
            BLogListViewModel *listViewModel = [[BLogListViewModel alloc] initWithCategoryBlogListDataModel:model];
            
            BlogListController *controller = [[BlogListController alloc] init];
            controller.blogListViewModel = listViewModel;
            [self.navigationController pushViewController:controller animated:YES];
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[NormalController alloc] init] animated:YES];
        } else if (indexPath.row == 1) {
            [self.navigationController pushViewController:[[ObserverTestController alloc] init] animated:YES];
        } else if (indexPath.row == 2) {
            [self.navigationController pushViewController:[[ObjcRuntimeController alloc] init] animated:YES];
        } else if (indexPath.row == 3) {
            [self.navigationController pushViewController:[[MsgPackTestController alloc] init] animated:YES];
        } else if (indexPath.row == 4) {
            [self.navigationController pushViewController:[[NSURLSessionTestController alloc] init] animated:YES];
        } else if (indexPath.row == 5) {
            [self.navigationController pushViewController:[[URLProtocolTestController alloc] init] animated:YES];
        } else if (indexPath.row == 6) {
            [self.navigationController pushViewController:[[SyntacticSugarController alloc] init] animated:YES];
        }

    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[ImiateFollowController alloc] init] animated:YES];
        }
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[[UseXibController alloc] init] animated:YES];
        } else if (indexPath.row == 1) {
            UIViewController *controller = [[UIStoryboard storyboardWithName:@"UseStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"UseStoryboardController"];
            [self.navigationController pushViewController:controller animated:YES];
        } else if (indexPath.row == 2) {
            [self.navigationController pushViewController:[[UseXib_Cell_Controller alloc] init] animated:YES];
        } else if (indexPath.row == 3) {
            [self.navigationController pushViewController:[[DivideEquleController alloc] init] animated:YES];
        } else if (indexPath.row == 4) {
            [self.navigationController pushViewController:[[T1Controller alloc] init] animated:YES];
        } else if (indexPath.row == 5) {
            [self.navigationController pushViewController:[[T2Controller alloc] init] animated:YES];
        } else if (indexPath.row == 6) {
            [self.navigationController pushViewController:[[T3Controller alloc] init] animated:YES];
        } else if (indexPath.row == 7) {
            [self.navigationController pushViewController:[[T4Controller alloc] init] animated:YES];
        } else if (indexPath.row == 8) {
            [self.navigationController pushViewController:[[T5Controller alloc] init] animated:YES];
        }
    }
}

@end
