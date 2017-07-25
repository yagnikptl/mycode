//
//  ViewController.m
//  formdetail
//
//  Created by Arpit on 31/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "ViewController.h"
#import "DBHandler.h"
#import "JSONKit.h"
#import "editVc.h"
#import "tablevc.h"
@interface ViewController ()
{
    NSString *btnpress;
    NSString *hobbybtn;
    DBHandler *db;
    NSString*strnameList;
    NSString *ratingString;
    NSString *btn1;
     NSString *hbbby;
    NSString *savedImagePathss;
    NSString *myUniqueName;
    NSString *cid;
    UIDatePicker *datePicker;
    NSInteger selectedRow;
   
}
@property (weak, nonatomic) IBOutlet EDStarRating *starRating;
@property (strong,nonatomic) NSArray *colors;
@end

@implementation ViewController
@synthesize delegate;
@synthesize starRating=_starRating;
@synthesize radiobutton1,radiobutton2;
@synthesize checkbox1,checkbox2,checkbox3,checkbox4;
int textFieldTouched = 1;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self rating];
   //
    self.navigationItem.hidesBackButton = YES;
    db=[[DBHandler alloc]init];
    country=[[NSArray alloc]init];
    [radiobutton1 setImage:[UIImage imageNamed:@"RadioButton-Selected.png"] forState:UIControlStateSelected];
    radiobutton1.layer.cornerRadius=3;
    radiobutton1.layer.masksToBounds=YES;
    radiobutton1.tag=1;
    [radiobutton1 addTarget:self action:@selector(buttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    [radiobutton2 setImage:[UIImage imageNamed:@"RadioButton-Selected.png"] forState:UIControlStateSelected];
    radiobutton2.layer.cornerRadius=3;
    radiobutton2.layer.masksToBounds=YES;
    radiobutton2.tag=2;
    [radiobutton2 addTarget:self action:@selector(buttonclicked:) forControlEvents:UIControlEventTouchUpInside];
    NSUserDefaults *savedValue =[NSUserDefaults standardUserDefaults];
    checkboxbutton1=[savedValue boolForKey:@"box1IsChecked"];
    checkboxbutton2=[savedValue boolForKey:@"box2IsChecked"];
   checkboxbutton3=[savedValue boolForKey:@"box3IsChecked"];
    checkboxbutton4=[savedValue boolForKey:@"box4IsChecked"];
   // [self checkthemark];
    datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [toolbar setTintColor:[UIColor grayColor]];
     UIBarButtonItem *donebtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(showselectdate)];
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolbar setItems:[NSArray arrayWithObjects:space,donebtn,nil]];
    [self.birthtextfield setInputAccessoryView:toolbar];
    //[datePicker addTarget:self action:@selector(dateTextField:) forControlEvents:UIControlEventValueChanged];
    [_birthtextfield setInputView:datePicker];
    
//    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
//    [toolBar setBarStyle:UIBarStyleBlackOpaque];
//    UIBarButtonItem *barButtonDone=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonSystemItemDone target:self action:@selector(pickerDoneClicked:)];
//    toolBar.items = @[barButtonDone];
//    barButtonDone.tintColor=[UIColor blackColor];
//    [_mypickerview addSubview:toolBar];
    
        
       // Do any additional setup after loading the view, typically from a nib.
}
- (void)pickerDoneClicked:(id)sender {
    //[datePicker removeFromSuperview];
    NSLog(@"hhhh");
    _mypickerview.hidden = YES;

    //[textField resignFirstResponder];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_nametextfield resignFirstResponder];
    [_emailtextfield resignFirstResponder];
    [_phonetextfield resignFirstResponder];
    [_address resignFirstResponder];
    [_birthtextfield resignFirstResponder];
     _mypickerview.hidden = YES;
    _toolbar.hidden=YES;
}
-(void)viewWillAppear:(BOOL)animated
{
     _mypickerview.hidden=YES;
    _toolbar.hidden=YES;
   
//    _nametextfield.text=@"";
//    _emailtextfield.text=@"";
//    _phonetextfield.text=@"";
//    _address.text=@"";
//    radiobutton1.tag=@"";
//    checkbox1.tag=@"";
//    checkbox2.tag=@"";
//    checkbox3.tag=@"";
//    checkbox4.tag=@"";
   // _birthtextfield.text=@"";
    
    [super viewWillAppear:YES];
    
    
}

//-(void) dateTextField:(id)sender
//{
////    UIDatePicker *picker = (UIDatePicker*)_birthtextfield.inputView;
////    [picker setMaximumDate:[NSDate date]];
//    datepicker=[[UIDatePicker alloc]init];
//    datePicker.datePickerMode=UIDatePickerModeDate;
//    [self.birthtextfield setInputView:datePicker];
//    UIToolbar *toolbar=[[UIToolbar alloc]initWithFrame:CGRectMake(10, 50, 500, 300)];
//    [toolbar setTintColor:[UIColor grayColor]];
//    UIBarButtonItem *donebtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(showselectdate)];
//    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    [toolbar setItems:[NSArray arrayWithObjects:space,donebtn,nil]];
//    [self.birthtextfield setInputAccessoryView:toolbar];
//    //NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//   // NSDate *eventDate = picker.date;
//    //[dateFormat setDateFormat:@"dd/MM/yyyy"];
//    
//    //NSString *dateString = [dateFormat stringFromDate:eventDate];
//   // _birthtextfield.text = [NSString stringWithFormat:@"%@",dateString];
//   // [_birthtextfield resignFirstResponder];
//    
//}
-(void)showselectdate
{
    
    UIDatePicker *picker = (UIDatePicker*)_birthtextfield.inputView;
    [picker setMaximumDate:[NSDate date]];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    NSDate *eventDate = picker.date;
    [dateFormat setDateFormat:@"dd/MM/yyyy"];
    NSString *dateString = [dateFormat stringFromDate:eventDate];
    _birthtextfield.text = [NSString stringWithFormat:@"%@",dateString];
    [self.birthtextfield resignFirstResponder];
}
-(void)cancelselectdate
{
    datePicker.hidden=YES;
}
-(void)buttonclicked:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
            if ([radiobutton1 isSelected] == YES)
            {
                [radiobutton1 setSelected:NO];
            }
            else
            {
                [radiobutton1 setSelected:YES];
                [radiobutton2 setSelected:NO];
                
            }
            break;
        case 2:
            if ([radiobutton2 isSelected] == YES)
            {
                [radiobutton2 setSelected:NO];
            }
            else
            {
                [radiobutton2 setSelected:YES];
                [radiobutton1 setSelected:NO];
                
            }
            break;

        default:
            break;
    }
    
    
    btnpress=[NSString stringWithFormat:@"%@",sender.titleLabel.text];
    
}

//-(void)checkthemark
//{
//    if(!checkboxbutton1)
//    {
//        [checkbox1 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
//    }
//    else if (checkboxbutton1)
//    {
//        [checkbox1 setImage:[UIImage imageNamed:@"checkboxmarked.png"] forState:UIControlStateNormal];
//    }
//}
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    NSLog(@"changed to %lu in %@",(unsigned long)index,groupId);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)radio:(id)sender {
}
- (IBAction)checkboxbutton:(id)sender {
    if ([sender tag]==0) {
        NSLog(@"button1");
        if (checkboxbutton1) {
            [self uncheckBox:0];
            
        }
        else if (!checkboxbutton1)
        {
            [self checkBox:0];
            checkboxbutton=[NSString stringWithFormat:@"%@",checkbox1.titleLabel.text];
        }
    }
    if ([sender tag]==1) {
        NSLog(@"button2");
        if (checkboxbutton2) {
            [self uncheckBox:1];
            
        }
        else if (!checkboxbutton2)
        {
            [self checkBox:1];
            checkbtn2=[NSString stringWithFormat:@"%@",checkbox2.titleLabel.text];
        }

        
    }
    if ([sender tag]==2) {
        NSLog(@"button3");
        if (checkboxbutton3) {
            [self uncheckBox:2];
            
        }
        else if (!checkboxbutton3)
        {
            [self checkBox:2];
            checkbtn3=[NSString stringWithFormat:@"%@",checkbox3.titleLabel.text];
        }

        
    }
    if ([sender tag]==3) {
        NSLog(@"button4");
        if (checkboxbutton4) {
            [self uncheckBox:3];
            
        }
        else if (!checkboxbutton4)
        {
            [self checkBox:3];
            checkbtn4=[NSString stringWithFormat:@"%@",checkbox4.titleLabel.text];
        }

    }
    
   // hobbybtn=[sender currentTitle];
    if (!(checkboxbutton.length==0 && checkbtn2.length==0))
    {
        stringarr=[[NSArray alloc]init];
        NSArray *arr1= [[NSArray alloc] initWithObjects:checkboxbutton, nil];
        NSArray *arr2 = [[NSArray alloc] initWithObjects:checkbtn2, nil];
         NSArray *arr3 = [[NSArray alloc] initWithObjects:checkbtn3, nil];
         NSArray *arr4 = [[NSArray alloc] initWithObjects:checkbtn4, nil];
        stringarr = [arr1 arrayByAddingObjectsFromArray:arr2];
        //stringarr = [arr1 arrayByAddingObjectsFromArray:arr3];
       // stringarr = [arr1 arrayByAddingObjectsFromArray:arr4];
        main=[stringarr componentsJoinedByString:@" ,"];
        NSLog(@"%@",main);
    }

   
    
}


//-(void)viewWillAppear:(BOOL)animated
//{
//    if([self.strScreen isEqualToString:@"Select Country Name"])
//    {
//        [self getcountry];
//    }
//    else if ([self.strScreen isEqualToString:@"Select State Name"])
//    {
//        [self getstate];
//    }
//    else if ([self.strScreen isEqualToString:@"Select City Name"])
//    {
//        [self getcity];
//    }
//}

- (IBAction)radioclick:(id)sender {
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _country) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)checkBox:(int)sender
{
    NSUserDefaults *default1 =[NSUserDefaults standardUserDefaults];
    if (sender==0) {
        [checkbox1 setImage:[UIImage imageNamed:@"checkboxmarked.png"] forState:UIControlStateNormal];
        [default1 setBool:YES forKey:@"box1IsChecked"];
        checkboxbutton1=YES;
        btn1=checkbox1.titleLabel.text;
        NSLog(@"%@",btn1);
    }
    if (sender==1) {
        [checkbox2 setImage:[UIImage imageNamed:@"checkboxmarked.png"] forState:UIControlStateNormal];
        [default1 setBool:YES forKey:@"box2IsChecked"];
        checkboxbutton2=YES;
        btn1=checkbox2.titleLabel.text;
        NSLog(@"%@",hbbby);
    }
    if (sender==2) {
        [checkbox3 setImage:[UIImage imageNamed:@"checkboxmarked.png"] forState:UIControlStateNormal];
        [default1 setBool:YES forKey:@"box3IsChecked"];
        checkboxbutton3=YES;
         btn1=checkbox3.titleLabel.text;
        NSLog(@"%@",hbbby);
    }
    if (sender==3) {
        [checkbox4 setImage:[UIImage imageNamed:@"checkboxmarked.png"] forState:UIControlStateNormal];
        [default1 setBool:YES forKey:@"box4IsChecked"];
        checkboxbutton4=YES;
         btn1=checkbox4.titleLabel.text;
        NSLog(@"%@",hbbby);
    }
    
    if (checkboxbutton1 ==YES) {
        NSLog(@"button1");
    }
    else if (checkboxbutton2==YES)
    {
        NSLog(@"button2");
    }
    else if (checkboxbutton3==YES)
    {
        NSLog(@"button3");
    }
    else if (checkboxbutton4==YES)
    {
        NSLog(@"button4");
    }
    if (checkboxbutton1 == YES && checkboxbutton2==YES & checkboxbutton3==YES && checkboxbutton4==YES) {
        NSLog(@"allbutton values");
    }

    [default1 synchronize];
    
    
}
-(void)uncheckBox:(int)sender
{
    NSUserDefaults *default2 =[NSUserDefaults standardUserDefaults];
    if (sender==0) {
        [checkbox1 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [default2 setBool:NO forKey:@"box1IsChecked"];
        checkboxbutton1=NO;
    }
    if (sender==1) {
        [checkbox2 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [default2 setBool:NO forKey:@"box2IsChecked"];
        checkboxbutton2=NO;
    }
    if (sender==2) {
        [checkbox3 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [default2 setBool:NO forKey:@"box3IsChecked"];
        checkboxbutton3=NO;
    }
    if (sender==3) {
        [checkbox4 setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        [default2 setBool:NO forKey:@"box4IsChecked"];
        checkboxbutton4=NO;
    }
       [default2 synchronize];
}
//-(void)addPickerView{
//    [[CustomURLConnection alloc]initWithURLByPost:@"http://mobileapi.the-timeshare.com/CommonWebService.asmx/getCountryList" PostString:@"" withMethod:@"GET"withDelegate:self isPostJson:NO withTag:1 withLoader:YES];
//   
//    
//    
//   
//    
////    pickerArray = [[NSArray alloc]initWithObjects:@"Physics",
////                   @"Chemistry",@"Mathematics",@"Biology",@"History", nil];
////    myTextField = [[UITextField alloc]initWithFrame:
////                   CGRectMake(10, 100, 300, 30)];
////    myTextField.borderStyle = UITextBorderStyleRoundedRect;
////    myTextField.textAlignment = UITextAlignmentCenter;
//    _country.delegate = self;
//    [self.view addSubview:_country];
////    [myTextField setPlaceholder:@"Select a Subject"];
//    myPickerView = [[UIPickerView alloc]init];
//    myPickerView.dataSource = self;
//    myPickerView.delegate = self;
//    myPickerView.showsSelectionIndicator = YES;
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
//                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
//                                   target:self action:@selector(done:)];
//   
//    _country.inputView = myPickerView;
//    _state.inputView=myPickerView;
//    _city.inputView=myPickerView;
//   
//    
//}

-(void)requestFinished:(CustomURLConnection *)request withResult:(NSDictionary *)dictionary withTag:(NSInteger)apiTag
{
    if(apiTag==1)
    {
        NSLog(@"%@",dictionary);
        country=[dictionary objectForKey:@"result"];
        NSLog(@"%@",country);
        //name=[dictionary valueForKey:@"countryId"];
        strnameList=@"country";
        [self.mypickerview reloadAllComponents];
       
    }
    else if (apiTag==2)
    {
        NSLog(@"%@",dictionary);
        state=[dictionary objectForKey:@"result"];
        if ([state isEqual:@"State is not available."]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"opss...."
                                                            message:@"State Not Available Select Another Country  ."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        
        }
        else
        {
        
        
        NSLog(@"%@",state);
        strnameList=@"state";
        [self.mypickerview reloadAllComponents];
        }
        //[self.tableview reloadData];
    }
    else if (apiTag==3)
    {
        NSLog(@"%@",dictionary);
        city=[dictionary objectForKey:@"result"];
        if ([city isEqual:@"City is not available."])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"opss...."
                                                            message:@"City Not Available Select Another State  ."
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
        
        NSLog(@"%@",city);
        strnameList=@"city";
        [self.mypickerview reloadAllComponents];
        }
    }
}



//- (IBAction)clicktext:(id)sender {
//   [[CustomURLConnection alloc]initWithURLByPost:@"http://mobileapi.the-timeshare.com/CommonWebService.asmx/getCountryList" PostString:@"" withMethod:@"GET"withDelegate:self isPostJson:NO withTag:1 withLoader:YES];
//   
//}
- (IBAction)stateclick:(id)sender {
}

- (IBAction)cityclick:(id)sender {
}

- (IBAction)countrybutton:(id)sender {
   
    _mypickerview.hidden=NO;
    _toolbar.hidden=NO;
       
    [[CustomURLConnection alloc]initWithURLByPost:@"http://mobileapi.the-timeshare.com/CommonWebService.asmx/getCountryList" PostString:@"" withMethod:@"GET"withDelegate:self isPostJson:NO withTag:1 withLoader:YES];
}

-(IBAction)aMethod:(id)sender
{
    [PickerView removeFromSuperview];
    
    [doneButton removeFromSuperview];
    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if ([strnameList isEqualToString:@"country"])
    {
        
        return country.count;
    }
    else if ([strnameList isEqualToString:@"state"])
    {
        return [state count];
    }
    else
    {
        return [city count];
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1; // or 2 or more
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    
    if ([strnameList isEqualToString:@"country"])
    {
       return [[country objectAtIndex:row]valueForKey:@"countryName"];
        
    }
    else if ([strnameList isEqualToString:@"state"])
    {
        
        return [[state objectAtIndex:row]objectForKey:@"stateName"];
    }
    else if([strnameList isEqualToString:@"city"])
    {
        return [[city objectAtIndex:row]objectForKey:@"cityName"];
    }
    else
    {
        return 0;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if ([strnameList isEqualToString:@"country"])
    {
        cunty=[[country objectAtIndex:row]valueForKey:@"countryName"];
        [self.countrybtn setTitle:cunty forState:UIControlStateNormal];
        countrybtnNm=[[country objectAtIndex:row]valueForKey:@"countryId"];
        [delegate countryId:countrybtnNm];
        //_mypickerview.hidden=YES;
    }
    else if ([strnameList isEqualToString:@"state"])
        
    {
        statebtnNm=[[state objectAtIndex:row]valueForKey:@"stateName"];
        [self.statebtn setTitle:statebtnNm forState:UIControlStateNormal];
        statebtnid=[[state objectAtIndex:row]valueForKey:@"stateId"];
       // _mypickerview.hidden=YES;
    }
    else if ([strnameList isEqualToString:@"city"])
        
    {
        citybtnNm=[[city objectAtIndex:row]valueForKey:@"cityName"];
        [self.citybtn setTitle:citybtnNm forState:UIControlStateNormal];
        citybtnid=[[city objectAtIndex:row]valueForKey:@"cityId"];
        //_mypickerview.hidden=YES;
        
    }
    
    
    return;
}

//-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
//    return [country count];
//}
//-(NSInteger)pickerView:(UIPickerView *)pickerView
//numberOfRowsInComponent:(NSInteger)component{
//    
//    
//    return 1;
//    
//}
//
//#pragma mark- Picker View Delegate
//
//-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
//(NSInteger)row inComponent:(NSInteger)component{
//    
//    [_country setText:[country objectAtIndex:row]];
//    
//    
//    
//    
//}
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:
//(NSInteger)row forComponent:(NSInteger)component{
//    
//    return [[country objectAtIndex:row]valueForKey:@"countryName"];;
//    
//}
-(void)countryId:(NSString *)countryid
{
    cid=countryid;
}
- (IBAction)statebutton:(id)sender {
   
    if (countrybtnNm==nil) {
        NSLog(@"Select Country");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"opss...."
                                                        message:@"Select country First."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    else
    {
        _mypickerview.hidden=NO;
        _toolbar.hidden=NO;
    NSLog(@"%@",countrybtnNm);
    NSDictionary *dicc=[NSDictionary dictionaryWithObject:countrybtnNm forKey:@"countryId"];
    NSString *strpost=[dicc JSONString];
    NSLog(@"%@",strpost);
    [[CustomURLConnection alloc]initWithURLByPost:@"http://mobileapi.the-timeshare.com/CommonWebService.asmx/getStateList"  PostString:strpost withMethod:@"POST" withDelegate:self isPostJson:YES withTag:2 withLoader:YES];
    }
}

- (IBAction)citybutton:(id)sender {
    
    if (statebtnid==nil) {
        NSLog(@"Select State");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"opss...."
                                                        message:@"Select State First."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    else
    {
        _mypickerview.hidden=NO;
        _toolbar.hidden=NO;
    NSDictionary *dics=[NSDictionary dictionaryWithObject:statebtnid forKey:@"stateId"];
    NSString *strpost=[dics JSONString];
    NSLog(@"%@",strpost);
    [[CustomURLConnection alloc]initWithURLByPost:@"http://mobileapi.the-timeshare.com/CommonWebService.asmx/getCityList" PostString:strpost withMethod:@"POST" withDelegate:self isPostJson:YES withTag:3 withLoader:YES];
        
    }
}

- (IBAction)photoupload:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:imagePickerController animated:YES];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"savedImage.png"];
}

- (IBAction)donebtn:(id)sender {
    _mypickerview.hidden=YES;
    _toolbar.hidden=YES;
    
}
- (void)imagePickerController:(UIImagePickerController *)UIPicker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    NSData *imageData = UIImagePNGRepresentation(image);
    [UIPicker dismissModalViewControllerAnimated:YES];
   NSString *originalImage = image;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *name=@"savedImage";
   myUniqueName = [NSString stringWithFormat:@"%@-%lu.png", name, (unsigned long)([[NSDate date] timeIntervalSince1970]*10.0)];
    savedImagePathss = [documentsDirectory stringByAppendingPathComponent:myUniqueName];
   
    
    if (![imageData writeToFile:savedImagePathss atomically:NO])
    {
        NSLog(@"Failed to cache image data to disk");
    }
    else
    {
        NSLog(@"the cachedImagedPath is %@", savedImagePathss);
        [_photoupload setTitle:myUniqueName forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:savedImagePathss forKey:@"AvatarKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    //UIImage *newImage = image;
    
}
-(void)rating
{
    self.colors = @[ [UIColor colorWithRed:0.11f green:0.38f blue:0.94f alpha:1.0f], [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f], [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f], [UIColor colorWithRed:0.35f green:0.35f blue:0.81f alpha:1.0f]];
    // Setup control using iOS7 tint Color
    _starRating.backgroundColor  = [UIColor whiteColor];
    _starRating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _starRating.maxRating = 5.0;
    _starRating.delegate = self;
    _starRating.horizontalMargin = 15.0;
    _starRating.editable=YES;
    _starRating.rating= 2.5;
    _starRating.displayMode=EDStarRatingDisplayHalf;
    [_starRating  setNeedsDisplay];
    _starRating.tintColor = self.colors[0];
    [self starsSelectionChanged:_starRating rating:2.5];
    
    
    // Setup control using image
    
    // This one will use the returnBlock instead of the delegate
    

}
- (void)viewDidUnload
{
    [self setStarRating:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}
-(void)starsSelectionChanged:(EDStarRating *)control rating:(float)rating
{
    ratingString = [NSString stringWithFormat:@"%.1f", rating];
    
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}
- (BOOL)myMobileNumberValidate:(NSString*)number
{
    NSString *numberRegEx = @"[0-9]{10}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numberRegEx];
    if ([numberTest evaluateWithObject:number] == YES)
        return TRUE;
    else
        return FALSE;
}

- (IBAction)clickinsert:(id)sender {
    
    NSString *name=_nametextfield.text;
    NSString *email=_emailtextfield.text;
    NSString *phone=_phonetextfield.text;
    NSString *address=_address.text;
    NSString *bdate=_birthtextfield.text;
    NSString *checkbutton1;
    NSString *checkbutton2;
    NSString *checkbutton3;
    NSString *checkbutton4;
    NSString *hobies;
    if (checkbtn2==nil)
        
    {
        hobies=checkboxbutton;
    }
    else if (checkboxbutton ==nil)
    {
        hobies=checkbtn2;
    }
    else
    {
        hobies=main;
    }

//    NSArray *myStrings = [[NSArray alloc] initWithObjects:checkbutton1, checkbutton2, checkbutton3,checkbutton4, nil];
//    NSString *joinedString = [myStrings componentsJoinedByString:@","];
    
    if (name.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"opss...."
                                                        message:@"Enter the Name."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if (email.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"opss...."
                                                        message:@"Enter the Email Address."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if (phone.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"opss...."
                                                        message:@"Enter the Phone Number."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else if (address.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"opss...."
                                                        message:@"Enter the Full Address."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    else if (bdate.length==0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"opss...."
                                                        message:@"Enter the Birthdate."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

    else if (![self NSStringIsValidEmail:email])
    {
        NSLog(@"opsssss...");
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"Wrong Email Address"
                                                         delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message show];
    }
    else if (![self myMobileNumberValidate:phone])
    {
        NSLog(@"opsssss...");
        UIAlertView *message4 = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"Enter only 10 digit "
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message4 show];
        
    }

    else
    {
    NSString *query1=[NSString stringWithFormat:@"insert into formdetail(name,email,phone,address,gender,hobbies,birthdate,rating,photos,country,state,city)values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",name,email,phone,address,btnpress,hobies,bdate,ratingString,myUniqueName,cunty,statebtnNm,citybtnNm];
    BOOL isinsert=[db insertData:query1];
    if (isinsert) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"Data Insert SuccessFully"
                                                         delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message show];

        
    }
    else
    {
        UIAlertView *message1 = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"Data Not Inserted"
                                                         delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message1 show];
    }
        tablevc *detail1=[self.storyboard instantiateViewControllerWithIdentifier:@"tablevc"];
        
        [self.navigationController pushViewController:detail1 animated:YES];
    }
    
    
}

@end
