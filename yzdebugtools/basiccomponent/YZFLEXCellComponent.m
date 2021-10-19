//
//  YZFLEXCellComponent.m
//  YZDebugTools
//
//  Created by sunyazhou on 2021/10/19.
//

#import "YZFLEXCellComponent.h"

#import <FLEX/FLEXManager.h>

@implementation YZFLEXCellComponent

- (Class)cellClass {
    return [UITableViewCell class];
}

- (NSString *)reuseIdentifier {
    return @"YZFLEXCell";
}

- (CGFloat)height{
    return 50;
}

- (BOOL)shouldCacheHeight {
    return YES;
}

- (void)configure:(UITableViewCell *)cell {
    cell.textLabel.text = self.funcName;
    cell.backgroundColor = [UIColor cyanColor];
}

- (void)didSelect:(UITableViewCell *)cell {
    YZDebugListViewController *vc = (YZDebugListViewController *)self.context.viewController;
    [vc dismissViewControllerAnimated:YES completion:^{
#ifdef DEBUG
        [[FLEXManager sharedManager] showExplorer];
#endif
    }];
}

@end
