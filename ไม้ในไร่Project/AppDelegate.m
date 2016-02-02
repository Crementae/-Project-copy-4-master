//
//  AppDelegate.m
//  ไม้ในไร่Project
//
//  Created by Adisorn Chatnaratanakun on 3/12/2558 BE.
//  Copyright (c) 2558 Adisorn Chatnartanakun. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import "ARObject.h"
#import "ViewController.h"



@interface AppDelegate ()

@end

@implementation AppDelegate

void uncaughtExceptionHandle(NSException * exception){
    //NSLog(@"CLASH: %@",exception);
    //NSLog(@"STACK TRACE: %@",[exception callStackSymbols]);
    //NSLog(@"Stack trace: %@",[NSThread callStackSymbols]);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

 
      NSSetUncaughtExceptionHandler(&uncaughtExceptionHandle);
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"AIzaSyBxtrf631Z8DkD-4oT08HKY658ST4K8Q8g"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    [self.window.rootViewController dismissViewControllerAnimated:NO completion:nil];
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
