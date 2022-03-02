//
//  YZMemoryToolCellComponent.m
//  YZDebugTools
//
//  Created by sunyazhou on 2021/10/19.
//

#import "YZMemoryToolCellComponent.h"
#import <MMKV/MMKV.h>

@implementation YZMemoryToolCellComponent

- (Class)cellClass {
    return [UITableViewCell class];
}

- (NSString *)reuseIdentifier {
    return @"YZMemoryToolCell";
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
    UISwitch *swt = [[UISwitch alloc] initWithFrame:CGRectZero];
    MMKV *mmkv = [MMKV defaultMMKV];
    BOOL enable = [mmkv getBoolForKey:@"YZEnableMemoryCheck"];
    [swt setOn:enable animated:YES];
    [swt addTarget:self action:@selector(didOnSwitchValueChange:) forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = swt;
}

- (void)didOnSwitchValueChange:(UISwitch *)sender {
    MMKV *mmkv = [MMKV defaultMMKV];
    [mmkv setBool:sender.on forKey:@"YZEnableMemoryCheck"];
}

- (void)didSelect:(UITableViewCell *)cell {
    YZDebugListViewController *vc = (YZDebugListViewController *)self.context.viewController;
    [vc dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
