//
//  ViewController.m
//  contrystatecityVC
//
//  Created by Arpit on 11/04/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "ViewController.h"
#import "tabledataVC.h"
#import "JSONKit.h"
#import "CustomURLConnection.h"
@interface ViewController ()<tableVCDelegate>
@end

@implementation ViewController
@synthesize tempname;
@synthesize dislabel;

- (void)viewDidLoad {
    
    //[self touchesBegan:countryTextField withEvent:UIEventSubtypeRemoteControlBeginSeekingForward];
    // Do any additional setup after loading the view, typically from a nib.
    country=[[NSArray alloc]init];
       [super viewDidLoad];
}
-(void)selectcountryName:(NSString *)strcountryName
{
    [btnCountryName setTitle:strcountryName forState:UIControlStateNormal];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) receiveTestNotification:(NSNotification *) notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSLog(@"userInfo : %@",userInfo);
    [btnCountryName setTitle:[userInfo valueForKey:@"countryName"] forState:UIControlStateNormal];
}

- (IBAction)countryButton:(id)sender {
   
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    tabledataVC *myvc=(tabledataVC *)[storyboard instantiateViewControllerWithIdentifier:@"tabledataVC"];
    myvc.delegate=self;
    myvc.strScreen=@"Select Country Name";
    [self presentViewController:myvc animated:YES completion:nil ];
    
    

}
- (IBAction)stateButton:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    tabledataVC *myvc=(tabledataVC *)[storyboard instantiateViewControllerWithIdentifier:@"tabledataVC"];
    myvc.delegate=self;
    myvc.strScreen=@"Select State Name";
    [self presentViewController:myvc animated:YES completion:nil ];
    
}

- (IBAction)cityButton:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    tabledataVC *myvc=(tabledataVC *)[storyboard instantiateViewControllerWithIdentifier:@"tabledataVC"];
    myvc.delegate=self;
    myvc.strScreen=@"Select City Name";
    [self presentViewController:myvc animated:YES completion:nil ];
}

@end
