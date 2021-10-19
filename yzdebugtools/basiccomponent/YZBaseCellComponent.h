//
//  YZBaseCellComponent.h
//  YZDebugTools
//
//  Created by sunyazhou on 2021/10/19.
//

#import <M80TableViewComponent/M80TableViewComponent.h>
#import "YZDebugListViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YZBaseCellComponent : M80TableViewCellComponent

@property (nonatomic, copy) NSString *funcName;

- (instancetype)initWithFuncName:(NSString *)functionName;

@end

NS_ASSUME_NONNULL_END
