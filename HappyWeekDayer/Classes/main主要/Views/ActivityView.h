//
//  ActivityView.h
//  HappyWeekDayer
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityView : UIView
@property (weak, nonatomic) IBOutlet UIButton *mapButton;
@property (weak, nonatomic) IBOutlet UIButton *makeCallButton;
@property (weak, nonatomic) IBOutlet UIScrollView *IndexScrollView;

@property (nonatomic, strong) NSDictionary *dataDic;
@end












