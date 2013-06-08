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
    CLLocationCoordinate2D positionB = CLLocationCoordinate2DMake(43.075436, -70.750951);
    CLLocationCoordinate2D positionC = CLLocationCoordinate2DMake(43.077759, -70.753649);
    
    GMSMarker *markerA = [GMSMarker markerWithPosition:positionA];
    GMSMarker *markerB = [GMSMarker markerWithPosition:positionB];
    GMSMarker *markerC = [GMSMarker markerWithPosition:positionC];
    
    markerA.title = @"Marcy Street";
    markerA.snippet = @"Nice Neighborhood.";
    markerA.animated = YES;
    markerA.infoWindowAnchor = CGPointMake(0.5, 0.5);
    markerA.map = mapView_;
    
    markerB.map = mapView_;
    markerC.map = mapView_;
    
    [waypoints_ addObject:markerA];
    [waypoints_ addObject:markerB];
    [waypoints_ addObject:markerC];
    
    NSString *positionStringA = [[NSString alloc] initWithFormat:@"%f,%f",
                                 43.072971, -70.750420];
    NSString *positionStringB = [[NSString alloc] initWithFormat:@"%f,%f",
                                 43.075436, -70.750951];
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
}

@end
