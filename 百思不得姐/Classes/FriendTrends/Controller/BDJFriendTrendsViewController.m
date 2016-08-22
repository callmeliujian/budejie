//
//  BDJFriendTrendsViewController.m
//  百思不得姐
//
//  Created by 😄 on 16/8/21.
//  Copyright © 2016年 😄. All rights reserved.
//

#import "BDJFriendTrendsViewController.h"
#import "BDJRecommendViewController.h"

@interface BDJFriendTrendsViewController ()

@end

@implementation BDJFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏标题
    self.navigationItem.title = @"我的关注";
    
    //设置导航栏左边按钮
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsClick)];
    
    //设置背景色
    self.view.backgroundColor = BDJGlobalBg;

}

- (void)friendsClick
{
    BDJRecommendViewController *vc = [[BDJRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end