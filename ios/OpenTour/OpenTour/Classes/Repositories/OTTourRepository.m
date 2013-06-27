//
//  OTTourRepository.m
//  OpenTour
//
//  Created by Matthew Teece on 6/21/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h> // TODO: Temporary for data.

#import "OTAPIClient.h"

#import "OTTourRepository.h"

@implementation OTTourRepository
{
    @private
}

static NSString *kURLToursAPI = @"http://";

- (void)setTourQuery:(NSDictionary *)query withSelector:(SEL)selector withDelegate:(id)delegate
{
    
    // TODO: Implementation
     [self retrieveTours:selector withDelegate:delegate];
    
}

- (void)retrieveTours:(SEL)selector withDelegate:(id)delegate
{
    NSMutableArray *waypoints = [[NSMutableArray alloc] init];
    
    //TODO: This merely populates the waypoints in the array.
    CLLocationCoordinate2D positionA = CLLocationCoordinate2DMake(43.072971, -70.750420);
    CLLocationCoordinate2D positionB = CLLocationCoordinate2DMake(43.075118, -70.753865);
    CLLocationCoordinate2D positionC = CLLocationCoordinate2DMake(43.077759, -70.753649);
    
    GMSMarker *markerA = [GMSMarker markerWithPosition:positionA];
    GMSMarker *markerB = [GMSMarker markerWithPosition:positionB];
    GMSMarker *markerC = [GMSMarker markerWithPosition:positionC];
    
    markerA.title = @"S Mill Street";
    markerA.snippet = @"Nice new house.";
    markerA.animated = YES;
    markerA.infoWindowAnchor = CGPointMake(0.5, 0.5);
    
    markerB.title = @"Liberty Gardens";
    markerB.snippet = @"Nice Flowers.";
    markerB.animated = YES;
    markerB.infoWindowAnchor = CGPointMake(0.5, 0.5);
    
    markerC.title = @"Memorial Bridge";
    markerC.snippet = @"Bridge Construction.";
    markerC.animated = YES;
    markerC.infoWindowAnchor = CGPointMake(0.5, 0.5);
    
    [waypoints addObject:markerA];
    [waypoints addObject:markerB];
    [waypoints addObject:markerC];
    
    NSArray *parameters = [NSArray arrayWithObjects:waypoints, nil];
    NSArray *keys = [NSArray arrayWithObjects:@"waypoints", nil];
    NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters forKeys:keys];
    
    [self fetchedData:query withSelector:selector withDelegate:delegate];
    
    // TODO: Logic for API request.
    /*
    OTAPIClient *client = [OTAPIClient sharedClient];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
    
    NSString *path = [NSString stringWithFormat:@"myapipath/?value=%@", value];
    NSURLRequest *request = [client requestWithMethod:@"POST" path:path parameters:nil];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        // code for successful return goes here
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        
        // do something with return data
        [self fetchedData:json withSelector:selector withDelegate:delegate];
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // code for failed request goes here
        [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
        
        // do something on failure
    }];
    
    [operation start];
    */
}

- (void)fetchedData:(NSDictionary *)data withSelector:(SEL)selector withDelegate:(id)delegate
{
    /*SuppressPerformSelectorLeakWarning(
                                       [delegate performSelector:selector withObject:data];
                                       );
     */
    [delegate performSelector:selector withObject:data afterDelay:0.0];
}
@end
