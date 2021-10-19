//
//  YZBaseCellComponent.m
//  YZDebugTools
//
//  Created by sunyazhou on 2021/10/19.
//

#import "YZBaseCellComponent.h"

@implementation YZBaseCellComponent

- (instancetype)initWithFuncName:(NSString *)functionName {
    self = [super init];
    if (self) {
        _funcName = functionName;
    }
    return self;
}

@end
