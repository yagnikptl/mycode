//
//  tablevc.h
//  formdetail
//
//  Created by Arpit on 01/06/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBHandler.h"

@interface tablevc : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    DBHandler *db1;
    NSMutableArray *tbldata;
    
}

@property (strong, nonatomic) IBOutlet UIView *myview;

@property (strong, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)addnew:(id)sender;
@end
