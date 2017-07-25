//
//  CollectionVC.h
//  tabtask
//
//  Created by Arpit on 03/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionVC : UIViewController
{
    NSArray *Photos;
}
@property (strong, nonatomic) IBOutlet UICollectionView *collectionview;

@property (strong, nonatomic)UIImage *image;
@end
