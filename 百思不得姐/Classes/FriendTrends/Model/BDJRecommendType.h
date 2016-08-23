//
//  BDJRecommendTyoe.h
//  百思不得姐
//
//  Created by 😄 on 16/8/22.
//  Copyright © 2016年 😄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJRecommendType : NSObject

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSMutableArray *users;

@end
