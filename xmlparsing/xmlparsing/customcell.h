//
//  customcell.h
//  xmlparsing
//
//  Created by Arpit on 20/04/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customcell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbltitle;
@property (strong, nonatomic) IBOutlet UILabel *lblartist;
@property (strong, nonatomic) IBOutlet UILabel *lblcountry;
@property (strong, nonatomic) IBOutlet UILabel *lblcompany;
@property (strong, nonatomic) IBOutlet UILabel *lblprice;
@property (strong, nonatomic) IBOutlet UILabel *lblyear;

@end
