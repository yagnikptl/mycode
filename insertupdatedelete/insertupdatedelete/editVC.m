//
//  editVC.m
//  insertupdatedelete
//
//  Created by Arpit on 30/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "editVC.h"
#import "DBHandler.h"
#import "tableVC.h"
@interface editVC ()
{
    DBHandler *db2;
    NSMutableArray *arr1;
}
@end
@implementation editVC

- (void)viewDidLoad {
    [super viewDidLoad];
    db2=[[DBHandler alloc]init];
    arr1=[[NSMutableArray alloc]init];
    NSString *query3=[NSString stringWithFormat:@"select * from test where firstname='%@'",_tempname];
    arr1=[db2 GetAllData:query3];
    NSLog(@"%@",arr1);
    
    NSString *first=[[arr1 objectAtIndex:0]objectForKey:@"firstname"];
    NSString *last=[[arr1 objectAtIndex:0]objectForKey:@"lastname"];
    NSString *mno=[[arr1 objectAtIndex:0]objectForKey:@"mobileno"];
    NSString *email=[[arr1 objectAtIndex:0]objectForKey:@"email"];
    
    
    _fname.text=first;
    _lname.text=last;
    _mno.text=mno;
    _gen.text=email;
    
    
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
    
    if (textField == _mno)
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

- (IBAction)update:(id)sender {
    NSString *fname1=_fname.text;
    NSString *lname1=_lname.text;
    NSString *mno1=_mno.text;
    NSString *email=_gen.text;
    
    NSString *query5=[NSString stringWithFormat:@"select * from test where email='%@'",email];
    BOOL isexist=[db2 getemailID:query5];
    if (fname1.length==0 || lname1.length==0 || mno1.length==0 || email.length==0) {
        UIAlertView *message3 = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Enter Field First"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message3 show];
    }
    else if (![self myMobileNumberValidate:mno1])
    {
        NSLog(@"opsssss...");
        UIAlertView *mobileshow = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"only 10 Digit Number Allow"
                                                            delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [mobileshow show];
        
    }
    else if (![self alphabet:fname1])
    {
        NSLog(@"opsssss...");
        UIAlertView *latter = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"Name Field Specify only latter Allow"
                                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [latter show];
    }
    else if (![self alphabet:lname1])
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
    else if (isexist)
    {
        NSLog(@"opsssss...");
        UIAlertView *message3 = [[UIAlertView alloc] initWithTitle:@"opssssss.." message:@"Email Already Exist "
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message3 show];
    }

    else
    {
       
    
    
    NSString *query4=[NSString stringWithFormat:@"update test set firstname='%@',lastname='%@',mobileno='%@',email='%@' where firstname='%@'",fname1,lname1,mno1,email,_tempname];
    BOOL isupdate=[db2 upDate:query4];
    if (isupdate) {
        UIAlertView *message1 = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Data Update Sucessfully"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message1 show];
        
    }
    else
    {
        UIAlertView *message2 = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Data not update Sucessfully"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message2 show];

        
    }
    tableVC *nvc=[self.storyboard instantiateViewControllerWithIdentifier:@"tableVC"];
    
    [self.navigationController pushViewController:nvc animated:YES];
    }
}

- (IBAction)cancelbutton:(id)sender {
    tableVC *nvc=[self.storyboard instantiateViewControllerWithIdentifier:@"tableVC"];
    
    [self.navigationController pushViewController:nvc animated:YES];
    
}
@end
