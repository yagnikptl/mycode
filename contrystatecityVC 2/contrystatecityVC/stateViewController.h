//
//  stateViewController.h
//  contrystatecityVC
//
//  Created by Arpit on 15/04/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface stateViewController : UIViewController
{
    NSArray *state;
}
@property (strong, nonatomic) IBOutlet UITableView *mytableview;
@property (strong, nonatomic) IBOutlet UISearchBar *searchbar;

@end
