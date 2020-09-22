//
//  AppDelegate.m
//  deleteBackground
//
//  Created by mt010 on 2020/9/18.
//  Copyright © 2020 image. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UINavigationController *rootVc = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = rootVc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
