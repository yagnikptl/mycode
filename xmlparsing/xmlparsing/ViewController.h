//
//  ViewController.h
//  xmlparsing
//
//  Created by Arpit on 20/04/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
NSMutableDictionary *dictData;
 NSMutableArray *marrXMLData;
 NSMutableString *mstrXMLString;
 NSMutableDictionary *mdictXMLPart;
}

@end

