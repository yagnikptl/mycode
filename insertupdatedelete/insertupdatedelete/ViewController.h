//
//  ViewController.h
//  insertupdatedelete
//
//  Created by Arpit on 30/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *firstname;
@property (strong, nonatomic) IBOutlet UITextField *lastname;
@property (strong, nonatomic) IBOutlet UITextField *mobileno;
- (IBAction)insert:(id)sender;
- (IBAction)update:(id)sender;
- (IBAction)delete:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *gender;
@end

