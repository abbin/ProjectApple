//
//  AppDelegate.m
//  ProjectApple
//
//  Created by Abbin Varghese on 26/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "AppDelegate.h"
#import "PAManager.h"
#import "PAUser.h"
#import "FirstLaunchViewController.h"
#import "RootViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "PACurentLocationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"4CC76E65966C420D95F7C4FF47CA0922";
        configuration.server = @"http://developmentserver.herokuapp.com/parse";
    }]];

    if (![PAManager isLocationSet]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FirstLaunchViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"FirstLaunchViewController"];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = rootViewController;
        [self.window makeKeyAndVisible];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (void)changeRootViewController:(UIViewController*)viewController {
    self.window.rootViewController = viewController;
}


@end
