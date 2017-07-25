//
//  tableVC.m
//  insertupdatedelete
//
//  Created by Arpit on 30/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "tableVC.h"
#import "DBHandler.h"
#import "editVC.h"
#import "ViewController.h"
@interface tableVC ()
{
    DBHandler *db1;
    NSMutableArray *arr;
}
@end

@implementation tableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    db1=[[DBHandler alloc]init];
    arr=[[NSMutableArray alloc]init];
    NSString *query2=[NSString stringWithFormat:@"select * from test"];
    arr=[db1 getData:query2];
    NSLog(@"%@",arr);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arr count];    //count number of row from counting array hear cataGorry is An Array
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"idCellRecord";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewStylePlain reuseIdentifier:CellIdentifier];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.tag=indexPath.row;
        [button addTarget:self
                   action:@selector(aMethod:) forControlEvents:UIControlEventTouchDown];
        [button setTitle:@"Delete" forState:UIControlStateNormal];
        button.frame = CGRectMake(180.0, 5.0, 80.0, 20.0);
        button.tintColor=[UIColor blueColor];
        //button.backgroundColor=[UIColor grayColor];
        
        [cell.contentView addSubview:button];
    }
   
       
        cell.textLabel.text = [[arr objectAtIndex:indexPath.row]objectForKey:@"firstname"];
    cell.backgroundColor=[UIColor lightGrayColor];
    return cell;
}
-(void)aMethod:(UIButton *)sender
{
    NSInteger tmp = sender.tag;
    
    
    NSIndexPath *indexpath=[self.tableview indexPathForSelectedRow];
    UITableViewCell *cell= [self.tableview cellForRowAtIndexPath:indexpath];
    NSString *cellText = [[arr objectAtIndex:tmp] objectForKey:@"firstname"];
    // NSString *celltext = cell.textLabel.text;
    //NSLog(@"%@",celltext);
    NSString *query3=[NSString stringWithFormat:@"delete from test where firstname='%@'",cellText];
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
    
    tableVC *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"tableVC"];
    [self.navigationController pushViewController:detail animated:NO];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    NSString *celltext=cell.textLabel.text;
    editVC *newvc=[self.storyboard instantiateViewControllerWithIdentifier:@"editVC"];
    newvc.tempname=celltext;
    [self.navigationController pushViewController:newvc animated:YES];
}

- (IBAction)addbutton:(id)sender {
    ViewController *vc=[self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
