//
//  mapviewcontroller.m
//  tabtask
//
//  Created by Arpit on 03/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "mapviewcontroller.h"
#define METERS_PER_MILE 25.344
@interface mapviewcontroller ()

@end

@implementation mapviewcontroller
@synthesize mapview;
@synthesize locationManager;


- (void)viewDidLoad {
    [super viewDidLoad];
    mapview.delegate=self;
    mapview.showsUserLocation = YES;
    [self CurrentLocationIdentifier];
    //[mapview setShowsUserLocation:YES];
    
    //19.017615
    //72.856164
}
-(void)CurrentLocationIdentifier
{
    //---- For getting current gps location
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    [locationManager stopUpdatingLocation];
    
    //------
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations objectAtIndex:0];
    [locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSLog(@"\nCurrent Location Detected\n");
             NSLog(@"placemark %@",placemark);
             NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
             NSString *Address = [[NSString alloc]initWithString:locatedAt];
             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             NSString *Country = [[NSString alloc]initWithString:placemark.country];
             NSString *CountryArea = [NSString stringWithFormat:@"%@, %@", Area,Country];
             NSLog(@"%@",CountryArea);
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
             NSLog(@"\nCurrent Location Not Detected\n");
             //return;
            //= NULL;
         }
         /*---- For more results
          placemark.region);
          placemark.country);
          placemark.locality);
          placemark.name);
          placemark.ocean);
          placemark.postalCode);
          placemark.subLocality);
          placemark.location);
          ------*/
     }];
}
/*
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.lastObject;
    [[self lbllat] setText:[NSString stringWithFormat:@"%.6f",
                                   location.coordinate.latitude]];
    [[self lbllong] setText:[NSString stringWithFormat:@"%.6f",
                                    location.coordinate.longitude]];
    [[self lbllat] setText:[NSString stringWithFormat:@"%.2f feet",
                                   location.altitude*METERS_FEET]];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance
    (location.coordinate, 2*METERS_MILE, 2*METERS_MILE);
    [mapview setRegion:viewRegion animated:YES];

}
*/
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark - View lifecycle

    // zoom the map into the users current location


- (void)viewWillAppear:(BOOL)animated {
    // 1
   /* CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 23.036816;
    zoomLocation.longitude= 72.56143299999997;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5 * METERS_PER_MILE, 0.5 * METERS_PER_MILE);
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    //point.coordinate = userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [mapview addAnnotation:point];

    
    // 3
    [mapview setRegion:viewRegion animated:YES];
 */
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=23.036816;
    myCoordinate.longitude=72.56143299999997;
    annotation.coordinate = myCoordinate;
    annotation.title=@"Abbacus Technology, ";
    annotation.subtitle = @"khasi parekh Complex,Ahmedabad ";
    [mapview addAnnotation:annotation];

    }
 


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button:(id)sender {
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 23.036816;
    zoomLocation.longitude= 72.56143299999997;
    CLLocationCoordinate2D myCoordinate;
    
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5 * METERS_PER_MILE, 0.5 * METERS_PER_MILE);
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    //point.coordinate = userLocation.coordinate;
    point.coordinate = myCoordinate;
    point.title = @"Abbacus Technology";
    point.subtitle = @"khasi parekh Complex,Ahmedabad !!!";
    
    [mapview addAnnotation:point];
    /*CLLocationCoordinate2D zoomLocation;
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    //CLLocationCoordinate2D myCoordinate;
    zoomLocation.latitude = 23.036816;
    zoomLocation.longitude= 72.56143299999997;
    //annotation.coordinate = myCoordinate;
    annotation.title=@"Abbacus Technology, ";
    annotation.subtitle = @"khasi parekh Complex,Ahmedabad ";
    [mapview addAnnotation:annotation];
*/
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}




@end
