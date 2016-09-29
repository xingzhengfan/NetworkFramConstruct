//
//  FirstTableController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/9/12.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "FirstTableController.h"

#import "FirstTableCell.h"
#import "UIImage+Resize.h"

@interface FirstTableController ()
{
@private
    NSMutableArray *_labelArray;
    
    FirstTableCell *_prototypeCell;
}
@end

@implementation FirstTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UINib *cellNib = [UINib nibWithNibName:@"FirstTableCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"firstTableCell"];
    self.tableView.tableFooterView = [UIView new];
    
    _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"firstTableCell"];
    
    _labelArray = [NSMutableArray array];
    NSString *string = [NSString new];
    for (int i = 0; i < 20; ++i) {
        string = [string stringByAppendingString:@"auto layout - thomas chelsea "];
        [_labelArray addObject:string];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _labelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstTableCell" forIndexPath:indexPath];
    
    // Configure the cell...
//        cell.name.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.name.text = _labelArray[indexPath.row];
    
    
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row%6]];
    if (image.size.width > 80) {
        image = [image resizeToSize:CGSizeMake(80, image.size.height*(80/image.size.width))];
    }
    cell.avatar.image = image;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstTableCell *cell = _prototypeCell;
    cell.name.text = _labelArray[indexPath.row];
    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height+1;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
