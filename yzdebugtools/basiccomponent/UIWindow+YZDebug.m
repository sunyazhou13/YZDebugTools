//
//  UIWindow+YZDebug.m
//  YZDebugTools
//
//  Created by sunyazhou on 2021/10/19.
//

#import "UIWindow+YZDebug.h"
#import <BlocksKit/BlocksKit.h>
#import <BlocksKit/NSObject+BKBlockObservation.h>
#import "YZDebugListViewController.h"
#import "YZApplicationMonitor.h"
#import "YZDebugTools.h"
#import <objc/runtime.h>
#import <FBMemoryProfiler/FBMemoryProfiler.h>
#import <MMKV/MMKV.h>

static char *kYZDebugVCKey = "YZDebugVCKey";
static char *kYZDebugMonitor = "YZDebugMonitor";
static char *kYZShakingKey = "YZShakingKey";
static char *kYZSActiveKey = "YZSActiveKey";
static char *kYZMemoryProfiler = "YZMemoryProfiler";

@interface UIWindow ()

@property (nonatomic, strong) YZDebugListViewController *debugVC;
@property (nonatomic, assign) BOOL shaking;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, strong) YZApplicationMonitor *monitor;
@property (nonatomic, strong) FBMemoryProfiler *memoryProfiler;

@end

@implementation UIWindow (YZDebug)


- (void)setDebugVC:(YZDebugListViewController *)debugVC {
    objc_setAssociatedObject(self, kYZDebugVCKey, debugVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YZDebugListViewController *)debugVC {
    return objc_getAssociatedObject(self, kYZDebugVCKey);
}

- (void)setMonitor:(YZApplicationMonitor *)monitor {
    objc_setAssociatedObject(self, kYZDebugMonitor, monitor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YZApplicationMonitor *)monitor {
    return objc_getAssociatedObject(self, kYZDebugMonitor);
}

- (void)setMemoryProfiler:(FBMemoryProfiler *)memoryProfiler {
    objc_setAssociatedObject(self, kYZMemoryProfiler, memoryProfiler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (FBMemoryProfiler *)memoryProfiler {
    return objc_getAssociatedObject(self, kYZMemoryProfiler);
}

- (void)setShaking:(BOOL)shaking {
    objc_setAssociatedObject(self, kYZShakingKey, @(shaking), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)shaking {
    return [objc_getAssociatedObject(self, kYZShakingKey) boolValue];
}

- (void)setActive:(BOOL)active {
    objc_setAssociatedObject(self, kYZSActiveKey, @(active), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)active {
    return [objc_getAssociatedObject(self, kYZSActiveKey) boolValue];
}

- (void)enableDebug {
    
    [MMKV initializeMMKV:nil];
    self.monitor = [[YZApplicationMonitor alloc] init];
    WS
    self.monitor.didApplicationStateChanged = ^(BOOL active) {
      SS
        self.active = active;
    };
    
    MMKV *mmkv = [MMKV defaultMMKV];
    BOOL enable = [mmkv getBoolForKey:@"YZEnableMemoryCheck"];
    if (enable) {
        if (self.memoryProfiler == nil) {
            self.memoryProfiler = [[FBMemoryProfiler alloc] initWithPlugins:nil retainCycleDetectorConfiguration:nil];
        }
        [self.memoryProfiler enable];
    }
}

- (void)yz_presentTweaks {
    UIViewController *visibleViewController = self.rootViewController;
    while (visibleViewController.presentedViewController != nil) {
        visibleViewController = visibleViewController.presentedViewController;
    }
    UITabBarController *tabBar = [self.rootViewController isKindOfClass:[UITabBarController class]]?(UITabBarController *)self.rootViewController:nil;
    UIViewController *bePresentedVC = tabBar.selectedViewController;
    if (bePresentedVC == nil) {
        bePresentedVC = visibleViewController;
    }
    // Prevent double-presenting the tweaks view controller.
    if ([visibleViewController isKindOfClass:[YZDebugListViewController class]] ||
        [bePresentedVC.presentedViewController isKindOfClass:[YZDebugListViewController class]]) {
        [self.debugVC dismissViewControllerAnimated:YES completion:nil];
    } else {
        self.debugVC = [[YZDebugListViewController alloc] init];
        [bePresentedVC presentViewController:self.debugVC animated:YES completion:nil];
    }
}

- (BOOL)yz_shouldPresentTweaks{
#ifdef DEBUG
    return self.shaking && self.active;
#else
    return NO;
#endif
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
     if (motion == UIEventSubtypeMotionShake) {
#ifdef DEBUG
       self.shaking = YES;
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
         if ([self yz_shouldPresentTweaks]) {
             [self yz_presentTweaks];
         }
       });
#endif
     }
     [super motionBegan:motion withEvent:event];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        self.shaking = NO;
    }
    [super motionEnded:motion withEvent:event];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        NSLog(@"摇动取消");
    }
}

@end
