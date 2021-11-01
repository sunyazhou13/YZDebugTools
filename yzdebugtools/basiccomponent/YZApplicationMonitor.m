//
//  YZApplicationMonitor.m
//  YZDebugTools
//
//  Created by sunyazhou on 2021/11/1.
//

#import "YZApplicationMonitor.h"

@implementation YZApplicationMonitor

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActiveWithNotification:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActiveWithNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)applicationWillResignActiveWithNotification:(NSNotification *)notification {
    if (self.didApplicationStateChanged) {
        self.didApplicationStateChanged(NO);
    }
}

- (void)applicationDidBecomeActiveWithNotification:(NSNotification *)notification {
    if (self.didApplicationStateChanged) {
        self.didApplicationStateChanged(YES);
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
