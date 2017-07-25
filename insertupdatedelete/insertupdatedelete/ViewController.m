//
//  ViewController.m
//  insertupdatedelete
//
//  Created by Arpit on 30/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "ViewController.h"
#import "DBHandler.h"
#import "tableVC.h"
@interface ViewController ()
{
    DBHandler *db;
}
@end

@implementation ViewController
@synthesize firstname;
@synthesize lastname;
@synthesize mobileno;
@synthesize gender;
- (void)viewDidLoad {
    [super viewDidLoad];
    db=[[DBHandler alloc]init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    firstname.text=@"";
    lastname.text=@"";
    mobileno.text=@"";
    gender.text=@"";
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [[UINavigationBar appearance]setTintColor:[UIColor redColor]];
    [[UINavigationBar appearance]setBarTintColor:[UIColor yellowColor]];
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
-(BOOL)alphabet:(NSString*)string
{
    NSCharacterSet *strCharSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "];//1234567890_"];
    
    strCharSet = [strCharSet invertedSet];
    //And you can then use a string method to find if your string contains anything in the inverted set:
    
    NSRange r = [string rangeOfCharacterFromSet:strCharSet];
    if (r.location != NSNotFound) {
        NSLog(@"the string contains illegal characters");
        return NO;
    }
    else
        return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range   replacementString:(NSString *)string {
    
    if (textField == mobileno)
    {
        NSUInteger lengthOfString = string.length;
        for (NSInteger index = 0; index < lengthOfString; index++) {
            unichar character = [string characterAtIndex:index];
            if (character < 48) return NO; // 48 unichar for 0
            if (character > 57) return NO; // 57 unichar for 9
        }
        // Check for total length
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 10) ? NO : YES;
        
    }
    else
    {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 30) ? NO : YES;
    }
}
-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


- (IBAction)insert:(id)sender {
    
    NSString  *fname=firstname.text;
    NSString *lname=lastname.text;
    NSString *mno=mobileno.text;
    NSString *email=gender.text;
    
    if (fname.length==0 || lname.length==0 || mno.length==0 || email.length==0) {
        UIAlertView *message3 = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Enter Field First"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message3 show];
    }
    else if (![self myMobileNumberValidate:mno])
    {
        NSLog(@"opsssss...");
        UIAlertView *mobileshow = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"only 10 Digit Number Allow"
                                                            delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [mobileshow show];
        
    }
    else if (![self alphabet:fname])
    {
        NSLog(@"opsssss...");
        UIAlertView *latter = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"Name Field Specify only latter Allow"
                                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [latter show];
    }
    else if (![self alphabet:lname])
    {
        NSLog(@"opsssss...");
        UIAlertView *latter = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"Name Field Specify only latter Allow"
                                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [latter show];
    }
    else if (![self NSStringIsValidEmail:email])
    {
        NSLog(@"opsssss...");
        UIAlertView *message3 = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"Wrong Email Address"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message3 show];
    }

    else
    {
    NSString *query1=[NSString stringWithFormat:@"insert into test(firstname,lastname,mobileno,email)values('%@','%@','%@','%@')",fname,lname,mno,email];
    BOOL isinsert=[db insertData:query1];
    if (isinsert) {
        UIAlertView *message1 = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Data Insert Sucessfully"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message1 show];
    }
    else
    {
        UIAlertView *message2 = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Data not insert Sucessfully"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message2 show];

        
    }
        tableVC *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"tableVC"];
        [self.navigationController pushViewController:detail animated:YES];
        
    }
}


- (IBAction)update:(id)sender {
}

- (IBAction)delete:(id)sender {
}
@end
