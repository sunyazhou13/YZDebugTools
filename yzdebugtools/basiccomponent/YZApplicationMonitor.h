//
//  YZApplicationMonitor.h
//  YZDebugTools
//
//  Created by sunyazhou on 2021/11/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YZApplicationMonitor : NSObject

@property (nonatomic, copy) void (^didApplicationStateChanged)(BOOL active);

@end

NS_ASSUME_NONNULL_END
