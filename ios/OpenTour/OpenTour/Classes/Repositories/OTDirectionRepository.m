//
//  OTDirectionRepository.m
//  OpenTour
//
//  Created by Matthew Teece on 6/7/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import "OTDirectionRepository.h"

#import <AFNetworking.h>

@implementation OTDirectionRepository
{
    @private
        BOOL _sensor;
        BOOL _alternatives;
        NSURL *_directionsURL;
        NSArray *_waypoints;
}

static NSString *kMDDirectionsURL = @"https://maps.googleapis.com/maps/api/directions/json?";

- (void)setDirectionsQuery:(NSDictionary *)query withSelector:(SEL)selector withDelegate:(id)delegate
{
    NSArray *waypoints = [query objectForKey:@"waypoints"];
    NSString *origin = [waypoints objectAtIndex:0];
    int waypointCount = [waypoints count];
    int destinationPos = waypointCount -1;
    NSString *destination = [waypoints objectAtIndex:destinationPos];
    NSString *sensor = [query objectForKey:@"sensor"];
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@&origin=%@&destination=%@&sensor=%@&mode=walking", kMDDirectionsURL,origin,destination, sensor];
    if(waypointCount>2) {
        [url appendString:@"&waypoints=optimize:true|"];
        int end = destinationPos;
        for(int i=0;i <waypointCount; i++){
            if (i > 0 && i <= waypointCount) {
                [url appendString: @"|"];
            }
            [url appendString:[waypoints objectAtIndex:i]];
        }
    }
    NSString *urlWithParams = [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    _directionsURL = [NSURL URLWithString:urlWithParams];
    [self retrieveDirections:selector withDelegate:delegate];
}

- (void)retrieveDirections:(SEL)selector withDelegate:(id)delegate{
    /*dispatch_async(dispatch_get_main_queue(), ^{
        NSData* data =
        [NSData dataWithContentsOfURL:_directionsURL];
        [self fetchedData:data withSelector:selector withDelegate:delegate];
    });*/
    
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_directionsURL];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id json) {
        NSLog(@"%@", json);
        //NSError* error;
        //NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
        
        [self fetchedData:json withSelector:selector withDelegate:delegate];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
    }];
    [operation start];
    
}

- (void)fetchedData:(NSDictionary *)data withSelector:(SEL)selector withDelegate:(id)delegate
{    
    [delegate performSelector:selector withObject:data];
}
@end
