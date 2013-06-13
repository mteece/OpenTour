//
//  OTMapViewController.m
//  OpenTour
//
//  Created by Matthew Teece on 6/7/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//
#import <GoogleMaps/GoogleMaps.h>
#import "OTDirectionRepository.h"

#import "OTMapViewController.h"

@interface OTMapViewController ()

@end

@implementation OTMapViewController
{
    GMSMapView *mapView_;
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
    CLLocationManager *locationManager_;
    CLLocation *bestEffortAtLocation_;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    waypoints_ = [[NSMutableArray alloc] init];
    waypointStrings_ = [[NSMutableArray alloc]init];
    
    // TODO: Camera Position is deterined by where the user is.
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -70.749856 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:43.071482
                                                            longitude:-70.749856
                                                                 zoom:12];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.settings.tiltGestures = YES;
    self.view = mapView_;
    
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
    markerA.map = mapView_;
    
    markerB.title = @"Liberty Gardens";
    markerB.snippet = @"Nice Flowers.";
    markerB.animated = YES;
    markerB.infoWindowAnchor = CGPointMake(0.5, 0.5);
    markerB.map = mapView_;
    
    markerC.title = @"Memorial Bridge";
    markerC.snippet = @"Bridge Construction.";
    markerC.animated = YES;
    markerC.infoWindowAnchor = CGPointMake(0.5, 0.5);
    markerC.map = mapView_;
    
    [waypoints_ addObject:markerA];
    [waypoints_ addObject:markerB];
    [waypoints_ addObject:markerC];
    
    NSString *positionStringA = [[NSString alloc] initWithFormat:@"%f,%f",
                                 43.072971, -70.750420];
    NSString *positionStringB = [[NSString alloc] initWithFormat:@"%f,%f",
                                 43.075118, -70.753865];
    NSString *positionStringC = [[NSString alloc] initWithFormat:@"%f,%f",
                                 43.077759, -70.753649];
    
    [waypointStrings_ addObject:positionStringA];
    [waypointStrings_ addObject:positionStringB];
    [waypointStrings_ addObject:positionStringC];
    
    // Plot the course.
    [self plotWaypoints];
    
    // Creates a marker in the center of the map.
    /*
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
     */
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [locationManager_ setDelegate:nil];
}

#pragma mark -
#pragma mark Class Methods

- (void)plotWaypoints
{
    if([waypoints_ count]>1){
        NSString *sensor = @"false";
        NSArray *parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,
                               nil];
        NSArray *keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];
        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                          forKeys:keys];
        OTDirectionRepository *dr = [[OTDirectionRepository alloc] init];
        SEL selector = @selector(addDirections:);
        [dr setDirectionsQuery:query
                   withSelector:selector
                   withDelegate:self];
    }
}

- (void)addDirections:(NSDictionary *)json
{
    
    NSDictionary *routes = [json objectForKey:@"routes"][0];
    
    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
    NSString *overview_route = [route objectForKey:@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeWidth = 5.0f;
    polyline.strokeColor = [UIColor blueColor];
    polyline.geodesic = YES;
    polyline.map = mapView_;
    
    // Once we have points discover location.
    [self startDiscoveryOfLocation];
}

- (void)startDiscoveryOfLocation
{
    locationManager_ = [[CLLocationManager alloc] init];
    [locationManager_ setDelegate:self];
    [locationManager_ setDistanceFilter:kCLDistanceFilterNone];
    [locationManager_ setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [locationManager_ startUpdatingLocation];
}

- (void)didDiscoverLocation:(CLLocation *)location
{
    // Zoom in one zoom level
    GMSCameraUpdate *zoomCamera = [GMSCameraUpdate zoomTo:16];
    [mapView_ animateWithCameraUpdate:zoomCamera];
    
    // Center the camera on CCLocation coordinate.
    GMSCameraUpdate *locationCam = [GMSCameraUpdate setTarget:[location coordinate]];
    [mapView_ animateWithCameraUpdate:locationCam];
    
    // Move the camera 100 points down, and 200 points to the right.
    //GMSCameraUpdate *downwards = [GMSCameraUpdate scrollByX:100 Y:200];
    //[mapView_ animateWithCameraUpdate:downwards];
}

#pragma mark -
#pragma CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // Test the age of the location measurement to determine if the measurement is cached
    // in most cases you will not want to rely on cached measurements.
    NSTimeInterval locationAge = -[newLocation.timestamp timeIntervalSinceNow];
    
    if (locationAge > 5.0) return;
    
    // Test that the horizontal accuracy does not indicate an invalid measurement.
    if (newLocation.horizontalAccuracy < 0) return;
    // Test the measurement to see if it is more accurate than the previous measurement
    if (bestEffortAtLocation_ == nil || bestEffortAtLocation_.horizontalAccuracy >= newLocation.horizontalAccuracy) {
        // Store the location as the "best effort".
        bestEffortAtLocation_ = newLocation;
        // Test the measurement to see if it meets the desired accuracy.
        // IMPORTANT!!! kCLLocationAccuracyBest should not be used for comparison with location coordinate or altitidue
        // accuracy because it is a negative value. Instead, compare against some predetermined "real" measure of
        // acceptable accuracy, or depend on the timeout to stop updating. This sample depends on the timeout.
        //
        if (newLocation.horizontalAccuracy <= locationManager_.desiredAccuracy) {
            // We have a measurement that meets our requirements, so we can stop updating the location
            // IMPORTANT!!! Minimize power usage by stopping the location manager as soon as possible.
            // [locationManager_ stopUpdatingLocation];
        }
    }
    
    // Update the display with the new location data.
    [self didDiscoverLocation:bestEffortAtLocation_];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}


@end
