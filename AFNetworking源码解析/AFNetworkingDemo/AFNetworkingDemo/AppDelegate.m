//
//  AppDelegate.m
//  AFNetworkingDemo
//
//  Created by Goggles on 2022/5/20.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    ViewController *controller = [[ViewController alloc] init];
    self.window.rootViewController = controller;
    
    [self.window makeKeyWindow];
    return YES;
}


@end
