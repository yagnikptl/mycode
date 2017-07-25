//
//  customcellvc.h
//  formdetail
//
//  Created by Arpit on 01/06/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
@interface customcellvc : UITableViewCell<EDStarRatingProtocol>
@property (strong, nonatomic) IBOutlet UILabel *nametextfield;
@property (strong, nonatomic) IBOutlet UILabel *citytextfield;
@property (strong, nonatomic) IBOutlet UILabel *statetextfield;
@property (strong, nonatomic) IBOutlet UILabel *countrytextfield;
@property (strong, nonatomic) IBOutlet UILabel *gendertextfield;
@property (strong, nonatomic) IBOutlet UIImageView *imageview;
@property (strong, nonatomic) IBOutlet UILabel *ratetextfield;
@property (weak, nonatomic) IBOutlet EDStarRating *starRating;
@property (strong,nonatomic) NSArray *colors;
@property (strong, nonatomic) IBOutlet UIView *myview;
@end
