//
//  ImageTableViewCell.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "ImageTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ImageTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation ImageTableViewCell
    
- (void)setModel:(DiscoverModel *)model {
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.headImageView.layer.borderColor = [UIColor grayColor].CGColor;
    self.headImageView.layer.borderWidth = 1.0;
    self.headImageView.layer.cornerRadius = 25;
    self.headImageView.clipsToBounds = YES;
    self.titleLabel.text = model.title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
