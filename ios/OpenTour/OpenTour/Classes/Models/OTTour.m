//
//  OTTour.m
//  OpenTour
//
//  Created by Matthew Teece on 6/16/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import "OTTour.h"

@implementation OTTour

#define kPropWapoints @"waypoints"

#pragma mark -
#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder
{
    //[encoder encodeObject:[self prop] forKey:prop_name];
    [encoder encodeObject:[self waypoints] forKey:kPropWapoints];
}

- (id)initWithCoder:(NSCoder *)decoder
{
     if ((self = [super init])) {
         //NSString *prop = [decoder decodeObjectForKey:propname];
         //[self setProp:prop];
         
         NSMutableArray *propWaypoints = [decoder decodeObjectForKey:kPropWapoints];
         
         [self setWaypoints:propWaypoints];

     }
    return self;
}
@end
