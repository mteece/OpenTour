//
//  OTAroundMeContainerViewController.m
//  OpenTour
//
//  Created by Matthew Teece on 6/21/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import "OTAroundMeTableViewController.h"
#import "OTAroundMeMapViewController.h"

#import "OTAroundMeContainerViewController.h"

@interface OTAroundMeContainerViewController ()

@end

@implementation OTAroundMeContainerViewController

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
	// Do any additional setup after loading the view.
    
    OTAroundMeTableViewController *aroundMeTableViewController = [[OTAroundMeTableViewController alloc] initWithNibName:@"OTAroundMeTableViewController" bundle:nil];
    
    OTAroundMeMapViewController *aroundMeMapViewController = [[OTAroundMeMapViewController alloc] initWithNibName:@"OTAroundMeMapViewController" bundle:nil];
    
    NSArray *subViewControllers = [[NSArray alloc] initWithObjects:aroundMeTableViewController, aroundMeMapViewController, nil];
    
    [self setSubViewControllers:subViewControllers];
    
    UIButton *mapBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [mapBtn setFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    [mapBtn addTarget:self action:@selector(doMap:) forControlEvents:UIControlEventTouchUpInside];
    //[mapBtn setImage:[UIImage imageNamed:@"map_icon"] forState:UIControlStateNormal];
    self.mapBarBtn =  [[UIBarButtonItem alloc] initWithCustomView:mapBtn];
    
    UIButton *listBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [listBtn setFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    [listBtn addTarget:self action:@selector(doList:) forControlEvents:UIControlEventTouchUpInside];
    //[mapBtn setImage:[UIImage imageNamed:@"map_icon"] forState:UIControlStateNormal];
    self.listBarBtn =  [[UIBarButtonItem alloc] initWithCustomView:listBtn];
        
    self.navigationItem.rightBarButtonItem = self.mapBarBtn;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)doMap:(id)sender
{
    NSLog(@"Do map");
    self.navigationItem.rightBarButtonItem = self.listBarBtn;
    [self transitionFromViewController:selectedViewController toViewController:[self.subViewControllers objectAtIndex:1]];
}

- (void)doList:(id)sender
{
    NSLog(@"Do list");
    self.navigationItem.rightBarButtonItem = self.mapBarBtn;
    [self transitionFromViewController:selectedViewController toViewController:[self.subViewControllers objectAtIndex:0]];
}

@end
