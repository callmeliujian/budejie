//
//  UIBarButtonItem+BDJExtension.h
//  百思不得姐
//
//  Created by 😄 on 16/8/21.
//  Copyright © 2016年 😄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BDJExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
