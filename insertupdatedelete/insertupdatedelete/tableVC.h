//
//  tableVC.h
//  insertupdatedelete
//
//  Created by Arpit on 30/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableVC : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)addbutton:(id)sender;

@end
