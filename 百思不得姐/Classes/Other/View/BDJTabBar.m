//
//  BDJTabBar.m
//  百思不得姐
//
//  Created by 😄 on 16/8/21.
//  Copyright © 2016年 😄. All rights reserved.
//

#import "BDJTabBar.h"

@interface BDJTabBar ()

@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation BDJTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    //不能在这个设置frame，不好使，假frame
    if (self = [super initWithFrame:frame]) {
        
        //设置tabBar背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        
        //添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

//布局子空间
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    //设置发布按钮的frame
    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    //设置其他的tabBarButton的frame
    CGFloat buttonY = 0;
    CGFloat buttonW = width / 5;
    CGFloat buttonH = height;
    NSInteger index = 0;
    
    for (UIView *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        
        //计算x
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index ++;
    }
    
}

@end
