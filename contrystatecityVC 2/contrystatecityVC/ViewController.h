//
//  ViewController.h
//  contrystatecityVC
//
//  Created by Arpit on 11/04/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tabledataVC.h"
@interface ViewController : UIViewController<NSURLConnectionDelegate>
{
    IBOutlet UIButton *btnCountryName;
    NSArray *country;
}
@property (strong, nonatomic)NSString *tempname;
@property (strong, nonatomic) IBOutlet UILabel *dislabel;

- (IBAction)countryButton:(id)sender;

- (IBAction)stateButton:(id)sender;


- (IBAction)cityButton:(id)sender;


@end

