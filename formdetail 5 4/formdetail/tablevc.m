//
//  tablevc.m
//  formdetail
//
//  Created by Arpit on 01/06/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "tablevc.h"
#import "customcellvc.h"
#import "editVc.h"
#import "ViewController.h"

@interface tablevc ()
{
    float rates;
}
@end
@implementation tablevc

 NSMutableArray *arrayOfImages;

- (void)viewDidLoad {
    [super viewDidLoad];
    db1=[[DBHandler alloc]init];
    tbldata=[[NSMutableArray alloc]init];
   
    arrayOfImages=[[NSMutableArray alloc]init];
    self.navigationItem.hidesBackButton = YES;
//   NSError *error = nil;
//     NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
//    NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath: stringPath  error:&error];
//    
//    for(int i=0;i<[filePathsArray count];i++)
//    {
//        NSString *strFilePath = [filePathsArray objectAtIndex:i];
//        if ([[strFilePath pathExtension] isEqualToString:@"jpg"] || [[strFilePath pathExtension] isEqualToString:@"png"] || [[strFilePath pathExtension] isEqualToString:@"PNG"])
//        {
//            NSString *imagePath = [[stringPath stringByAppendingString:@"/"] stringByAppendingString:strFilePath];
//            NSData *data = [NSData dataWithContentsOfFile:imagePath];
//            if(data)
//            {
//                UIImage *image = [UIImage imageWithData:data];
//                [arrayOfImages addObject:image];
//            }
//        }
//    }

    NSString *query2=[NSString stringWithFormat:@"select * from formdetail"];
    tbldata=[db1 getData:query2];
    [self.tableview reloadData];
    NSLog(@"%@",tbldata);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tbldata count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"idCellRecord";
    customcellvc *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure Cell
    if (cell==nil) {
        cell = [[customcellvc alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    else
    {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag=indexPath.row;
        [button addTarget:self
                   action:@selector(aMethod:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@"Delete" forState:UIControlStateNormal];
        button.frame = CGRectMake(200, 5.0, 80.0, 20.0);
        button.tintColor=[UIColor blueColor];
        button.backgroundColor=[UIColor redColor];
        
        [cell.contentView addSubview:button];
        cell.nametextfield.text=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"name"];
        NSString *city=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"city"];
         NSString *state=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"state"];
        NSString *country=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"country"];
        NSArray *myStrings = [[NSArray alloc] initWithObjects:city, state, country, nil];
        NSString *joinedString = [myStrings componentsJoinedByString:@","];
        cell.citytextfield.text=joinedString;
        cell.gendertextfield.text=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"gender"];
        NSString *myimage=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"photos"];
       
        //        UIGraphicsBeginImageContext(CGSizeMake(cell.imageview.image.size.width/4, cell.imageview.image.size.height/4));
//                                            [cell.imageview.image drawInRect:CGRectMake(0,0,cell.imageview.image.size.width/4, cell.imageview.image.size.height/4)];
//                                            UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//                                            UIGraphicsEndImageContext();
//                                            NSData *smallData = UIImagePNGRepresentation(newImage);
        //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,     NSUserDomainMask, YES);
//        NSString *documentsDirectory = [paths objectAtIndex:0];
//        NSString *name=@"savedImage";
//        NSString *myUniqueName = [NSString stringWithFormat:@"%@-%lu.png", name, (unsigned long)([[NSDate date] timeIntervalSince1970]*10.0)];
//        NSString *savedImagePathss = [documentsDirectory stringByAppendingPathComponent:myUniqueName];
        //NSData *data1 = [NSData dataWithContentsOfURL:savedImagePathss];
        NSError *error = nil;
        NSString *stringPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
        NSArray *filePathsArray = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath: stringPath  error:&error];
       
            NSString *imagePath = [[stringPath stringByAppendingString:@"/"] stringByAppendingString:myimage];
            NSData *data = [NSData dataWithContentsOfFile:imagePath];
            if(data)
            {
                cell.imageview.image= [UIImage imageWithData:data];
               // [arrayOfImages addObject:image];
            }
        


//        if([arrayOfImages count] > 0 && [arrayOfImages count] > indexPath.row){
//            
//            [cell.imageview setImage:[arrayOfImages objectAtIndex:indexPath.row]];
//            
//        }
//        else{
//            
//            //Array is empty,handle as you needed
//            
//        }
        
        
//        NSString *name=@"savedImage";
//        NSString *fileName = [NSString stringWithFormat:@"%@-%lu.png", name, (unsigned long)([[NSDate date] timeIntervalSince1970]*10.0)];
//
//                              NSArray *arrayPaths =
//                              NSSearchPathForDirectoriesInDomains(
//                                                                  NSDocumentDirectory,
//                                                                  NSUserDomainMask,
//                                                                  YES);
//                              NSString *path = [arrayPaths objectAtIndex:0];
//                              NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
//                              
//                              UIImage *image1=[UIImage imageWithContentsOfFile:pdfFileName];
//                              cell.imageView.image=image1;
        NSString *rate=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"rating"];
        rates=[rate floatValue];
               cell.ratetextfield.text=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"rating"];
       // cell.backgroundColor=[UIColor grayColor];
        cell.self.colors = @[ [UIColor colorWithRed:0.11f green:0.38f blue:0.94f alpha:1.0f], [UIColor colorWithRed:1.0f green:0.22f blue:0.22f alpha:1.0f], [UIColor colorWithRed:0.27f green:0.85f blue:0.46f alpha:1.0f], [UIColor colorWithRed:0.35f green:0.35f blue:0.81f alpha:1.0f]];
        // Setup control using iOS7 tint Color
       cell.starRating.backgroundColor  = [UIColor whiteColor];
         cell.starRating.starImage = [[UIImage imageNamed:@"star-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
         cell.starRating.starHighlightedImage = [[UIImage imageNamed:@"star-highlighted-template"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        cell.starRating.maxRating = 5.0;
         cell.starRating.delegate = self;
         cell.starRating.horizontalMargin = 15.0;
         cell.starRating.editable=YES;
         cell.starRating.rating= rates;
         cell.starRating.displayMode=EDStarRatingDisplayHalf;
        [ cell.starRating  setNeedsDisplay];
         cell.starRating.tintColor = cell.self.colors[0];
        cell.starRating.userInteractionEnabled=NO;
        //[self starsSelectionChanged:_starRating rating:2.5];
        
     
    }
        
   
    
    return cell;
}
-(void)aMethod:(UIButton *)sender
{
    NSInteger tmp = sender.tag;
    
    
    NSIndexPath *indexpath=[self.tableview indexPathForSelectedRow];
    UITableViewCell *cell= [self.tableview cellForRowAtIndexPath:indexpath];
    NSString *cellText = [[tbldata objectAtIndex:tmp] objectForKey:@"name"];
    // NSString *celltext = cell.textLabel.text;
    //NSLog(@"%@",celltext);
    NSString *query3=[NSString stringWithFormat:@"delete from formdetail where name='%@'",cellText];
    NSLog(@"%@",query3);
    
    BOOL isdeleted=[db1 DeleteRecord:query3];
    
    if (isdeleted) {
        UIAlertView *message1 = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Data Delete Sucessfully"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message1 show];
        
    }
    else
    {
        UIAlertView *message2 = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Data not Deleted"
                                                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [message2 show];
        
    }
    
    tablevc *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"tablevc"];
    [self.navigationController pushViewController:detail animated:NO];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    NSString *user=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"name"];
    NSString *dates=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"email"];
    NSString *comments=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"phone"];
    NSString *address=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"address"];
     NSString *gender=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"gender"];
    NSString *hobby=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"hobbies"];
     NSString *birth=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"birthdate"];
     NSString *country=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"country"];
     NSString *state=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"state"];
     NSString *city=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"city"];
     NSString *photo=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"photos"];
     NSString *rate=[[tbldata objectAtIndex:indexPath.row]objectForKey:@"rating"];
    //NSLog(@"%@",user);
    
    //NSData *data1 = [NSData dataWithContentsOfURL:url1];
    // NSString *pimage= [[UIImage alloc]initWithData:data1];
    
    
   editVc *newvc=[self.storyboard instantiateViewControllerWithIdentifier:@"editVc"];
   
    newvc.names=user;
    newvc.email=dates;
    newvc.phone=comments;
    newvc.addresss=address;
    newvc.gender=gender;
    newvc.hobby=hobby;
     newvc.birthdata=birth;
     newvc.country1=country;
     newvc.state1=state;
    newvc.city1=city;
    newvc.image=photo;
     newvc.rate=rate;
    
    
   [self.navigationController pushViewController:newvc animated:NO];
    
}

- (IBAction)addnew:(id)sender {
      ViewController *newvc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
     [self.navigationController pushViewController:newvc animated:NO];
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
}
@end
