//
//  HeadCollectionReusableView.h
//  HappyWeekDayer
//
//  Created by scjy on 16/3/1.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;
/** 当前定位城市 */
@property (nonatomic, copy) NSString *cityName;
@end
