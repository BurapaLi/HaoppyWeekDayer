//
//  GoodTableViewCell.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "GoodTableViewCell.h"
@interface GoodTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UIImageView *ageImage;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *praise;


@end
@implementation GoodTableViewCell

- (void)awakeFromNib {
    self.frame = CGRectMake(0, 0, kWidth, 90);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
