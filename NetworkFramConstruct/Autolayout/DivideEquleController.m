//
//  DivideEquleController.m
//  NetworkFramConstruct
//
//  Created by 范兴政 on 16/9/12.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "DivideEquleController.h"

@interface DivideEquleController ()
{
@private
    float _middleViewOriginY;
    float _middleViewTopSpaceLayoutConstant;
    
    float _mainViewOriginY;
    float _mainViewTopSpaceLayoutConstant;
    
    float _hiddenTopViewDefaultPosition;
    float _smallViewOriginX;
    BOOL _hiddenViewHasEnlarged;
}
@end

@implementation DivideEquleController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [_panGesture addTarget:self action:@selector(p_didPan:)];
    
    _mainViewOriginY = self.mainView.frame.origin.y;
    _mainViewTopSpaceLayoutConstant = _topLayoutConstraintOfMainView.constant;
    
    _hiddenTopViewDefaultPosition = -(_hiddenTopView.frame.size.height/2);
    _topLayoutConstraintOfHiddenTopView.constant = _hiddenTopViewDefaultPosition;
    
    _rightDistanceOfSmallView.constant = 60;
    
    _hiddenViewHasEnlarged = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
- (void)p_didPan:(UIPanGestureRecognizer *)recongnizer {
    if (recongnizer.state == UIGestureRecognizerStateEnded) {
        
        _hiddenViewHasEnlarged = NO;
        
        [UIView animateWithDuration:0.4f animations:^{
            CGRect frame = self.mainView.frame;
            frame.origin.y = _mainViewOriginY;
            self.mainView.frame = frame;
            
            frame = self.smallView.frame;
            frame.origin.x = _smallViewOriginX;
            self.smallView.frame = frame;
            
            self.hiddenView.transform = CGAffineTransformMakeScale(1, 1);
            
        } completion:^(BOOL finished) {
            if (finished) {
                self.topLayoutConstraintOfMainView.constant = _mainViewTopSpaceLayoutConstant;
                
                // change animated view's constraints to make tem stable
                self.topLayoutConstraintOfHiddenTopView.constant = _hiddenTopViewDefaultPosition;
                self.rightDistanceOfSmallView.constant = 60;
            }
        }];
    }
    
    float y = [recongnizer translationInView:self.view].y;
    
    _topLayoutConstraintOfMainView.constant = _mainViewTopSpaceLayoutConstant + y;
    
    float smallViewDistance = 60 - y * 0.5;
    if (smallViewDistance > -48) {
        _rightDistanceOfSmallView.constant = smallViewDistance;
    } else {
        _rightDistanceOfSmallView.constant = -sqrt(-smallViewDistance - 47) - 47;
    }
    
    float distance = 0.3 * y + _hiddenTopViewDefaultPosition;
    if (distance < 1) {
        _topLayoutConstraintOfHiddenTopView.constant = distance;
    } else {
        _topLayoutConstraintOfHiddenTopView.constant = sqrt(distance);
    }
    
    if (_mainViewTopSpaceLayoutConstant + y > _hiddenTopView.frame.size.height * 1.2) {
        if (_hiddenViewHasEnlarged) {
            [self p_enlargeHiddenCloud];
            _hiddenViewHasEnlarged = NO;
        }
    }
}
- (void)p_bigCloudMakeRolling {
    
    _leftDistanceOfBigView.constant -= 30;
    [UIView animateWithDuration:0.8f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.bigView layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            _leftDistanceOfBigView.constant += 30;
            [UIView animateWithDuration:0.8f delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                [self.bigView layoutIfNeeded];
            } completion:^(BOOL finished) {
                if (finished) {
                    [self p_bigCloudMakeRolling];
                }
            }];
        }
    }];
}
- (void)p_enlargeHiddenCloud {
    [UIView animateWithDuration:0.5f delay:0.2f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.hiddenView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
    } completion:^(BOOL finished) {
        if (finished) {
            return ;
        }
    }];
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
