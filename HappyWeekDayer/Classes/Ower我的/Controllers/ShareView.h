//
//  ShareView.h
//  HappyWeekDayer
//
//  Created by scjy on 16/1/14.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareView : UIView
@property (weak, nonatomic) IBOutlet UIButton *weiboBtn;
@property (weak, nonatomic) IBOutlet UIButton *friengBtn;
@property (weak, nonatomic) IBOutlet UIButton *circleBtn;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn;

+ (instancetype)addAnimateView;
@end
