//
//  ImageTableViewCell.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "ImageTableViewCell.h"
@interface ImageTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation ImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(DiscoverModel *)model {
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.headImageView.layer.cornerRadius = 40;
    self.headImageView.clipsToBounds = YES;
    self.titleLabel.text = model.title;
    
    fSLog(@"%@",model.title);
    fSLog(@"%@",model.image);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
