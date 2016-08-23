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

//当前类别对应的用户数据
@property (nonatomic, strong) NSMutableArray *users;

//总页数
@property (nonatomic, assign) NSInteger total_page;

//总数
@property (nonatomic, assign) NSInteger total;

//下一页
@property (nonatomic, assign) NSInteger next_page;

//当前页
@property (nonatomic, assign) NSInteger currentPage;



@end
