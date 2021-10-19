//
//  UIWindow+YZDebug.m
//  YZDebugTools
//
//  Created by sunyazhou on 2021/10/19.
//

#import "UIWindow+YZDebug.h"
//#import <BlocksKit/BlocksKit.h>

#import <objc/runtime.h>

//static char *kFBMemoryProfilerKey = "FBMemoryProfilerKey";

@interface UIWindow ()



@end

@implementation UIWindow (YZDebug)

//- (void)setMemoryProfiler:(FBMemoryProfiler *)memoryProfiler {
//    objc_setAssociatedObject(self, kFBMemoryProfilerKey, memoryProfiler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (FBMemoryProfiler *)memoryProfiler {
//    return objc_getAssociatedObject(self, kFBMemoryProfilerKey);
//}

- (void)enableDebug {
    
////    FBMemoryProfiler *memoryProfiler = [[FBMemoryProfiler alloc] init];
//    [self bk_associateValue:@"memoryProfiler" withKey:kFBMemoryProfilerKey];
////    FBMemoryProfiler *memoryProfilerNow = [self bk_associatedValueForKey:kFBMemoryProfilerKey];
////    [memoryProfilerNow enable];
//
//    unsigned int stuIvarCount = 0;
//    Ivar *ivars = class_copyIvarList([self class], &stuIvarCount);
//    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:stuIvarCount];
//    for (int i = 0;i<stuIvarCount;i++) {
//        Ivar ivar = ivars[i];
//        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        NSLog(@"%@",ivarName);
//        [arr addObject:ivarName];
//    }
//    free(ivars);
}

@end
