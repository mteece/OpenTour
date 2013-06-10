//
//  OTDirectionRepository.h
//  OpenTour
//
//  Created by Matthew Teece on 6/7/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTDirectionRepository : NSObject

- (void)setDirectionsQuery:(NSDictionary *)object withSelector:(SEL)selector withDelegate:(id)delegate;
- (void)retrieveDirections:(SEL)sel withDelegate:(id)delegate;
- (void)fetchedData:(NSDictionary *)data withSelector:(SEL)selector withDelegate:(id)delegate;

@end
