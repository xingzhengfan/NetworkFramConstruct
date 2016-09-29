//
//  T2Controller.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/9/26.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "T2Controller.h"
#import "Cell_2.h"

@interface T2Controller ()
{
    @private
    NSArray * _tableData;
    
    Cell_2 * _prototypeCell;
}
@end

@implementation T2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UINib *cellNib = [UINib nibWithNibName:@"Cell_2" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"Cell_2"];
    self.tableView.tableFooterView = [UIView new];
    
    _tableData = @[@"1\n2\n3\n4\n5\n6",
                   @"123456789012345678901234567890",
                   @"1\n2",
                   @"1\n2\n3",
                   @"1"];
    _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell_2"];
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


//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    Cell_2 * cell = _prototypeCell;
//    cell.text.text = [_tableData objectAtIndex:indexPath.row];
//    
//    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    CGSize textViewSize = [cell.text sizeThatFits:CGSizeMake(cell.text.frame.size.width, FLT_MAX)];
//    CGFloat height = size.height + textViewSize.height;
//    
//    height = height > 89 ? height : 89;
//    
//    NSLog(@"height = %f", height + 1);
//    return 1 + height;
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell_2 * cell = _prototypeCell;
    cell.text.text = [_tableData objectAtIndex:indexPath.row];
    
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGSize textViewSize = [cell.text sizeThatFits:CGSizeMake(cell.text.frame.size.width, FLT_MAX)];
    CGFloat height = size.height + textViewSize.height;
    
    height = height > 85 ? height : 85;
    
    NSLog(@"height = %f", height + 1);
    return 1 + height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell_2" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.text.text = [_tableData objectAtIndex:indexPath.row];
    
    return cell;
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
