//
//  CollectionVC.m
//  tabtask
//
//  Created by Arpit on 03/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "CollectionVC.h"
#import "customcollectionCollectionViewCell.h"
@interface CollectionVC ()

@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
      Photos = [NSArray arrayWithObjects:@"download1.jpeg", @"download2.jpeg", @"download3.jpeg", @"download4.jpeg", @"download5.jpeg", @"download6.jpeg", @"download7.jpeg", @"download8.jpeg",  @"download9.jpeg",nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return Photos.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    customcollectionCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"Cell"
                                    forIndexPath:indexPath];
    
    UIImage *image;
    long row = [indexPath row];
    
    image = [UIImage imageNamed:Photos[row]];
    
    myCell.imageview.image = image;
    
    return myCell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
