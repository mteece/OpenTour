//
//  OTRootViewController.m
//  OpenTour
//
//  Created by Matthew Teece on 6/6/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//
#import "OTMapViewController.h"
#import "OTAroundMeContainerViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "OTRootViewController.h"

@interface OTRootViewController ()

@end

@implementation OTRootViewController

@synthesize baseHeight;
@synthesize scrollView;
@synthesize lblTitle;
@synthesize btnAroundMe, btnMyTours, btnTellMeAboutThis;

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
    //[scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height - kHeightNavigationBar)];
    
    
    
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
    
    [btnMyTours setFrame:CGRectMake(btnMyTours.frame.origin.x, btnMyTours.frame.origin.y, 143.0f, 43.0f)];
    /*[btnAroundMe setTitleColor:[ELAAppDelegate appTextColorShinyButtonDisabled] forState:UIControlStateDisabled];
     [btnAroundMe setTitleColor:[ELAAppDelegate appTextColorShinyButtonNormal] forState:UIControlStateNormal];
     [btnAroundMe setTitleColor:[ELAAppDelegate appTextColorShinyButtonHighlighted] forState:UIControlStateHighlighted];*/
    [btnMyTours.titleLabel setFont:[OTThemeManager appButtonFontStandard]];
    [btnMyTours.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    [btnMyTours.titleLabel setShadowColor:[UIColor darkGrayColor]];
    [btnMyTours addTarget:self action:@selector(doMyTours:) forControlEvents:UIControlEventTouchUpInside];
    
    [btnTellMeAboutThis setFrame:CGRectMake(btnTellMeAboutThis.frame.origin.x, btnTellMeAboutThis.frame.origin.y, 143.0f, 43.0f)];
    /*[btnAroundMe setTitleColor:[ELAAppDelegate appTextColorShinyButtonDisabled] forState:UIControlStateDisabled];
     [btnAroundMe setTitleColor:[ELAAppDelegate appTextColorShinyButtonNormal] forState:UIControlStateNormal];
     [btnAroundMe setTitleColor:[ELAAppDelegate appTextColorShinyButtonHighlighted] forState:UIControlStateHighlighted];*/
    [btnTellMeAboutThis.titleLabel setFont:[OTThemeManager appButtonFontStandard]];
    [btnTellMeAboutThis.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    [btnTellMeAboutThis.titleLabel setShadowColor:[UIColor darkGrayColor]];
    [btnTellMeAboutThis addTarget:self action:@selector(doTellMeAboutThis:) forControlEvents:UIControlEventTouchUpInside];
    
    //OTMapViewController *nextViewController = [[OTMapViewController alloc] init];
    // Set the next views navigation items.
    //nextViewController.navigationItem.hidesBackButton = YES;
    //[[self navigationController] pushViewController:nextViewController animated:YES];
    
    /*[btnAroundMe setHidden:YES];
    [btnMyTours setHidden:YES];
    [btnTellMeAboutThis setHidden:YES];*/
    
    [self setContentSize];
    
    //[self drawButtons];
    
    [self localizeView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self localizeView];
}

- (void)viewDidAppear:(BOOL)animated
{
    
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
    [self setBtnMyTours:nil];
    [self setBtnTellMeAboutThis:nil];
    [super viewDidUnload];
}

#pragma mark -
#pragma mark Class Methods

- (void)setContentSize
{
    CGRect frame = CGRectZero;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    baseHeight = screenBounds.size.height;
    if (screenBounds.size.height == 568) {
        // code for 4-inch screen
        baseHeight = 568;
        frame = CGRectMake(scrollView.frame.origin.x,
                           0,
                           scrollView.frame.size.width,
                           baseHeight
                           );
    } else {
        // code for 3.5-inch screen
        frame = CGRectMake(scrollView.frame.origin.x,
                           0,
                           scrollView.frame.size.width,
                           baseHeight
                           );
    }
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    scrollView.frame = frame;
}

- (void)localizeView
{
    [self setTitle:NSLocalizedString(@"ROOT_VIEW_TITLE", nil)];
    [lblTitle setText:NSLocalizedString(@"ROOT_VIEW_TITLE", nil) ];
    [btnAroundMe setTitle:NSLocalizedString(@"ROOT_VIEW_BUTTON_AROUND_ME_PROMPT", nil) forState:UIControlStateNormal];
    [btnMyTours setTitle:NSLocalizedString(@"ROOT_VIEW_BUTTON_MY_TOURS_PROMPT", nil) forState:UIControlStateNormal];
    [btnTellMeAboutThis setTitle:NSLocalizedString(@"ROOT_VIEW_BUTTON_TELL_ME_ABOUT_THIS_PROMPT", nil) forState:UIControlStateNormal];
}

#pragma mark Class Selectors
- (void)doAroundMe:(id)sender
{
    OTAroundMeContainerViewController *vc = [[OTAroundMeContainerViewController alloc] init];
    // Set the next views navigation items.
    vc.navigationItem.hidesBackButton = NO;
    [[self navigationController] pushViewController:vc animated:YES];
}

- (void)doMyTours:(id)sender
{
}

- (void)doTellMeAboutThis:(id)sender
{
}

- (void)buttonDidTouchUpInside:(id)sender
{
    NSLog(@"%ld", (long)[sender tag]);
}

- (void)drawButtons
{
    int pos = 0;
    int nCols = 2; // cols
    int nRows = 2; // rows
    
    int h = scrollView.frame.size.height - kHeightNavigationBar;
    int w = scrollView.frame.size.width;
    
    CGPoint pt = CGPointMake(0, 0);
    
    for(int row = 0; row < nRows; row++) {
        // 0,1,2 rows
        
        for(int col = 0; col < nCols; col++) {
            // 0,1,2,3 cols
            // NSLog(@"%d", row % nRows);
            
            pt.x = w/nCols * (col %nCols);
            pt.y = h/nRows * (row % nRows);
            
            NSLog(@"%f, %f", pt.x, pt.y);
            
            CGRect box = CGRectMake(pt.x,
                                    pt.y,
                                    w/nCols,
                                    h/nRows);
            
            // add button with frame;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:box];
            [btn setTitle:[NSString stringWithFormat:@"%d", pos] forState:UIControlStateNormal];
            [btn setTag:pos];
            [btn.titleLabel setFont:[OTThemeManager appButtonFontStandard]];
            [btn.titleLabel setShadowOffset:CGSizeMake(0, -1)];
            [btn.titleLabel setShadowColor:[UIColor darkGrayColor]];
            [btn setTintColor:[UIColor darkGrayColor]];
            [btn addTarget:self action:@selector(buttonDidTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];

            
            CALayer * layer = [btn layer];
            [layer setMasksToBounds:YES];
            [layer setCornerRadius:0.0]; //when radius is 0, the border is a rectangle
            [layer setBorderWidth:2.0];
            [layer setBorderColor:[[UIColor grayColor] CGColor]];
            
            
            [btn setReversesTitleShadowWhenHighlighted:YES];
            
            [[self view] addSubview:btn];
            
            pos++;
        }
        
    }

}

@end
