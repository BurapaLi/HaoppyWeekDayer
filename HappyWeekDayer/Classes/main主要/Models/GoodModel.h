//
//  GoodModel.h
//  HappyWeekDayer
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodModel : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *counts;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *title;
- (instancetype)initWithDicticionary:(NSDictionary *)dict;

@end
