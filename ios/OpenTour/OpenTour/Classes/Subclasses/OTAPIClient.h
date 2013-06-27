//
//  OTAPIClient.h
//  OpenTour
//
//  Created by Matthew Teece on 6/27/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import <AFNetworking.h>

@interface OTAPIClient : AFHTTPClient
+(OTAPIClient *)sharedClient;
@end
