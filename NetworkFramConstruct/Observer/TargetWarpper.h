//
//  TargetWarpper.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/4/19.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Target;
@interface TargetWarpper : NSObject
{
@private
    Target *_target;
}

@property (nonatomic, strong) Target *target;
@property (nonatomic, copy) NSString *information;

- (id)initWithTarget:(Target *)target;
@end
