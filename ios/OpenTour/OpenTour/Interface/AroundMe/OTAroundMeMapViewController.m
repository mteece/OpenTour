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
    
    // Once we have points discover location.
    [self startDiscoveryOfLocation];
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

- (void)startDiscoveryOfLocation
{
    locationManager_ = [[CLLocationManager alloc] init];
    [locationManager_ setDelegate:self];
    [locationManager_ setDistanceFilter:kCLDistanceFilterNone];
    [locationManager_ setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager_ startUpdatingLocation];
}

- (void)didDiscoverLocation:(CLLocation *)location
{
    // Zoom in one zoom level
    /*GMSCameraUpdate *zoomCamera = [GMSCameraUpdate zoomTo:16];
    [mapView_ animateWithCameraUpdate:zoomCamera];
    
    // Center the camera on CCLocation coordinate.
    GMSCameraUpdate *locationCam = [GMSCameraUpdate setTarget:[location coordinate]];
    [mapView_ animateWithCameraUpdate:locationCam];
    */
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
