//
//  editVC.h
//  insertupdatedelete
//
//  Created by Arpit on 30/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface editVC : UIViewController
@property (strong, nonatomic)NSString *tempname;
@property (strong, nonatomic) IBOutlet UITextField *fname;
@property (strong, nonatomic) IBOutlet UITextField *lname;

@property (strong, nonatomic) IBOutlet UITextField *mno;


@property (strong, nonatomic) IBOutlet UITextField *gen;
- (IBAction)update:(id)sender;
- (IBAction)cancelbutton:(id)sender;

@end
