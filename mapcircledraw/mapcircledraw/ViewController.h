//
//  ViewController.h
//  mapcircledraw
//
//  Created by Arpit on 09/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import<CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController<MKMapViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
{
CLLocationManager *locationManager;
    CLLocation *currentLocation,*locations;
    NSArray *routes;
    BOOL isUpdatingRoutes;
   
}
@property (nonatomic, strong)NSArray *data;
@property (nonatomic, strong) id Delegate;
@property (nonatomic, retain) MKPolyline* polyline;
@property (strong, nonatomic) NSMutableArray *matchingItems;
@property (strong, nonatomic) MKMapItem *destination;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) IBOutlet MKMapView *mapview;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;
@property (strong, nonatomic) IBOutlet UILabel *myAddress;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property (strong, nonatomic) IBOutlet UITextField *searchtext;
@property (nonatomic, retain) MKPolyline *routeLine;
@property (nonatomic, retain) MKPolylineView *routeLineView;
- (IBAction)zoomin:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbllat;
@property (strong, nonatomic) IBOutlet UILabel *lbllong;

- (IBAction)search:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *latitude;

@property (strong, nonatomic) IBOutlet UILabel *logitude;

@property (strong, nonatomic) CLLocation *location;
- (IBAction)myLocation:(id)sender;
- (IBAction)textfieldreturn:(id)sender;
- (id) initWithPolylineView:(MKAnnotationView *)polylineView
                    mapView:(MKMapView *)mapView;
-(void) showRouteFrom: (MKPointAnnotation *) f to:(MKPointAnnotation *) t;
@end

