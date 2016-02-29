//
//  IndexTableViewCell.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "IndexTableViewCell.h"


@interface IndexTableViewCell()

@end


@implementation IndexTableViewCell

- (void)setModel:(IndexModel *)model{
    [self.activityImageView sd_setImageWithURL:[NSURL URLWithString:model.image_big] placeholderImage:nil];
    self.activityNameLabel.text = model.title;
    self.activityPriceLabel.text =model.price;
    if ([model.type integerValue] != RecommendTypeActivity) {
        self.activityDistanceBtn.hidden = YES;
    }else{
        self.activityDistanceBtn.hidden = NO;
    }
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end



















