 //
//  AppDelegate.m
//  Bitcoin-Reward
//
//  Created by yiqin on 9/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

#import "AppDelegate.h"

#import "BRHTTPRequestOperationManager.h"

#import "Coinbase.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    //
    // This is a test
    //
    /*
    NSString *path = @"https://coinbase.com/api/v1/account_changes";
    
    BRHTTPRequestOperationManager *manage = [BRHTTPRequestOperationManager managerWithURL:path];
    
    NSDictionary *parameters = nil;
    
    [manage GET:path parameters:parameters success:^(YQHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success");
        
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        
    }];
    */
    
    
    
    // Now let's send bitcoin from Wallet2 to Wallet1
    
    /*
    NSString *path1 = @"https://coinbase.com/api/v1/buttons";
    BRHTTPRequestOperationManager *manager1 = [BRHTTPRequestOperationManager managerWithURL:path1];
    
    
    NSDictionary *params = @{@"transaction" : @{
                                     @"to": @"15KFbJu5C4ZQwdYaK6Ddpy8DpW9xT3vcVz",
                                     @"amount": @0.01,
                                     @"notes": @"Send."
                                     }};
    
    NSDictionary *params1 = @{@"button" : @{
                                      @"name": @"test",
                                      @"price_string": @"1.23",
                                      @"price_currency_iso": @"USD",
                                      @"variable_price":@"1",
                                      }};
    
    
    [manager1 POST:path1 parameters:params1 success:^(YQHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success, send money request.");
        
        
    } failure:^(YQHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure");
        
        
    }];
    */
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *landing = [[ViewController alloc] init];
    [self.window setRootViewController:landing];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [Coinbase setClientId:@"6b14b1df3e78c4f307d93a6a4cc27e831f075142b5c54e8948c4183e9f34fb19" clientSecret:@"ede9c978a65caf45fd0cfc46d1075f945f2e7b0dbf860fe65d81aa6e2950fa4d"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
