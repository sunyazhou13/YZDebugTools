//
//  AppDelegate.m
//  yzdebugtool
//
//  Created by sunyazhou on 2021/10/19.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <FBMemoryProfiler/FBMemoryProfiler.h>

@interface AppDelegate ()

@property (nonatomic, strong) FBMemoryProfiler *memoryProfiler;

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UIViewController *rootVC = [[ViewController alloc] init];
    rootVC.view.backgroundColor = [UIColor cyanColor];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];
    
    FBMemoryProfiler *memoryProfiler = [[FBMemoryProfiler alloc] initWithPlugins:nil retainCycleDetectorConfiguration:nil];
    [memoryProfiler enable];
    _memoryProfiler = memoryProfiler;
    return YES;
}

@end
