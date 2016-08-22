//
//  BDJRecommendUserCell.m
//  百思不得姐
//
//  Created by 😄 on 16/8/22.
//  Copyright © 2016年 😄. All rights reserved.
//

#import "BDJRecommendUserCell.h"
#import "BDJRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface BDJRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabe;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation BDJRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(BDJRecommendUser *)user
{
    _user = user;
    
    self.screenNameLabe.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
