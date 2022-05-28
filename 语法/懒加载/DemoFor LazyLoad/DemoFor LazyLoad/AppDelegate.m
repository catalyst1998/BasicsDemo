//
//  AppDelegate.m
//  DemoFor LazyLoad
//
//  Created by Goggles on 2022/5/11.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.backgroundColor = [UIColor clearColor];
    
    [self.window makeKeyAndVisible];
    
    ViewController *controller = [[ViewController alloc] init];
    
    self.window.rootViewController = controller;
    
    return YES;
}




@end
