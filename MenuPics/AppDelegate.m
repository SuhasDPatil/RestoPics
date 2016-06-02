//
//  AppDelegate.m
//  MenuPics
//
//  Created by rac on 26/08/15.
//  Copyright (c) 2015 Suhas Patil. All rights reserved.
//

#import "AppDelegate.h"

#import "SearchViewController.h"
#import "DealsListViewController.h"
#import "ProfileViewController.h"
#import "LoginViewController.h"
#import "FavouriteRestaurantViewController.h"


#import <FBSDKCoreKit/FBSDKCoreKit.h>





@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
//    

    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    //  [userDefaults setObject:[dict_res objectForKey:DATA] forKey:@"MyData"];
//    
//    
//    NSString *username=[userDefaults valueForKey:@"EmailID"];
//    
//    NSString *password=[userDefaults valueForKey:@"Password"];
//    
//    NSString *active=[userDefaults valueForKey:@"Active"];
//    
//    
//
//    
//
    _userid=[NSUserDefaults standardUserDefaults];
    
    [_userid setObject:@"0" forKey:@"UserID"];

    
//

    UITabBarController * tab=[[UITabBarController alloc]init];
   
    SearchViewController * svc=[[SearchViewController alloc]init];
    svc.tabBarItem.title=@"Search";
    svc.tabBarItem.image = [UIImage imageNamed:@"search_gray"];
    
    UINavigationController *navS=[[UINavigationController alloc]initWithRootViewController:svc];
    
    DealsListViewController * dvc=[[DealsListViewController alloc]init];
    dvc.tabBarItem.title=@"Deals";
    dvc.tabBarItem.image = [UIImage imageNamed:@"deals_green"];
    UINavigationController *navD=[[UINavigationController alloc]initWithRootViewController:dvc];
    
//    FavouriteRestaurantViewController *frvc=[[FavouriteRestaurantViewController alloc]init];
//    frvc.tabBarItem.title=@"My Favorites";
//    frvc.tabBarItem.image=[UIImage imageNamed:@"fav_gray"];
//    UINavigationController *navF=[[UINavigationController alloc]initWithRootViewController:frvc];
//    
    
    
    ProfileViewController *pvc=[[ProfileViewController alloc]init];
    pvc.tabBarItem.title=@"Profile";
    pvc.tabBarItem.image = [UIImage imageNamed:@"profile_gray"];
    UINavigationController *navP=[[UINavigationController alloc]initWithRootViewController:pvc];
    
    
    tab.viewControllers = @[navS,navD,navP];

    
//     LoginViewController *lvc=[[LoginViewController alloc]init];
//    lvc.tabBarItem.title=@"Profile";
//    lvc.tabBarItem.image = [UIImage imageNamed:@"profile_gray"];
//    UINavigationController *navl=[[UINavigationController alloc]initWithRootViewController:lvc];
//    
    

    tab.tabBar.backgroundColor = [UIColor whiteColor];
    
    [tab.tabBar setBackgroundImage:[UIImage imageNamed:@"tab_orange2"]];
    [tab.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tab_green2"]];
    
    [tab.tabBar setSelectedImageTintColor:[UIColor colorWithRed:11.0f/255 green:137.0f/255 blue:1.0f/255 alpha:1.0f]];
    
    [NSThread sleepForTimeInterval:2.0];
        
    self.window.rootViewController=tab;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
//    
//    [[MPUser activeUser] setLoggedIn:true];
//    [[MPUser activeUser] loggedIn];
//
//    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
//    [[MPUser activeUser] setLoggedIn:true];
//    [[MPUser activeUser] loggedIn];
//
  
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
//    [[MPUser activeUser] setLoggedIn:true];
//    [[MPUser activeUser] loggedIn];
//
    
    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
   
    //
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
