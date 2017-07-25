//
//  ViewController.m
//  mapcircledraw
//
//  Created by Arpit on 09/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "ViewController.h"
#import "DBHandler.h"
#import <AddressBookUI/AddressBookUI.h>
const CGFloat POLYLINE_WIDTH = 5.0;
@interface ViewController ()<CLLocationManagerDelegate>
{
CLGeocoder *geocoder;
CLPlacemark *placemark;
    DBHandler *db1;
    NSMutableArray *arr;
    NSMutableArray *arr1;
    CLLocationCoordinate2D Location;
    CLLocationCoordinate2D sourceLocation;
    CLLocationCoordinate2D destinationLocation;
    CLLocationCoordinate2D coordinate;
    float lat;
    float lon;
    NSString *tempname;
    NSString *fromLat,*fromLng;
}
@property (nonatomic, strong) NSMutableArray *coordinates;
@property (nonatomic) CLLocationDistance radius;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) MKMapRect boundingMapRect;

-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) from to: (CLLocationCoordinate2D) to;
-(void) centerMap;
@end
@implementation ViewController
@synthesize searchtext;
@synthesize Delegate;
- (id) initWithFrame:(CGRect) frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        _mapview = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _mapview.showsUserLocation = NO;
        [_mapview setDelegate:self];
        [self addSubview:_mapview];
    }
    return self;
}
- (NSMutableArray *)decodePolyLine: (NSMutableString *)encoded
{
    [encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\" options:NSLiteralSearch range:NSMakeRange(0, [encoded length])];
    NSInteger len = [encoded length];
    NSInteger index = 0;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSInteger lat=0;
    NSInteger lng=0;
    while (index < len)
    {
        NSInteger b;
        NSInteger shift = 0;
        NSInteger result = 0;
        do
        {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lat += dlat;
        shift = 0;
        result = 0;
        do
        {
            b = [encoded characterAtIndex:index++] - 63;
            result |= (b & 0x1f) << shift;
            shift += 5;
        } while (b >= 0x20);
        NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
        lng += dlng;
        NSNumber *latitude = [[NSNumber alloc] initWithFloat:lat * 1e-5];
        NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
        //printf("[%f,", [latitude doubleValue]);
        //printf("%f]", [longitude doubleValue]);
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
        [array addObject:loc];
    }
    return array;
}
-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t
{
    NSString* saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
    NSString* daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];
    
    NSString* apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@", saddr, daddr];
    NSURL* apiUrl = [NSURL URLWithString:apiUrlStr];
    //NSLog(@"api url: %@", apiUrl);
    NSError* error = nil;
    NSString *apiResponse = [NSString stringWithContentsOfURL:apiUrl encoding:NSASCIIStringEncoding error:&error];
    NSString *encodedPoints = [apiResponse stringByMatching:@"points:\\\"([^\\\"]*)\\\"" capture:1L];
    return [self decodePolyLine:[encodedPoints mutableCopy]];
}
-(void) centerMap
{
    MKCoordinateRegion region;
    CLLocationDegrees maxLat = -90.0;
    CLLocationDegrees maxLon = -180.0;
    CLLocationDegrees minLat = 90.0;
    CLLocationDegrees minLon = 180.0;
    for(int idx = 0; idx < routes.count; idx++)
    {
        CLLocation* currentLocation = [routes objectAtIndex:idx];
        if(currentLocation.coordinate.latitude > maxLat)
            maxLat = currentLocation.coordinate.latitude;
        if(currentLocation.coordinate.latitude < minLat)
            minLat = currentLocation.coordinate.latitude;
        if(currentLocation.coordinate.longitude > maxLon)
            maxLon = currentLocation.coordinate.longitude;
        if(currentLocation.coordinate.longitude < minLon)
            minLon = currentLocation.coordinate.longitude;
    }
    region.center.latitude     = (maxLat + minLat) / 2.0;
    region.center.longitude    = (maxLon + minLon) / 2.0;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    
    region.span.latitudeDelta  = ((maxLat - minLat)<0.0)?100.0:(maxLat - minLat);
    region.span.longitudeDelta = ((maxLon - minLon)<0.0)?100.0:(maxLon - minLon);
    [_mapview setRegion:region animated:YES];
}

-(void) showRouteFrom: (MKPointAnnotation*) f to:(MKPointAnnotation *) t
{
    if(routes)
    {
        [_mapview removeAnnotations:[_mapview annotations]];
    }
    
    [_mapview addAnnotation:f];
    [_mapview addAnnotation:t];
    
    routes = [self calculateRoutesFrom:f.coordinate to:t.coordinate];
    NSInteger numberOfSteps = routes.count;
    
    CLLocationCoordinate2D coordinates[numberOfSteps];
    for (NSInteger index = 0; index < numberOfSteps; index++)
    {
        CLLocation *location = [routes objectAtIndex:index];
        CLLocationCoordinate2D coordinate = location.coordinate;
        coordinates[index] = coordinate;
    }
    MKPolyline *polyLine = [MKPolyline polylineWithCoordinates:coordinates count:numberOfSteps];
    [_mapview addOverlay:polyLine];
    [self centerMap];
}

#pragma mark MKPolyline delegate functions

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    } else {
        NSLog(@"Location services are not enabled");
    }
    db1=[[DBHandler alloc]init];
    arr=[[NSMutableArray alloc]init];
     arr1=[[NSMutableArray alloc]init];
    _mapview.delegate=self;
    _mapview.showsUserLocation = YES;
    [self CurrentLocationIdentifier];
   // CLLocationCoordinate2D center = CLLocationCoordinate2DMake(23.036816, 72.56143299999997);
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
   // MKCoordinateRegion regionToDisplay = MKCoordinateRegionMake(center, span);
   // [self.mapview setRegion:regionToDisplay];
        NSString *query1=[NSString stringWithFormat:@"select * from city"];
    arr=[db1 arrGetAllData:query1];
    NSLog(@"%@",arr);
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    self.lbllat.text = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    self.lbllong = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
        NSLog(@"longitude = %.8f\nlatitude = %.8f", currentLocation.coordinate.longitude,currentLocation.coordinate.latitude);
    
    // stop updating location in order to save battery power
    [locationManager stopUpdatingLocation];
    
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
         if (error == nil && [placemarks count] > 0)
         {
             CLPlacemark *placemark = [placemarks lastObject];
             
             // strAdd -> take bydefault value nil
             NSString *strAdd = nil;
             
             if ([placemark.subThoroughfare length] != 0)
                 strAdd = placemark.subThoroughfare;
             
             if ([placemark.thoroughfare length] != 0)
             {
                 // strAdd -> store value of current location
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark thoroughfare]];
                 else
                 {
                     // strAdd -> store only this value,which is not null
                     strAdd = placemark.thoroughfare;
                 }
             }
             
             if ([placemark.postalCode length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark postalCode]];
                 else
                     strAdd = placemark.postalCode;
             }
             
             if ([placemark.locality length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark locality]];
                 else
                     strAdd = placemark.locality;
             }
             
             if ([placemark.administrativeArea length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark administrativeArea]];
                 else
                     strAdd = placemark.administrativeArea;
             }
             
             if ([placemark.country length] != 0)
             {
                 if ([strAdd length] != 0)
                     strAdd = [NSString stringWithFormat:@"%@, %@",strAdd,[placemark country]];
                 else
                     strAdd = placemark.country;
             }
         }
     }];
}

#pragma mark MKPolyline delegate functions

- (void)getDirections
{
    MKDirectionsRequest *request =
    [[MKDirectionsRequest alloc] init];
    
    request.source = [MKMapItem mapItemForCurrentLocation];
    
    request.destination = _destination;
    request.requestsAlternateRoutes = NO;
    MKDirections *directions =
    [[MKDirections alloc] initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:
     ^(MKDirectionsResponse *response, NSError *error) {
         if (error) {
             // Handle error
         } else {
             [self showRoute:response];
         }
     }];
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
/*
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
     //}];
//}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}

- (void)reverseGeocode:(CLLocation *)location {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Finding address");
        if (error) {
            NSLog(@"Error %@", error.description);
        } else {
            CLPlacemark *placemark = [placemarks lastObject];
            self.myAddress.text = [NSString stringWithFormat:@"%@", ABCreateStringWithAddressDictionary(placemark.addressDictionary, NO)];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [locationManager startUpdatingLocation];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D myCoordinate;
    myCoordinate.latitude=23.036816;
    myCoordinate.longitude=72.56143299999997;
    annotation.coordinate = myCoordinate;
    annotation.title=@"Abbacus Technology, ";
    annotation.subtitle = @"khasi parekh Complex,Ahmedabad ";
    [_mapview addAnnotation:annotation];
    
}



/*
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog( @"didUpdateLocation!");
    NSLog( @"latitude is %@ and longitude is %@",getUserLatitude,  getUserLongitude);
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSString * addressName = [placemark name];
            NSString * city = [placemark locality]; // locality means "city"
            NSString * administrativeArea = [placemark administrativeArea]; // which is "state" in the U.S.A.
            
            NSLog( @"name is %@ and locality is %@ and administrative area is %@", addressName, city, administrativeArea );
        }
    }];
}
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arr count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"idCellRecord";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:MyIdentifier] ;
    }
    cell.textLabel.text=[[arr objectAtIndex:indexPath.row]objectForKey:@"city"];
    tempname=cell.textLabel.text;
        return cell;
}
- (IBAction)myLocation:(id)sender {
    
}
-(NSString*)getAddressFromLatLong : (NSString *)latLng {
    //  NSString *string = [[Address.text stringByAppendingFormat:@"+%@",cityTxt.text] stringByAppendingFormat:@"+%@",addressText];
    NSString *esc_addr =  [latLng stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *dataArray = (NSMutableArray *)[data valueForKey:@"results" ];
    if (dataArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter a valid address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        for (id firstTime in dataArray) {
            NSString *jsonStr1 = [firstTime valueForKey:@"formatted_address"];
            return jsonStr1;
        }
    }
    
    return nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (!self.geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    NSString *address = [NSString stringWithFormat:@"%@ ", self.searchtext.text];
    
    self.searchtext.enabled = NO;
    
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
           CLLocation *location = placemark.location;
           CLLocationCoordinate2D coordinate = location.coordinate;
           NSString *searchlan = [NSString stringWithFormat:@"%f", coordinate.latitude];
           NSString *searchlon=[NSString stringWithFormat:@"%f",coordinate.longitude];
            lat=coordinate.latitude;
           lon = coordinate.longitude;
    
            NSLog(@"%f",lat);
            NSLog(@"%f",lon);
            CLLocationCoordinate2D coordinateArray[2];
            
            coordinateArray[0] = CLLocationCoordinate2DMake(23.036816, 72.56143299999997);
            coordinateArray[1] = coordinate;
            self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
            [_mapview removeAnnotation:[self.mapview.annotations objectAtIndex:0]];
            
           
                [_mapview addOverlay:self.routeLine];
                
           
            
        }
        
        
    }];
    
    ////////////////
    MKLocalSearchRequest *request =
    [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchtext.text;
    request.region = _mapview.region;
    
    _matchingItems = [[NSMutableArray alloc] init];
    
    MKLocalSearch *search =
    [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
        {
            for (MKMapItem *item in response.mapItems)
            {
                [_matchingItems addObject:item];
                MKPointAnnotation *annotation =
                [[MKPointAnnotation alloc]init];
                annotation.coordinate = item.placemark.coordinate;
                NSLog(@"%@",annotation);
                annotation.title = item.name;
                [_mapview addAnnotation:annotation];
            }
            
        }
        
        
    }];
   
    NSString *query2=[NSString stringWithFormat:@"select city from city where city='%@'",searchtext.text];
    BOOL isexist=[db1 getemailID:query2];
    if (isexist) {
        NSLog(@"city is exist");
        
    }
    else
    {
        NSLog(@"not exist");
        NSString *city=searchtext.text ;
        NSString *query=[NSString stringWithFormat:@"insert into city(city) values('%@')",city];
        BOOL isinsert=[db1 insertData:query];
        if (isinsert) {
            NSLog(@"data insert");
           // [self.tableview reloadData];
        }
        else
        {
            NSLog(@"data not insert");
          //  [self.tableview reloadData];
        }
       
    }
    NSString *query1=[NSString stringWithFormat:@"select * from city"];
    arr1=[db1 arrGetAllData:query1];
    NSLog(@"%@",arr);
    [self.tableview reloadData];
        return YES;
    

   
}


// this delegate method is called if an error occurs in locating your current location


// this delegate is called when the reverseGeocoder finds a placemark


// this delegate is called when the reversegeocoder fails to find a placemark

- (MKPolylineRenderer *)mapView:(MKMapView *)mapView viewForOverlay:(id)overlay{
    if (_mapview.overlays.count > 1)
    {
        [_mapview removeOverlay:[_mapview.overlays objectAtIndex:0]];
        
    }
    else
    {
        
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor blueColor]];
        [renderer setLineWidth:5.0];
         return renderer;
    }
   // [_mapview removeAnnotation:[self.mapview.annotations objectAtIndex:]];
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    [renderer setStrokeColor:[UIColor blueColor]];
    [renderer setLineWidth:5.0];
    return renderer;
    
    
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier = @"idCellRecord";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
   
     cell.textLabel.text=[[arr objectAtIndex:indexPath.row]objectForKey:@"city"];
    tempname=cell.textLabel.text;
     NSLog(@"%@",tempname);
    if (!self.geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    
    NSString *address = [NSString stringWithFormat:@"%@ ", tempname];
    
   //cell.textLabel.text.enabled = NO;
    
    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            CLLocation *location = placemark.location;
            CLLocationCoordinate2D coordinate = location.coordinate;
            NSString *searchlan = [NSString stringWithFormat:@"%f", coordinate.latitude];
            NSString *searchlon=[NSString stringWithFormat:@"%f",coordinate.longitude];
            lat=coordinate.latitude;
            lon = coordinate.longitude;
            
            NSLog(@"%f",lat);
            NSLog(@"%f",lon);
            CLLocationCoordinate2D coordinateArray[2];
            
            coordinateArray[0] = CLLocationCoordinate2DMake(23.036816, 72.56143299999997);
            coordinateArray[1] = coordinate;
            self.routeLine = [MKPolyline polylineWithCoordinates:coordinateArray count:2];
            
            [_mapview removeAnnotation:[self.mapview.annotations objectAtIndex:0]];
            [_mapview addOverlay:self.routeLine];
            
            
        }
    }];
    
    ////////////////
    MKLocalSearchRequest *request =
    [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = tempname;
    request.region = _mapview.region;
    
    _matchingItems = [[NSMutableArray alloc] init];
    
    MKLocalSearch *search =
    [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
        {
            for (MKMapItem *item in response.mapItems)
            {
                [_matchingItems addObject:item];
                MKPointAnnotation *annotation =
                [[MKPointAnnotation alloc]init];
                annotation.coordinate = item.placemark.coordinate;
                NSLog(@"%@",annotation);
                annotation.title = item.name;
                [_mapview addAnnotation:annotation];
            }
            
        }
        
               
        
    }];
    

    //[self doSomethingWithRowAtIndexPath:indexPath];
}
- (void)addRoute {
    NSString *thePath = [[NSBundle mainBundle] pathForResource:@"EntranceToGoliathRoute" ofType:@"plist"];
    NSArray *pointsArray = [NSArray arrayWithContentsOfFile:thePath];
    
    NSInteger pointsCount = pointsArray.count;
    
    CLLocationCoordinate2D pointsToUse[pointsCount];
    
    for(int i = 0; i < pointsCount; i++) {
        CGPoint p = CGPointFromString(pointsArray[i]);
        pointsToUse[i] = CLLocationCoordinate2DMake(p.x,p.y);
    }
    
    MKPolyline *myPolyline = [MKPolyline polylineWithCoordinates:pointsToUse count:pointsCount];
    
    [self.mapview addOverlay:myPolyline];
}
-(void)findCurrentLocation
{
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    if ([locationManager locationServicesEnabled])
    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        [locationManager startUpdatingLocation];
    }
    
    
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    NSString *str=[[NSString alloc] initWithFormat:@" latitude:%f longitude:%f",coordinate.latitude,coordinate.longitude];
    NSLog(@"%@",str);
    
    
}
-(void)loadRoute
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"csv"];
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    MKMapPoint northEastPoint;
    MKMapPoint southWestPoint;
    
    MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * pointStrings.count);
    
    for(int idx = 0; idx < pointStrings.count; idx++)
    {
        NSString* currentPointString = [pointStrings objectAtIndex:idx];
        NSArray* latLonArr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
        CLLocationDegrees latitude = [[latLonArr objectAtIndex:0] doubleValue];
        CLLocationDegrees longitude = [[latLonArr objectAtIndex:1] doubleValue];
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
        MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
        if (idx == 0) {
            northEastPoint = point;
            southWestPoint = point;
        }
        else
        {
            if (point.x > northEastPoint.x)
                northEastPoint.x = point.x;
            if(point.y > northEastPoint.y)
                northEastPoint.y = point.y;
            if (point.x < southWestPoint.x)
                southWestPoint.x = point.x;
            if (point.y < southWestPoint.y)
                southWestPoint.y = point.y;
        }
        
        pointArr[idx] = point;
        
    }
    
    self.routeLine = [MKPolyline polylineWithPoints:pointArr count:pointStrings.count];
    
    
    
    free(pointArr);
    
}
-(void)showRoute:(MKDirectionsResponse *)response
{
    for (MKRoute *route in response.routes)
    {
        [_mapview
         addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
        
        for (MKRouteStep *step in route.steps)
        {
            NSLog(@"%@", step.instructions);
        }
    }
}
- (void)geocodeFromAddress:(NSString *)address {
    //6
    
}
- (NSArray*)getRoutePointFrom:(MKPointAnnotation *)origin to:(MKPointAnnotation *)destination
{
    NSString* saddr = [NSString stringWithFormat:@"%f,%f", origin.coordinate.latitude, origin.coordinate.longitude];
    NSString* daddr = [NSString stringWithFormat:@"%f,%f", destination.coordinate.latitude, destination.coordinate.longitude];
    
    NSString* apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@", saddr, daddr];
    NSURL* apiUrl = [NSURL URLWithString:apiUrlStr];
    
    NSError *error;
    NSString *apiResponse = [NSString stringWithContentsOfURL:apiUrl encoding:NSUTF8StringEncoding error:&error];
  //  NSString* encodedPoints = [apiResponse stringByMatching:@"points:\\\"([^\\\"]*)\\\"" capture:1L];
    
    return 0;
}

- (IBAction)zoomin:(id)sender {
}

- (IBAction)search:(id)sender {
    
}
- (void) performSearch {
   }
- (IBAction)textfieldreturn:(id)sender
{
    [self performSearch];
}
@end
