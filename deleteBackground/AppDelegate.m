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
<<<<<<< HEAD
    UINavigationController *rootVc = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    self.window.rootViewController = rootVc;
=======
    self.window.rootViewController = [ViewController new];
>>>>>>> 49c3c05d60cf19b8ea71d53d0f855da0283dee8d
    [self.window makeKeyAndVisible];
    return YES;
}

@end
