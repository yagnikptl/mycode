//
//  pickerviewVC.h
//  tabtask
//
//  Created by Arpit on 03/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pickerviewVC : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong, nonatomic)NSArray *dataSourceArray;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerview;

@property (strong, nonatomic) IBOutlet UILabel *pickerlabel;
@end
