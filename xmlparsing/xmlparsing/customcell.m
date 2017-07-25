//
//  customcell.m
//  xmlparsing
//
//  Created by Arpit on 20/04/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "customcell.h"

@implementation customcell
@synthesize lbltitle,lblartist,lblcountry,lblcompany,lblprice,lblyear;
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
