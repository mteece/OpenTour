//
//  OTContainerViewController.m
//  OpenTour
//
//  Created by Matthew Teece on 6/21/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import "OTContainerViewController.h"

@interface OTContainerViewController ()
{
    @private
        NSArray *_subViewControllers;
        UIView *_containerView;
}
@end

@implementation OTContainerViewController

@synthesize selectedViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadView
{
    // set up the base view
	CGRect frame = [[UIScreen mainScreen] applicationFrame];
	UIView *view = [[UIView alloc] initWithFrame:frame];
	view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	view.backgroundColor = [UIColor blueColor];
    
	// set up content view a bit inset
	frame = CGRectInset(view.bounds, 0, 0);
	_containerView = [[UIView alloc] initWithFrame:frame];
	_containerView.backgroundColor = [UIColor redColor];
	_containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[view addSubview:_containerView];
    
	// from here on the container is automatically adjusting to the orientation
	self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
	// adjust the frame to fit in the container view
	selectedViewController.view.frame = _containerView.bounds;
    
	// make sure that it resizes on rotation automatically
	selectedViewController.view.autoresizingMask = _containerView.autoresizingMask;
    
	// add as child VC
	[self addChildViewController:selectedViewController];
    
	// add it to container view, calls willMoveToParentViewController for us
	[_containerView addSubview:selectedViewController.view];
    
	// notify it that move is done
	[selectedViewController didMoveToParentViewController:self];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.title = selectedViewController.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setSubViewControllers:nil];
    [super viewDidUnload];
}

- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
	if (fromViewController == toViewController)
	{
		// cannot transition to same
		return;
	}
    
	// animation setup
	toViewController.view.frame = _containerView.bounds;
	toViewController.view.autoresizingMask = _containerView.autoresizingMask;
    
	// notify
	[fromViewController willMoveToParentViewController:nil];
	[self addChildViewController:toViewController];
    
    // set the selected controller
    selectedViewController = toViewController;
    
	// transition
	[self transitionFromViewController:fromViewController
					  toViewController:toViewController
							  duration:1.0
							   options:UIViewAnimationOptionTransitionCurlDown
							animations:^{
							}
							completion:^(BOOL finished) {
								[toViewController didMoveToParentViewController:self];
								[fromViewController removeFromParentViewController];
							}];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return NO;
}

- (void)setSubViewControllers:(NSArray *)subViewControllers
{
	_subViewControllers = [subViewControllers copy];
    
	if (selectedViewController)
	{
		// TODO: remove previous VC
	}
    
	selectedViewController = [subViewControllers objectAtIndex:0];
}
@end
