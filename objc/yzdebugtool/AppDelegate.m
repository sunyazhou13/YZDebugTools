//
//  AppDelegate.m
//  yzdebugtool
//
//  Created by sunyazhou on 2021/10/19.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UIWindow+YZDebug.h"

@interface AppDelegate ()

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *rootVC = [[ViewController alloc] init];
    rootVC.view.backgroundColor = [UIColor lightTextColor];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    [self.window enableDebug];
    return YES;
}

@end
