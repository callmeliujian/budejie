//
//  BDJRecommendTyoe.m
//  百思不得姐
//
//  Created by 😄 on 16/8/22.
//  Copyright © 2016年 😄. All rights reserved.
//  推荐关注 左边数据模型

#import "BDJRecommendType.h"

@implementation BDJRecommendType

- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
