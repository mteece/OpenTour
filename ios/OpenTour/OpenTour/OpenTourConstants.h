//
//  OpenTourConstants.h
//  OpenTour
//
//  Created by Matthew Teece on 6/7/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#ifndef OpenTour_OpenTourConstants_h
#define OpenTour_OpenTourConstants_h

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define kDeviceId @"device_id_setting"
#define kDeviceApiKey @"device_api_key"

#define kHeightNavigationBar 44

/* Application Fonts
 Helvetica	3.0	4.3
 Helvetica-Bold	3.0	4.3
 Helvetica-BoldOblique	3.0	4.3
 Helvetica-Light	5.0	5.0
 Helvetica-LightOblique	5.0	5.0
 Helvetica-Oblique
 */

#define kAppStandardFontName @"Helvetica"
#define kAppStandardFontBoldName @"Helvetica-Bold"
#define kAppStandardFontBoldOblique @"Helvetica-BoldOblique"
#define kAppStandardFontLight @"Helvetica-Light"
#define kAppStandardFontLightOblique @"Helvetica-LightOblique"
#define kAppStandardFontOblique @"Helvetica-Oblique"

#endif
