//
//  tabledataVC.m
//  contrystatecityVC
//
//  Created by Arpit on 11/04/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "tabledataVC.h"
#import "JSONKit.h"
#import "ViewController.h"

//NSArray *arrcountry;
NSArray *cname;
UILabel *_label;
NSArray *tbldata;
NSString *name;
NSArray *name1;
NSDictionary *dictionary;
NSString *strcountryname;
NSString *strstatename;
@implementation tabledataVC
@synthesize searchtext;
@synthesize delegate;
- (void)viewDidLoad {
    //tbldata=[[NSMutableArray alloc]init];
    
   // UINavigationBar *navBar = [[ UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    //navBar.topItem.title = @"tableVIew";
    //[self.view addSubview:navBar];
    [super viewDidLoad];
    searchresult=[[NSArray alloc]init];
    country=[[NSArray alloc]init];
    state=[[NSArray alloc]init];
    //country1=[[NSArray alloc]init];
    self.view.opaque = YES;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableview];
   /* [[CustomURLConnection alloc]initWithURLByPost:@"http://mobileapi.the-timeshare.com/CommonWebService.asmx/getCountryList" PostString:@"" withMethod:@"GET"withDelegate:self isPostJson:NO withTag:1 withLoader:YES];
    [strcountryname respondsToSelector:@selector(connectionDidFinishLoading:)];*/
    //NSDictionary *dic=[s]
    
    //country=[dictionary objectForKey:@"result"];
    //NSLog(@"%@",country);
    
    /*
    NSError *error;
    NSURL *url = [NSURL URLWithString:@"http://mobileapi.the-timeshare.com/CommonWebService.asmx/getCountryList"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse: &response error:&error];
   
       if (!data)
    {
        NSLog(@"Download Error: %@", error.localizedDescription);
        UIAlertView *alert =
        [[UIAlertView alloc]initWithTitle:@"Error"
                                  message:[NSString stringWithFormat:@"Error : %@",error.localizedDescription]
                                 delegate:self
                        cancelButtonTitle:@"Ok"
                        otherButtonTitles:nil];
        [alert show];
        //return nil;
    }
     */
    
    // Parsing the JSON data received from web service into an NSDictionary object
    /*NSDictionary *JSON =
    [NSJSONSerialization JSONObjectWithData: data
                                    options: NSJSONReadingMutableContainers
                                      error: &error];
   */
    //JSONDecoder *jsonKitDecoder = [JSONDecoder decoderWithParseOptions:JKParseOptionValidFlags];
    /*JSONDecoder *jsonKitDecoder = [JSONDecoder decoderWithParseOptions:JKParseOptionValidFlags];
    
    NSDictionary *dictionary;
    if ([[jsonKitDecoder objectWithData:data] valueForKey:@"d"]) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        dictionary = [[[jsonKitDecoder objectWithData:data] valueForKey:@"d"] objectFromJSONString];
        NSLog(@"%@",dictionary);
        
        //dictionary = [JSON dictionaryByReplacingNullsWithBlanks];
    }
    country=[dictionary objectForKey:@"result"];
    name=[country valueForKey:@"countryId"];
    name1=[country valueForKey:@"countryName"];
    NSLog(@"%@",name1);
   
    /*
    NSDictionary *dictionary;
    if ([[jsonKitDecoder objectWithData:JSON] valueForKey:@"d"]) {
        
        NSString *str = [[NSString alloc] initWithData: encoding:NSUTF8StringEncoding];
        
        dictionary = [[[jsonKitDecoder objectWithData:receivedData] valueForKey:@"d"] objectFromJSONString];
        dictionary = [dictionary dictionaryByReplacingNullsWithBlanks];
    }
    */
       //[self.tableview reloadData];
     // NSDictionary *dict=[[JSON valueForKeyPath:@"result"][0]objectForKey:@"countryName"];
   
 }
-(void)requestFinished:(CustomURLConnection *)request withResult:(NSDictionary *)dictionary withTag:(NSInteger)apiTag
{
    if(apiTag==1)
    {
        NSLog(@"%@",dictionary);
        country=[dictionary objectForKey:@"result"];
        NSLog(@"%@",country);
        //name=[dictionary valueForKey:@"countryId"];
        
        [self.tableview reloadData];
    }
    else if (apiTag==2)
    {
        NSLog(@"%@",dictionary);
        state=[dictionary objectForKey:@"result"];
        NSLog(@"%@",state);
        [self.tableview reloadData];
        //[self.tableview reloadData];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    if([self.strScreen isEqualToString:@"Select Country Name"])
    {
        [self getcountry];
    }
    else if ([self.strScreen isEqualToString:@"Select State Name"])
    {
        [self getstate];
    }
    else if ([self.strScreen isEqualToString:@"Select City Name"])
    {
        [self getcity];
    }
}
-(void)getcountry
{
    [[CustomURLConnection alloc]initWithURLByPost:@"http://mobileapi.the-timeshare.com/CommonWebService.asmx/getCountryList" PostString:@"" withMethod:@"GET"withDelegate:self isPostJson:NO withTag:1 withLoader:YES];
    //[strcountryname respondsToSelector:@selector(connectionDidFinishLoading:)];
}

-(void)getstate
{
    NSDictionary *dic=[NSDictionary dictionaryWithObject:@"3" forKey:@"countryId"];
    NSString *strpost=[dic JSONString];
    NSLog(@"%@",strpost);
    [[CustomURLConnection alloc]initWithURLByPost:@"http://mobileapi.the-timeshare.com/CommonWebService.asmx/getStateList"  PostString:strpost withMethod:@"POST" withDelegate:self isPostJson:YES withTag:2 withLoader:YES];
   // [strstatename respondsToSelector:@selector(connectionDidFinishLoading:)];
}

-(void)getcity
{
    [[CustomURLConnection alloc]initWithURLByPost:@" http://mobileapi.the-timeshare.com/CommonWebService.asmx/getCityList"  PostString:@"stateId" withMethod:@"POST" withDelegate:self isPostJson:YES withTag:2 withLoader:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchresult count];
        
    } else {
        return [country count];
    }
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    //return [country count];
    //return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"idCellRecord";
    static NSString *CellIdentifier1 = @"idCellRecord1";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    if (cell) {
         cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text = [[country objectAtIndex:indexPath.row]objectForKey:@"countryName"];
    }
    else if (cell1)
    {
         cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
        cell.textLabel.text = [[state objectAtIndex:indexPath.row]objectForKey:@"stateName"];
    }
    else
    {
        NSLog(@"null");
    }
    
    //cell.nameLabel.text = recipe;
    //cell.thumbnailImageView.image = [UIImage imageNamed:recipe.image];
   // NSString *cname=[[country objectAtIndex:indexPath.row]objectForKey:@"countryName"];
    //cell.textLabel.text=cname;
    
     //cell.textLabel.text = [[country objectAtIndex:indexPath.row]objectForKey:@"countryName"];
     //cell.textLabel.text = [[country objectAtIndex:indexPath.row]objectForKey:@"stateName"];
   
    if(tableView == self.searchDisplayController.searchResultsTableView){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.text=[[searchresult objectAtIndex:indexPath.row] valueForKey:@"countryName"];
       cell.textLabel.text=[[searchresult objectAtIndex:indexPath.row] valueForKey:@"stateName"];
    }
    else
    {
        
    }
    
    //cell.tag=indexPath.row;
    //NSLog(@"%ld",(long)cell.tag);
    
    // return cell;
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    NSString *celltext=cell.textLabel.text;
   // NSString *celltext1=cell.textLabel.text;
   NSString *cellText1 = [[country objectAtIndex:indexPath.row] objectForKey:@"countryId"];
    NSLog(@"%@",cellText1);
    //[delegate selectcountryId:cellText1];
    [delegate selectcountryName:celltext];
   
       NSLog(@"%@",celltext);
    [self back];
    
}


-(void)back
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"countryName contains[c] %@", searchText];
    searchresult = [country filteredArrayUsingPredicate:resultPredicate];
}
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    [self.tableview reloadData];
    return YES;
}


@end