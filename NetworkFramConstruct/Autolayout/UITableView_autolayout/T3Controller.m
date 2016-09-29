//
//  T3Controller.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/9/26.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "T3Controller.h"
#import "Cell_3.h"
#import "NSString+CalculateSize.h"

@interface T3Controller ()
{
    @private
    NSArray * _tableData;
    
    Cell_3 * _prototypeCell;
}
@end

@implementation T3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UINib * cellNib = [UINib nibWithNibName:@"Cell_3" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"Cell_3"];
    self.tableView.tableFooterView = [UIView new];
    
    _tableData = @[@"1\n2\n3\n4\n5\n6",
                   @"123456789012345678901234567890",
                   @"1\n2",
                   @"1\n2\n3",
                   @"1"];
    _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell_3"];
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
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell_3 * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_3" forIndexPath:indexPath];
    
    // Configure the cell...
    NSString * str = [_tableData objectAtIndex:indexPath.row];
    cell.text.text = str;
    CGSize size = [str calculateSize:CGSizeMake(cell.text.frame.size.width, FLT_MAX) font:cell.text.font];
    
    CGRect frame = cell.text.frame;
    frame.size.height = size.height;
    cell.text.frame = frame;
//    [cell.text sizeToFit];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell_3 * cell = _prototypeCell;
    NSString * str = [_tableData objectAtIndex:indexPath.row];
    cell.text.text = str;
    CGSize size = [str calculateSize:CGSizeMake(cell.text.frame.size.width, FLT_MAX) font:cell.text.font];
    CGFloat defaultHeight = cell.contentView.frame.size.height;
    CGFloat height = size.height > defaultHeight ? size.height : defaultHeight;
    
    NSLog(@"height = %f",height);
    return 1 + height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
