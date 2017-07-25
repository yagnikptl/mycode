//
//  ViewController.m
//  xmlparsing
//
//  Created by Arpit on 20/04/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "ViewController.h"
#import "customcell.h"
@interface ViewController ()

@end
NSMutableArray *data;
NSMutableString *currentElementValue;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //data=[[NSMutableArray alloc]init];
    [self startParsing];
    // Do any additional setup after loading the view, typically from a nib.
}

//XML parsing Methods

- (void)startParsing
{
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.w3schools.com/xml/cd_catalog.xml"]];
    [xmlparser setDelegate:self];
    [xmlparser parse];
}
-(void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"startdoc");
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    NSLog(@"%@",elementName);
   
    //data=elementName;
    if ([elementName isEqualToString:@"CATALOG"]) {
        marrXMLData = [[NSMutableArray alloc] init];
    }
    if ([elementName isEqualToString:@"CD"]) {
        mdictXMLPart = [[NSMutableDictionary alloc] init];
        
    }
   
    mstrXMLString=[[NSMutableString alloc]init];
    
    
}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    //NSLog(@"found character");
    if (!mstrXMLString) {
        mstrXMLString = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [mstrXMLString appendString:string];
    }
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
   // NSLog(@"didEndDocument");
    //marrXMLData=elementName;
    if ([elementName isEqualToString:@"TITLE"] )
    {
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
        
        //NSLog(@"%@",marrXMLData);
    }
    else if ([elementName isEqualToString:@"ARTIST"] )
    {
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
        
        //NSLog(@"%@",marrXMLData);
    }
    else if ([elementName isEqualToString:@"COUNTRY"] )
    {
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
        
        //NSLog(@"%@",marrXMLData);
    }
    else if ([elementName isEqualToString:@"COMPANY"] )
    {
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
        
        //NSLog(@"%@",marrXMLData);
    }
    else if ([elementName isEqualToString:@"PRICE"] )
    {
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
        
        //NSLog(@"%@",marrXMLData);
    }
    else if ([elementName isEqualToString:@"YEAR"] )
    {
        [mdictXMLPart setObject:mstrXMLString forKey:elementName];
        
        //NSLog(@"%@",marrXMLData);
    }
    
    else if ([elementName isEqualToString:@"CD"]) {
      [marrXMLData addObject:mdictXMLPart];
        NSLog(@"%@",marrXMLData);
       
    }
  
      mstrXMLString = nil;
   //
   
    
    
}

-(void)parserDidEndStartDocument:(NSXMLParser *)parser
{
    NSLog(@"end document");
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//uitableview Method with custom cell

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [marrXMLData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"idCellRecord";
     customcell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell = [[customcell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    else
    {
        NSLog(@"%@",marrXMLData);
        cell.lbltitle.text=[[marrXMLData objectAtIndex:indexPath.row]objectForKey:@"TITLE"];
        cell.lblartist.text=[[marrXMLData objectAtIndex:indexPath.row]objectForKey:@"ARTIST"];
        cell.lblcountry.text=[[marrXMLData objectAtIndex:indexPath.row]objectForKey:@"COUNTRY"];
        cell.lblcompany.text=[[marrXMLData objectAtIndex:indexPath.row]objectForKey:@"COMPANY"];
        cell.lblprice.text=[[marrXMLData objectAtIndex:indexPath.row]objectForKey:@"PRICE"];
        cell.lblyear.text=[[marrXMLData objectAtIndex:indexPath.row]objectForKey:@"YEAR"];
    }
    return cell;
}
@end
