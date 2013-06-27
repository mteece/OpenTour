//
//  OTAroundMeMapViewController.m
//  OpenTour
//
//  Created by Matthew Teece on 6/21/13.
//  Copyright (c) 2013 Matthew Teece. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>

#import "OTTourRepository.h"

#import "OTAroundMeMapViewController.h"

@interface OTAroundMeMapViewController ()

@end

@implementation OTAroundMeMapViewController
{
    GMSMapView *mapView_;
    NSMutableArray *waypoints_;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    waypoints_ = [[NSMutableArray alloc] init];
    
    // TODO: Camera Position is deterined by where the user is.
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -70.749856 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:43.071482
                                                            longitude:-70.749856
                                                                 zoom:5];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    mapView_.settings.tiltGestures = YES;
    self.view = mapView_;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Once we have points discover location.
    
    OTTourRepository *tr = [[OTTourRepository alloc] init];
    SEL selector = @selector(addTours:);
    NSDictionary *tmp = [[NSDictionary alloc] init]; // TODO: not needed yet.
    
    [tr setTourQuery:tmp
        withSelector:selector
        withDelegate:self];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [mapView_ clear];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [waypoints_ removeAllObjects];
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

- (void)addTours:(NSDictionary *)json
{
    waypoints_ = [json valueForKey:@"waypoints"];
    
    if ([waypoints_ count] > 0) {
        for (GMSMarker *m in waypoints_) {
             m.map = mapView_;
        }
    }
    
    [self startDiscoveryOfLocation];
}

- (void)startDiscoveryOfLocation
{
    locationManager_ = [[CLLocationManager alloc] init];
    [locationManager_ setDelegate:self];
    [locationManager_ setDistanceFilter:100.0f];
    [locationManager_ setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [locationManager_ startUpdatingLocation];
}

- (void)didDiscoverLocation:(CLLocation *)location
{
    // Center the camera on CCLocation coordinate.
    GMSCameraUpdate *locationCam = [GMSCameraUpdate setTarget:[location coordinate] zoom:18];
    [mapView_ animateWithCameraUpdate:locationCam];
    
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
            [locationManager_ stopUpdatingLocation];
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
