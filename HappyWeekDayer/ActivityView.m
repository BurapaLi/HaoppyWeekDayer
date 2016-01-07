//
//  ActivityView.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/7.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "ActivityView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DateTools.h"
@interface ActivityView()
{
    //保存上一次图片的高度
    CGFloat  _previousImageBottom;
    //
    
}
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel     *activityTypeLabel;
//起止时间
@property (weak, nonatomic) IBOutlet UILabel     *activityTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel     *favouriteLabel;
@property (weak, nonatomic) IBOutlet UILabel     *activityPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel     *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel     *phoneLabel;


@end
@implementation ActivityView

- (void)awakeFromNib{
    self.IndexScrollView.contentSize = CGSizeMake(0, 10000);
    
}

- (void)setDataDic:(NSDictionary *)dataDic{
    //    NSArray *urls = dataDic[@"urls"];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"urls"][0]] placeholderImage:nil];
    self.activityTypeLabel.text = dataDic[@"title"];
    self.favouriteLabel.text = [NSString stringWithFormat:@"%@人已喜欢",dataDic[@"fav"]];
    self.activityPriceLabel.text = dataDic[@"price"];
    self.addressLabel.text = dataDic[@"address"];
    self.phoneLabel.text = dataDic[@"tel"];
    
    NSString *startTime = [DateTools getDateFromString:dataDic[@"new_end_date"]];
    NSString *endTime = [DateTools getDateFromString:dataDic[@"new_start_date"]];
    self.activityTimeLabel.text = [NSString stringWithFormat:@"正在进行:%@-%@",startTime,endTime];
    
    [self drawConnectWithArray:dataDic[@"content"]];
}

- (void)drawConnectWithArray:(NSArray *)contentArray{
    
    for (NSDictionary *dic in contentArray) {
        
        CGFloat height = [DateTools getTextHeightWithBigestSize:dic[@"description"] bigestSize:CGSizeMake(kWidth, 1000) textFont:15.0];
        //如果图片底部的高度没有值（也就是小于500）,也就说明是加载第一个lable，那么y的值不应该减去500
        CGFloat y;
        if (_previousImageBottom < 500) {
            y = 500 + _previousImageBottom;
        }else{
            y = 500 + _previousImageBottom - 500;
        }
        //如果标题存在
        NSString *title = dic[@"title"];
        if (title != Nil) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kWidth - 20, 30)];
            label.text = title;
            [self.IndexScrollView addSubview:label];
            y += 30;
        }
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, kWidth - 20, height)];
        label.text = dic[@"description"];
        label.numberOfLines = 0;
        [self.IndexScrollView addSubview:label];
        
        
        
        NSArray *urlsArray = dic[@"urls"];
        //当某一个段落中没有图片的时候，上次图片的高度用上次label的底部高度+10
        if (urlsArray == nil) {
            _previousImageBottom = label.bottom + 10;
        }else{
            for (NSDictionary *dic in urlsArray) {
                //                CGFloat imageHeight;
                //                if (urlsArray.count > 1) {
                //                    imageHeight = label.bottom;
                //                } else {
                //                    imageHeight = label.bottom;
                //                }

                CGFloat width       = [dic[@"width"] integerValue];
                CGFloat imageHeight = [dic[@"height"] integerValue];
                
                //                NSLog(@"kWidth = %f",kWidth);
                NSLog(@"imageHeight = %f",imageHeight);
                
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, label.bottom, kWidth - 20, (kWidth - 20)/width * imageHeight)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"url"]] placeholderImage:nil];
                
                [self.IndexScrollView addSubview:imageView];
                
                _previousImageBottom = imageView.bottom;
            }
        }
        
        
    }
}
@end
















