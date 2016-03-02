//
//  SeletCityViewController.h
//  HappyWeekDayer
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SeletCityViewControllerDelegate <NSObject>

- (void)getcityName:(NSString *)cityName cityId:(NSString *)cityId;

@end
@interface SeletCityViewController : UIViewController
/** 代理 */
@property (nonatomic, assign)  id <SeletCityViewControllerDelegate>delegate;
/** 城市 */
@property (nonatomic, copy) NSString *city;
- (NSMutableArray *)getCity:(void(^)(NSMutableArray *city))city;

@end
