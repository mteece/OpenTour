//
//  OTThemeManager.m
//  OpenTour
//
//  Created by Matthew Teece on 6/19/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import "OTThemeManager.h"

#pragma mark -
#pragma mark OTThemeManager Extension

@interface OTThemeManager ()
{

}
- (void)customizeAppearance;
@end

#pragma mark -
#pragma mark OTThemeManager Implementation

@implementation OTThemeManager

-(id)init
{
    self = [super init];
    if (self) {
        [self customizeAppearance];
    }
    return self;
}


#pragma mark -
#pragma mark Application Colors

#pragma mark Default Color
+ (UIColor *) appTextColorStandard
{
    return [UIColor colorWithRed:0.31 green:0.31 blue:0.31 alpha:1.0];
}

#pragma mark -
#pragma mark Application Fonts

#pragma mark Default Text
+ (UIFont *)appTextFontStandard
{
    return [UIFont fontWithName:kAppStandardFontName size:12.0];
}

+ (UIFont *)appTextFontStandardBold
{
    return [UIFont fontWithName:kAppStandardFontBoldName size:12.0];
}

+ (UIFont *)appTextFontStandardBoldOblique
{
    return [UIFont fontWithName:kAppStandardFontBoldOblique size:12.0];
}

+ (UIFont *)appTextFontStandardLightOblique
{
    return [UIFont fontWithName:kAppStandardFontLightOblique size:14.0];
}

+ (UIFont *)appTextFontStandardOblique
{
    return [UIFont fontWithName:kAppStandardFontOblique size:14.0];
}

#pragma mark Button Text
+ (UIFont *) appButtonFontStandard
{
    return [UIFont fontWithName:kAppStandardFontName size:12.0];
}

- (void)customizeAppearance
{
    // http://developer.apple.com/library/ios/#documentation/uikit/reference/UIAppearance_Protocol/Reference/Reference.html
}

@end
