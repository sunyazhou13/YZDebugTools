//
//  YZDoneButtonCellComponent.m
//  YZDebugTools
//
//  Created by sunyazhou on 2021/10/19.
//

#import "YZDoneButtonCellComponent.h"

@implementation YZDoneButtonCellComponent

- (Class)cellClass {
    return [UITableViewCell class];
}

- (NSString *)reuseIdentifier {
    return @"YZDoneCell";
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

    }];
}


@end
