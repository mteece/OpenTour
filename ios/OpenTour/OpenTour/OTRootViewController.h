//
//  OTRootViewController.h
//  OpenTour
//
//  Created by Matthew Teece on 6/6/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OTRootViewController : UIViewController <UIScrollViewDelegate>
{
    int baseHeight;
}

@property (assign) int baseHeight;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnAroundMe;
@property (weak, nonatomic) IBOutlet UIButton *btnMyTours;
@property (weak, nonatomic) IBOutlet UIButton *btnTellMeAboutThis;

@end
