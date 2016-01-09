//
//  DateTools.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "DateTools.h"

@implementation DateTools : NSObject

+ (NSString *)getDateFromString:(NSString *)timestamp{
    NSTimeInterval time = [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formater stringFromDate:date];
    
    return dateStr;
}

+ (CGFloat)getTextHeightWithBigestSize:(NSString *)text bigestSize:(CGSize)bigSize textFont:(CGFloat)font{
    
    CGRect textRect = [text boundingRectWithSize:bigSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    return textRect.size.height;
}


+ (NSDate *)getSystemNowDate{
    //创建一个NSDataFormatter显示刷新时间
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [df stringFromDate:[NSDate date]];
    NSDate *date = [df dateFromString:dateStr];
    return date;

    
    
}
@end




















