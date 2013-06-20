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
@synthesize lblTitle;
@synthesize btnAroundMe;

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
    
    [lblTitle setFont:[OTThemeManager appTextFontStandard]];
    [lblTitle setTextColor:[OTThemeManager appTextColorStandard]];
    
    
    [btnAroundMe setFrame:CGRectMake(btnAroundMe.frame.origin.x, btnAroundMe.frame.origin.y, 143.0f, 43.0f)];
    /*[btnAroundMe setTitleColor:[ELAAppDelegate appTextColorShinyButtonDisabled] forState:UIControlStateDisabled];
    [btnAroundMe setTitleColor:[ELAAppDelegate appTextColorShinyButtonNormal] forState:UIControlStateNormal];
    [btnAroundMe setTitleColor:[ELAAppDelegate appTextColorShinyButtonHighlighted] forState:UIControlStateHighlighted];*/
    [btnAroundMe.titleLabel setFont:[OTThemeManager appButtonFontStandard]];
    [btnAroundMe.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    [btnAroundMe.titleLabel setShadowColor:[UIColor darkGrayColor]];
    [btnAroundMe addTarget:self action:@selector(doAroundMe:) forControlEvents:UIControlEventTouchUpInside];

    //OTMapViewController *nextViewController = [[OTMapViewController alloc] init];
    // Set the next views navigation items.
    //nextViewController.navigationItem.hidesBackButton = YES;
    //[[self navigationController] pushViewController:nextViewController animated:YES];
    
    [self localizeView];
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

- (void)viewDidUnload
{
    [self setLblTitle:nil];
    [self setBtnAroundMe:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Class Methods

- (void)localizeView
{
    [self setTitle:NSLocalizedString(@"ROOT_VIEW_TITLE", nil)];
    [lblTitle setText:NSLocalizedString(@"ROOT_VIEW_TITLE", nil) ];
    [btnAroundMe setTitle:NSLocalizedString(@"ROOT_VIEW_BUTTON_AROUND_ME_PROMPT", nil) forState:UIControlStateNormal];
    
}

#pragma mark Class Selectors
- (void)doAroundMe:(id)sender
{
}
@end
