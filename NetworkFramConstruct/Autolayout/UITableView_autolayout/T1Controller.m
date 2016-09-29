//
//  T1Controller.m
//  
//
//  Created by 范兴政 on 16/9/26.
//
//

#import "T1Controller.h"
#import "Cell_1.h"

@interface T1Controller ()
{
    @private
    NSArray * _tableData;
    
    Cell_1 * _prototypeCell;
}
@end

@implementation T1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"Cell_1" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"Cell_1"];
    self.tableView.tableFooterView = [UIView new];
    
    _tableData = @[@"1\n2\n3\n4\n5\n6",
                   @"123456789012345678901234567890",
                   @"1\n2",
                   @"1\n2\n3",
                   @"1"];
    
    _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell_1"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell_1 * cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell_1" forIndexPath:indexPath];
    cell.text.text = [_tableData objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell_1 * cell = _prototypeCell;
    cell.text.text = [_tableData objectAtIndex:indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"height = %f",size.height + 1);
    
    return 1 + size.height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
