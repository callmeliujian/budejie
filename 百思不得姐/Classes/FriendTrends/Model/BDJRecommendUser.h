//
//  BDJrecommendUser.h
//  百思不得姐
//
//  Created by 😄 on 16/8/22.
//  Copyright © 2016年 😄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDJRecommendUser : NSObject

//用户头像
@property (nonatomic, copy) NSString *header;

//粉丝数
@property (nonatomic, assign) NSInteger fans_count;

//昵称
@property (nonatomic, copy) NSString *screen_name;

@end
