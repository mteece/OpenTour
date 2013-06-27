//
//  OTContainerViewController.h
//  OpenTour
//
//  Created by Matthew Teece on 6/21/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTContainerViewController : UIViewController
{
    UIViewController *selectedViewController;
}

@property (nonatomic, copy) NSArray *subViewControllers;
@property (nonatomic, retain) UIViewController *selectedViewController;

- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;
- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController withAnimation:(UIViewAnimationOptions)withAnimation;
@end
