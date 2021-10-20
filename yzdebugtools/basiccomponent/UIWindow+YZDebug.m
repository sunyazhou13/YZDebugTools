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

#import <objc/runtime.h>

static char *kYZDebugVCKey = "YZDebugVCKey";
static char *kYZShakingKey = "YZShakingKey";
static char *kYZSActiveKey = "YZSActiveKey";

@interface UIWindow ()

@property (nonatomic, strong) YZDebugListViewController *debugVC;
@property (nonatomic, assign) BOOL shaking;
@property (nonatomic, assign) BOOL active;

@end

@implementation UIWindow (YZDebug)

- (void)setDebugVC:(YZDebugListViewController *)debugVC {
    objc_setAssociatedObject(self, kYZDebugVCKey, debugVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YZDebugListViewController *)debugVC {
    return objc_getAssociatedObject(self, kYZDebugVCKey);
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
    self bk_
}

- (void)_presentTweaks {
     UIViewController *visibleViewController = self.rootViewController;
     while (visibleViewController.presentedViewController != nil) {
       visibleViewController = visibleViewController.presentedViewController;
     }
     
     // Prevent double-presenting the tweaks view controller.
     if ([visibleViewController isKindOfClass:[HYHYDebugViewController class]] ||
         [g_navigationTopVC.presentedViewController isKindOfClass:[HYHYDebugViewController class]]) {
         [self.debugVC dismissViewControllerAnimated:YES completion:nil];
     } else {
         self.debugVC = [[HYHYDebugViewController alloc] init];
         [g_navigationTopVC presentViewController:self.debugVC animated:YES completion:nil];
     }
}

- (BOOL)_shouldPresentTweaks{
#ifdef DEBUG
    return _shaking && _active;
#else
    return NO;
#endif
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
 if (motion == UIEventSubtypeMotionShake) {
#ifdef DEBUG
   _shaking = YES;
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
     if ([self _shouldPresentTweaks]) {
       [self _presentTweaks];
     }
   });
#endif
 }
 [super motionBegan:motion withEvent:event];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
 if (motion == UIEventSubtypeMotionShake) {
   _shaking = NO;
 }
 [super motionEnded:motion withEvent:event];
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        SYLog(@"摇动取消");
    }
}

@end
