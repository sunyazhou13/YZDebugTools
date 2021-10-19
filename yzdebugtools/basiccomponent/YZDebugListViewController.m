//
//  YZDebugListViewController.m
//  YZDebugTools
//
//  Created by sunyazhou on 2021/10/19.
//

#import "YZDebugListViewController.h"
#import <Masonry/Masonry.h>
#import <M80TableViewComponent/M80TableViewComponent.h>
#import "YZFLEXCellComponent.h"
#import "YZMemoryToolCellComponent.h"
#import "YZDoneButtonCellComponent.h"

@interface YZDebugListViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) M80TableViewComponent *tableViewComponent;

@end

@implementation YZDebugListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"POWER BY SUNYAZHOU.COM";
    [self setupSubviews];
}

#pragma mark -
#pragma mark - private methods 私有方法

#pragma mark -
#pragma mark - public methods 公有方法

#pragma mark -
#pragma mark - override methods 复写方法
- (void)setupSubviews {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        } else {
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
        }
    }];
    //组件化
    self.tableViewComponent = [[M80TableViewComponent alloc] initWithTableView:self.tableView];
    M80TableViewComponentContext *context = [M80TableViewComponentContext new];
    context.viewController = self;
    self.tableViewComponent.context = context;
    
    M80TableViewSectionComponent *defaultSection = [[M80TableViewSectionComponent alloc] init];
    //FLEX
    YZFLEXCellComponent *flexCellComponent = [[YZFLEXCellComponent alloc] initWithFuncName:@"FLEX"];
    //FB memory retain cycle tool
    YZMemoryToolCellComponent *memoryCellComponent = [[YZMemoryToolCellComponent alloc] initWithFuncName:@"FB内存循环引用检测工具"];
    
    //DONE
    YZDoneButtonCellComponent *doneCellComponent = [[YZDoneButtonCellComponent alloc] initWithFuncName:@"完成"];
    NSArray *allFunctions = @[flexCellComponent,memoryCellComponent,doneCellComponent];
    defaultSection.components = allFunctions;
    [self.tableViewComponent addSections:@[defaultSection]];
}

#pragma mark -
#pragma mark - getters and setters 设置器和访问器

#pragma mark -
#pragma mark - UITableViewDelegate

#pragma mark -
#pragma mark - CustomDelegate 自定义的代理

#pragma mark -
#pragma mark - event response 所有触发的事件响应 按钮、通知、分段控件等

#pragma mark -
#pragma mark - life cycle 视图的生命周期

#pragma mark -
#pragma mark - StatisticsLog 各种页面统计Log

@end
