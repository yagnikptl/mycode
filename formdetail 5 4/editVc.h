//
//  editVc.h
//  formdetail
//
//  Created by Arpit on 01/06/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
#import "CustomURLConnection.h"
#import "JSONKit.h"
@interface editVc : UIViewController<UITextFieldDelegate,CustomURLConnectionDelegate,EDStarRatingProtocol>

    {
        IBOutlet UIButton *countryBtnName;
        IBOutlet UIButton *stateBtnName;
        IBOutlet UIButton *cityBtnName;
        IBOutlet UIButton *photobrowse;
        BOOL checkboxbutton1;
        BOOL checkboxbutton2;
        BOOL checkboxbutton3;
        BOOL checkboxbutton4;
        UITextField *myTextField;
        NSArray *pickerArray;
        NSArray *country;
        NSArray *country1;
        NSArray *state;
        NSArray *state1;
        NSArray *city;
        NSArray *city1;
        NSString *statebtnNm;
        NSString *statebtnid;
        NSString *cunty;
        NSString *countrybtnNm;
        NSString *citybtnNm;
        NSString *citybtnid;
        NSString *myPhotoString;
        NSString *checkboxbutton;
        NSString *checkbtn2;
        NSArray *stringarr;
        NSString *main;
        NSMutableArray *result;
         NSString *Hobbiesedited;
        NSString *hobies;
         NSString *Hobbieseditednew;

        
    }



    @property (strong, nonatomic)NSString *names;
 @property (strong, nonatomic)NSString *email;
 @property (strong, nonatomic)NSString *phone;
 @property (strong, nonatomic)NSString *addresss;
 @property (strong, nonatomic)NSString *gender;
 @property (strong, nonatomic)NSString *hobby;
 @property (strong, nonatomic)NSString *birthdata;
 @property (strong, nonatomic)NSString *country1;
 @property (strong, nonatomic)NSString *state1;
 @property (strong, nonatomic)NSString *city1;
 @property (strong, nonatomic)NSString *image;
 @property (strong, nonatomic)NSString *status;
 @property (strong, nonatomic)NSString *rate;
    

@property (strong, nonatomic) IBOutlet UITextField *nametextfield;
@property (strong, nonatomic) IBOutlet UITextField *emailtextfield;
@property (strong, nonatomic) IBOutlet UITextField *phonetextfield;
@property (strong, nonatomic) IBOutlet UITextField *address;

@property (strong, nonatomic) IBOutlet UIButton *radiobutton1;
@property (strong, nonatomic) IBOutlet UIButton *radiobutton2;
- (IBAction)radio:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *checkbox1;
@property (strong, nonatomic) IBOutlet UIButton *checkbox2;
@property (strong, nonatomic) IBOutlet UIButton *checkbox3;
@property (strong, nonatomic) IBOutlet UIButton *checkbox4;
- (IBAction)checkboxbutton:(id)sender;
- (IBAction)radioclick:(id)sender;
- (IBAction)clickinsert:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *birthtextfield;
@property (strong, nonatomic) IBOutlet UITextField *country;
- (IBAction)clicktext:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *state;
@property (strong, nonatomic) IBOutlet UITextField *city;
- (IBAction)stateclick:(id)sender;
- (IBAction)cityclick:(id)sender;
- (IBAction)countrybutton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *radiobutton;

@property (strong, nonatomic) IBOutlet UIPickerView *mypickerview;
@property (strong, nonatomic) IBOutlet UIButton *countrybtn;
@property (strong, nonatomic) IBOutlet UIButton *statebtn;
@property (strong, nonatomic) IBOutlet UIButton *citybtn;
@property (strong, nonatomic) IBOutlet UIButton *photoupload;
@property (strong, nonatomic) IBOutlet UIView *ratingview;
- (IBAction)updatebutton:(id)sender;
- (IBAction)statebutton:(id)sender;

- (IBAction)citybutton:(id)sender;
- (IBAction)photoupload:(id)sender;
- (IBAction)checkbutton:(id)sender;
- (IBAction)radiobutton:(id)sender;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
- (IBAction)donebutton:(id)sender;

@end
