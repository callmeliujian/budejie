//
//  UIBarButtonItem+BDJExtension.m
//  百思不得姐
//
//  Created by 😄 on 16/8/21.
//  Copyright © 2016年 😄. All rights reserved.
//

#import "UIBarButtonItem+BDJExtension.h"

@implementation UIBarButtonItem (BDJExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [Button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [Button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    Button.size = Button.currentBackgroundImage.size;
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:Button];
}

@end
