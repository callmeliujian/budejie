//
//  BDJRecommendTypeCell.m
//  百思不得姐
//
//  Created by 😄 on 16/8/22.
//  Copyright © 2016年 😄. All rights reserved.
//

#import "BDJRecommendTypeCell.h"
#import "BDJRecommendType.h"

@interface BDJRecommendTypeCell()

//选中时显示的指示器控件
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;


@end

@implementation BDJRecommendTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = BDJRGBColor(244, 244, 244);
    
    self.textLabel.textColor = BDJRGBColor(78, 78, 78);
    self.textLabel.highlightedTextColor = BDJRGBColor(219, 21, 26);
    
    
}

/**
 *监听cell的选中与取消
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    
    self.textLabel.textColor = selected ? BDJRGBColor(219, 21, 26) : BDJRGBColor(78, 78, 78);
    
}

- (void)setType:(BDJRecommendType *)type
{
    _type = type;
    
    self.textLabel.text = type.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //调整cell内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}


@end
