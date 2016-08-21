//
//  BDJTabBarController.m
//  百思不得姐
//
//  Created by 😄 on 16/8/21.
//  Copyright © 2016年 😄. All rights reserved.
//

#import "BDJTabBarController.h"
#import "BDJEssenceViewController.h"
#import "BDJNewViewController.h"
#import "BDJFriendTrendsViewController.h"
#import "BDJMeViewController.h"
#import "BDJTabBar.h"

@interface BDJTabBarController ()

@end

@implementation BDJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChildVc:[[BDJEssenceViewController alloc] init] title:@"精华" iamge:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpChildVc:[[BDJNewViewController alloc] init] title:@"新帖" iamge:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setUpChildVc:[[BDJFriendTrendsViewController alloc] init] title:@"关注" iamge:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpChildVc:[[BDJMeViewController alloc] init] title:@"我" iamge:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //通过kvc更换tabBar
    //self.tabBar 是readonly所以直接更换不好使
    [self setValue:[[BDJTabBar alloc] init] forKey:@"tabBar"];
    
    
}

/**
 *初始化子控制器
 */
- (void)setUpChildVc:(UIViewController *)vc title:(NSString *)title iamge:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //包装一个导航控制器，添加导航控制器为tabbarcontroller的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    //设置导航控制器图片
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    
    [self addChildViewController:nav];
    
}

@end