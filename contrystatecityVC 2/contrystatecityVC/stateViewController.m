//
//  stateViewController.m
//  contrystatecityVC
//
//  Created by Arpit on 15/04/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "stateViewController.h"
#import "JSONKit.h"
@implementation stateViewController

-(void)viewDidLoad
{

    self.view.opaque = YES;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mytableview];
    state=[[NSArray alloc]init];
    [super viewDidLoad];
    NSError *error;
    NSURL *url = [NSURL URLWithString:@"http://mobileapi.the-timeshare.com/CommonWebService.asmx/getStateList"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"value1" forHTTPHeaderField:@"countryId"];
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
    
    // Parsing the JSON data received from web service into an NSDictionary object
    NSDictionary *JSON =
     [NSJSONSerialization JSONObjectWithData: data
     options: NSJSONReadingMutableContainers
     error: &error];
    
    NSLog(@"%@",JSON);
   /* //JSONDecoder *jsonKitDecoder = [JSONDecoder decoderWithParseOptions:JKParseOptionValidFlags];
    JSONDecoder *jsonKitDecoder = [JSONDecoder decoderWithParseOptions:JKParseOptionValidFlags];
    
    NSDictionary *dictionary;
    if ([[jsonKitDecoder objectWithData:data] valueForKey:@"d"]) {
        
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        dictionary = [[[jsonKitDecoder objectWithData:data] valueForKey:@"d"] objectFromJSONString];
        NSLog(@"%@",dictionary);
        
        //dictionary = [JSON dictionaryByReplacingNullsWithBlanks];
    }
    state=[dictionary objectForKey:@"result"];*/
    //[self.mytableview reloadData];
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
@end
