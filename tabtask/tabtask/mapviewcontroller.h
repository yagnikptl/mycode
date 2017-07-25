//
//  mapviewcontroller.h
//  tabtask
//
//  Created by Arpit on 03/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>
@interface mapviewcontroller : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapview;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation* currentLocation;
@property (strong, nonatomic) IBOutlet UILabel *lbllat;
@property (strong, nonatomic) IBOutlet UILabel *lbllong;
- (IBAction)button:(id)sender;

@end
