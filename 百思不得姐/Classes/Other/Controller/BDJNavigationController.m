//
//  BDJNavigationController.m
//  百思不得姐
//
//  Created by 😄 on 16/8/22.
//  Copyright © 2016年 😄. All rights reserved.
//

#import "BDJNavigationController.h"

@interface BDJNavigationController ()

@end

@implementation BDJNavigationController

/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    //设置导航控制器图片
    //导航栏使用BDJNavigationController，appearance才会生效
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 *拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { //push进来的不是第一个控制器
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        //让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        //隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    //让view Controller可以覆盖上面的legtBarButtonItem
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
