//
//  ShareView.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/14.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "ShareView.h"
@interface ShareView()


@end
@implementation ShareView

+ (instancetype)addAnimateView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ShareView" owner:nil options:nil] lastObject];
}

@end
