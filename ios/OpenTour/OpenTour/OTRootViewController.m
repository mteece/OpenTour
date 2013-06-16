//
//  OTRootViewController.m
//  OpenTour
//
//  Created by Matthew Teece on 6/6/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//
#import "OTMapViewController.h"

#import "OTRootViewController.h"

@interface OTRootViewController ()

@end

@implementation OTRootViewController

@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [scrollView setDelegate:self];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - kHeightNavigationBar)];
    
    //OTMapViewController *nextViewController = [[OTMapViewController alloc] init];
    // Set the next views navigation items.
    //nextViewController.navigationItem.hidesBackButton = YES;
    //[[self navigationController] pushViewController:nextViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self localizeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Class Methods

- (void)localizeView
{
    self.title = NSLocalizedString(@"ROOT_VIEW_TITLE", nil);
}

@end
