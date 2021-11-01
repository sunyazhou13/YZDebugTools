//
//  ViewController.m
//  yzdebugtool
//
//  Created by sunyazhou on 2021/10/19.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *shake = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 300, 60)];
    shake.text = @"摇一摇试试";
    [self.view addSubview:shake];
}


@end
