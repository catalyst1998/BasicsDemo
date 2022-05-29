//
//  AppDelegate.m
//  DemoForGCD
//
//  Created by Goggles on 2022/5/27.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *controller = [[ViewController alloc] init];
    self.window.rootViewController = controller;
    //test 各种组合
//    [controller syncConcurrent];
//    [controller asyncConcurrent];
//    [controller syncSerial];
//    [controller asyncSerial];
//    [controller syncMain];
//    [controller test];
//    [controller asyncMain];
    
    //GCD通信
//    [controller communication];
    
//    [controller after];
//    [controller group];
//    [controller barrier];
//    [controller apply];
//    [controller testDataConflict];
    [controller semaphoreSync];

//    [controller semaphore];
    
    [self.window makeKeyAndVisible];
    return YES;
}




@end
