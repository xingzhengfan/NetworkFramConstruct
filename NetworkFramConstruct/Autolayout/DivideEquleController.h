//
//  DivideEquleController.h
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/9/12.
//  Copyright © 2016年 PT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DivideEquleController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property (strong, nonatomic) IBOutlet UIView *middleView;
@property (strong, nonatomic) IBOutlet UIView *view0;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIView *view2;

@property (strong, nonatomic) IBOutlet UIView *hiddenTopView;

@property (strong, nonatomic) IBOutlet UIView *hiddenView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UIView *smallView;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraintOfMainView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *middleViewTopSpaceLayout;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topLayoutConstraintOfHiddenTopView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftDistanceOfBigView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *rightDistanceOfSmallView;


@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGesture;

@end
