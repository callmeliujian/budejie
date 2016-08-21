//
//  BDJMeViewController.m
//  百思不得姐
//
//  Created by 😄 on 16/8/21.
//  Copyright © 2016年 😄. All rights reserved.
//

#import "BDJMeViewController.h"

@interface BDJMeViewController ()

@end

@implementation BDJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏标题
    self.navigationItem.title  = @"我的";
    
    //设置导航栏右边的按钮
    
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, moonItem];
    
    //设置背景色
    self.view.backgroundColor = BDJGlobalBg;
    
    
}

- (void)settingClick
{
    
}

- (void)moonClick
{
    
}

@end
