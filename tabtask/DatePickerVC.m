//
//  DatePickerVC.m
//  tabtask
//
//  Created by Arpit on 03/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "DatePickerVC.h"

@interface DatePickerVC ()

@end

@implementation DatePickerVC
@synthesize datepicker;

@synthesize datelabel;


#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
   [datepicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
       //[datePicker release];
    
    
}
- (void)datePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy hh:mm"];
    NSString *strDate = [dateFormatter stringFromDate:datePicker.date];
    datelabel.text = strDate;
}
@end
