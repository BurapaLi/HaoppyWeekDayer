//
//  IndexModel.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "IndexModel.h"

@implementation IndexModel

//+ (instancetype)indexModelWithDictory:(NSDictionary *)dict{
//    IndexModel *model = [[self alloc] init];
//    [model setValuesForKeysWithDictionary:dict];
//    return model;
//}

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        self.type = dic[@"type"];
        if ([self.type integerValue] == RecommendTypeActivity) {
            self.price = dic[@"price"];
            self.lat = [dic[@"lat"] floatValue];
            self.lng = [dic[@"lng"] floatValue];
            self.address = dic[@"address"];
            self.counts = dic[@"counts"];
            self.startTime = dic[@"startTime"];
            self.endTime = dic[@"endTime"];
        }else{
            self.activityDescription = dic[@"description"];
        }
        self.image_big = dic[@"image_big"];
        self.title = dic[@"title"];
        self.activityId = dic[@"id"];
    }
    return self;
}
+ (IndexModel *)getDictionary:(NSDictionary *)dic{
    IndexModel *indexModel = [[IndexModel alloc] initWithDictionary:dic];
    return indexModel;
}

@end
























