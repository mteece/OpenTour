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
    
    OTMapViewController *nextViewController = [[OTMapViewController alloc] init];
    
    // Set the next views navigation items.
    nextViewController.navigationItem.hidesBackButton = YES;
    
    [[self navigationController] pushViewController:nextViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
