//
//  NSDictionary+QueryStringBuilder.h
//  ConcernedCitizen
//
//  Created by Matthew Teece on 5/31/13.
//  Copyright (c) 2013 Ed Atwell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (QueryStringBuilder)

- (NSString *)queryString;
- (NSString *)queryParams;

@end
