//
//  UIView+BDJExtension.h
//  百思不得姐
//
//  Created by 😄 on 16/8/21.
//  Copyright © 2016年 😄. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BDJExtension)

//分类中声明property只会生成方法的声明，不会生成方法的视线和带_的成员变量
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat x;

@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGSize size;

@end
