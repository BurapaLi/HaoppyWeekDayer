//
//  IndexModel.h
//  HappyWeekDayer
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    /** 推荐活动 */
    RecommendTypeActivity = 1,
    /** 推荐专题 */
    RecommendTypeTheme = 2,
    
}RecommendType;


@interface IndexModel : NSObject
/** 首页大图 */
@property (nonatomic, copy) NSString *image_big;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 价格 */
@property (nonatomic, copy) NSString *price;
/** 经度 */
@property(nonatomic, assign) CGFloat lat;
/** 维度 */
@property (nonatomic, assign) CGFloat  lng;
/** 地址 */
@property (nonatomic, copy  ) NSString *address;
@property (nonatomic, copy  ) NSString *counts;
@property (nonatomic, copy  ) NSString *startTime;
@property (nonatomic, copy  ) NSString *endTime;
@property (nonatomic, copy  ) NSString *activityId;
@property (nonatomic, copy  ) NSString *type;
@property (nonatomic, copy  ) NSString *activityDescription;

//+ (instancetype)indexModelWithDictory:(NSDictionary *)dict;

+ (IndexModel *)getDictionary:(NSDictionary *)dic;
@end

























