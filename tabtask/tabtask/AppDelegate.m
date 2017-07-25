//
//  AppDelegate.m
//  tabtask
//
//  Created by Arpit on 03/05/16.
//  Copyright © 2016 Abbacus. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar=tabBarController.tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    UITabBarItem *tabBarItem5 = [tabBar.items objectAtIndex:4];
    
    tabBarItem1.title = @"Collection";
    tabBarItem2.title = @"DatePicker";
    tabBarItem3.title = @"Picker View";
    tabBarItem4.title = @"Map";
    tabBarItem5.title = @"Page View";
    
    [tabBarItem1 setFinishedSelectedImage:[UIImage imageNamed:@"Folders-CD-Folder-icon.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"collect-folder-information.jpg"]];
    [tabBarItem2 setFinishedSelectedImage:[UIImage imageNamed:@"date.jpeg"] withFinishedUnselectedImage:[UIImage imageNamed:@"date1.jpeg"]];
    
    [tabBarItem3 setFinishedSelectedImage:[UIImage imageNamed:@"picker.jpeg"] withFinishedUnselectedImage:[UIImage imageNamed:@"picker12.jpeg"]];
    
    
    
    [tabBarItem4 setFinishedSelectedImage:[UIImage imageNamed:@"map.jpeg"] withFinishedUnselectedImage:[UIImage imageNamed:@"map2.jpeg"]];
    [tabBarItem5 setFinishedSelectedImage:[UIImage imageNamed:@"page.jpeg"] withFinishedUnselectedImage:[UIImage imageNamed:@"page1.jpeg"]];
    return YES;
   
   
    
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
