//
//  DateTools.h
//  HappyWeekDayer
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DateTools : NSObject
/**
 时间装换相关的方法
 */
+ (NSString *)getDateFromString:(NSString *)timestamp;
/**
 获得文字高度
 */
+ (CGFloat)getTextHeightWithBigestSize:(NSString *)text bigestSize:(CGSize)bigSize textFont:(CGFloat)font;

+ (NSDate *)getSystemNowDate;

@end












