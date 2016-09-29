//
//  NSString+CalculateSize.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/9/26.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

@interface NSString (CalculateSize)

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;
@end
