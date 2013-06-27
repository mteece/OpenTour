//
//  OTAPIClient.m
//  OpenTour
//
//  Created by Matthew Teece on 6/27/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//
#import <AFNetworking.h>

#import "OTAPIClient.h"

@implementation OTAPIClient

+(OTAPIClient *)sharedClient {
    static OTAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost/"]];
    });
    return _sharedClient;
}

-(id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    self.parameterEncoding = AFJSONParameterEncoding;
    
    return self;
    
}

@end
