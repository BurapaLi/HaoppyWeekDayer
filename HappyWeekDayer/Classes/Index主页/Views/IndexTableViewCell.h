//
//  IndexTableViewCell.h
//  HappyWeekDayer
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexModel.h"

@interface IndexTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *activityImageView;
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *activityDistanceBtn;
@property (nonatomic ,strong) IndexModel *model;

@end
