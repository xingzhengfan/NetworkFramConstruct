//
//  MsgPackTestController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/5/20.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "MsgPackTestController.h"

#import <MPMessagePack/MPMessagePack.h>
#import "GHODictionary.h"

@implementation MsgPackTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    testMsgpack();
}

#pragma mark - 
void
testMsgpack() {
    NSDictionary *dict = @{@"n":@(32134321),
                           @"bool":@(YES),
                           @"array":@[@(2.2f),@(2.1)],
                           @"body":[NSData data]};
    NSData *data1 = [dict mp_messagePack];
    
    NSError *error = nil;
    NSData *data2 = [MPMessagePackWriter writeObject:dict error:&error];
    
    error = nil;
    id obj1 = [MPMessagePackReader readData:data1 error:&error];
    
    error = nil;
    MPMessagePackReader *reader = [[MPMessagePackReader alloc] initWithData:data2];
    id obj2 = [reader readObject:&error];
    
    GHODictionary *orderedDict = [[GHODictionary alloc] init];
    [orderedDict addEntriesFromDictionary:@{@"c":@(3),
                                            @"b":@(2),
                                            @"a":@(1)}];
    [orderedDict sortKeysUsingSelector:@selector(localizedCaseInsensitiveCompare:) deepSort:YES];
    
    error = nil;
}
@end
