//
//  MainFormViewController.h
//  formdemo
//
//  Created by Chandresh on 31/05/16.
//  Copyright © 2016 Chandresh. All rights reserved.
//
#import "CustomURLConnection.h"
#import "RateView.h"
#import "JSONKit.h"
#import "RadioButton.h"
#import "DBHandler.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface MainFormViewController : UIViewController<UIImagePickerControllerDelegate,RateViewDelegate>
{
  
    DBHandler *ObjDB;
    NSString *nameString;
    NSString *emailString;
    NSString *genderString;
    NSString *contactnoString;
    NSString *addressString;
    NSArray *tblData;
    NSString *status;
    NSString *checkboxbutton;
    IBOutlet UIButton *countryBtnName;
    IBOutlet UIButton *stateBtnName;
    IBOutlet UIButton *cityBtnName;
    NSArray *arrCountry;
    NSArray *countryName;
    NSString *cunty;
    NSString *countrybtnNm;
    NSArray *arrState;
    NSString *statebtnNm;
    NSString *statebtnid;
    NSArray *arrCity;
    NSString *citybtnNm;
    NSString *citybtnid;
    NSString *strname;
    NSString *strScreen;
    NSString *strDate;
    NSString *myPhotoString;
    
  }
@property (strong, nonatomic) IBOutlet RateView *rateView;
@property (strong, nonatomic) IBOutlet UIPickerView *thePickerView;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *PhoneNoField;
@property (strong, nonatomic) IBOutlet UITextView *AddressField;
@property (nonatomic, strong) IBOutlet RadioButton* radioButton;
@property (strong, nonatomic) IBOutlet RadioButton *FemaleButton;
@property (strong, nonatomic) IBOutlet RadioButton *MaleButton;
@property (strong, nonatomic) IBOutlet UIButton *checkBoxbutton;
@property (strong, nonatomic) IBOutlet UIButton *checkboxbtn2;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UIButton *birthdatee;
@property (strong, nonatomic) NSArray *arrCountry;
@property (strong, nonatomic) NSArray *arrState;
@property (strong, nonatomic) NSArray *arrCity;
@property (weak, nonatomic) IBOutlet UIButton *countrybtn;
@property (weak, nonatomic) IBOutlet UIButton *statebtn;
@property (weak, nonatomic) IBOutlet UIButton *citybtn;
@property (weak, nonatomic) IBOutlet UIButton *photoBrowse;


- (IBAction)photoBrowse:(id)sender;

- (IBAction)countryBtn:(id)sender;
- (IBAction)cityBtn:(id)sender;
- (IBAction)stateBtn:(id)sender;
- (IBAction)datepickbtn:(id)sender;
- (IBAction)drawingbtn:(id)sender;
- (IBAction)paintingbtn:(id)sender;
-(IBAction)oncheckbox:(id)sender;
- (IBAction)onInvertBtn:(id)sender;

- (IBAction)malecheck:(id)sender;

-(IBAction)onRadioBtn:(id)sender;
- (IBAction)Submit:(id)sender;

@end
