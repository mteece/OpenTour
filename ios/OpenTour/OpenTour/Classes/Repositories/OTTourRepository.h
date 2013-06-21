//
//  OTTourRepository.h
//  OpenTour
//
//  Created by Matthew Teece on 6/21/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OTTourRepository : NSObject

- (void)setTourQuery:(NSDictionary *)object withSelector:(SEL)selector withDelegate:(id)delegate;
- (void)retrieveTours:(SEL)sel withDelegate:(id)delegate;
- (void)fetchedData:(NSDictionary *)data withSelector:(SEL)selector withDelegate:(id)delegate;

@end
