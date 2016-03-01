//
//  HotTableViewCell.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/12.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "HotTableViewCell.h"
@interface HotTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *loveCountBtn;



@end
@implementation HotTableViewCell

- (void)setDataDic:(NSDictionary *)dataDic{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"img"]] placeholderImage:nil];
    [self.loveCountBtn setTitle:[NSString stringWithFormat:@"%@", dataDic[@"counts"]] forState:UIControlStateNormal];
}




@end
