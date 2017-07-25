//
//  ViewController.h
//  formdetail
//
//  Created by Arpit on 31/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "CustomURLConnection.h"
#import "JSONKit.h"
#import "EDStarRating.h"
@protocol tableVCDelegate <NSObject>
-(void)countryId:(NSString *)countryid;
-(void)stateId:(NSString *)stateid;
@end
@interface ViewController : UIViewController<RadioButtonDelegate,UITextFieldDelegate,CustomURLConnectionDelegate,EDStarRatingProtocol,UIPickerViewDelegate>
{
    UIButton *pickerButton;
    UIPickerView *PickerView;
    NSMutableArray *array_from;
    UILabel *fromButton;
    UIButton *doneButton ;
    UIButton *backButton ;
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
    NSString *checkbtn3;
    NSString *checkbtn4;
    NSString *main;
    NSArray *stringarr;
    id<tableVCDelegate>delegate;
    
}
@property (strong, nonatomic)id<tableVCDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITextField *nametextfield;
@property (strong, nonatomic) IBOutlet UITextField *emailtextfield;
@property (strong, nonatomic) IBOutlet UITextField *phonetextfield;
@property (strong, nonatomic) IBOutlet UITextView *address;
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

@property (strong, nonatomic) IBOutlet UIPickerView *mypickerview;
@property (strong, nonatomic) IBOutlet UIButton *countrybtn;
@property (strong, nonatomic) IBOutlet UIButton *statebtn;
@property (strong, nonatomic) IBOutlet UIButton *citybtn;
@property (strong, nonatomic) IBOutlet UIButton *photoupload;
@property (strong, nonatomic) IBOutlet UIView *ratingview;
@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;

- (IBAction)statebutton:(id)sender;

- (IBAction)citybutton:(id)sender;
- (IBAction)photoupload:(id)sender;
- (IBAction)donebtn:(id)sender;


@end

