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
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIButton *praise;

@end
@implementation GoodTableViewCell
- (void)awakeFromNib {
    self.frame = CGRectMake(0, 0, kWidth, 90);
}
- (void)setGoodModel:(GoodModel *)goodModel{
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:goodModel.image] placeholderImage:nil];
    self.title.text = goodModel.title;
    self.title.numberOfLines = 0;
    self.price.text = goodModel.price;
    [self.praise setTitle:[NSString stringWithFormat:@"%@", goodModel.counts] forState:UIControlStateNormal];
    self.distance.text = goodModel.address;
    self.ageLabel.text = goodModel.age;
    self.ageLabel.layer.borderWidth = 1.0;
    self.ageLabel.layer.cornerRadius = 12.5;
    self.ageLabel.layer.borderColor = [UIColor blueColor].CGColor;
}



@end
