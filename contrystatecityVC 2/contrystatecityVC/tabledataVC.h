//
//  tabledataVC.h
//  contrystatecityVC
//
//  Created by Arpit on 11/04/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomURLConnection.h"
@protocol tableVCDelegate <NSObject>

    -(void)selectcountryName:(NSString *)strcountryName;
    -(void)selectcountryId:(NSString *)strcountryId;

@end
@interface tabledataVC : UIViewController<UISearchDisplayDelegate,UISearchBarDelegate,CustomURLConnectionDelegate>
{
    NSArray *country;
    NSArray *state;
   // NSArray *recipes;
    NSArray *searchresult;
    
    id<tableVCDelegate>delegate;
}

//@property (strong, nonatomic)NSArray *country;
@property (strong, nonatomic)id<tableVCDelegate>delegate;
@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) IBOutlet UISearchBar *searchtext;
@property (strong, nonatomic)NSString *strScreen;

//@property (strong, nonatomic) NSFetchRequest *searchFetchRequest;


@end
