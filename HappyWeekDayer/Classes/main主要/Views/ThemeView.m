//
//  ThemeView.m
//  HappyWeekDayer
//
//  Created by scjy on 16/1/8.
//  Copyright © 2016年 李志鹏. All rights reserved.
//

#import "ThemeView.h"

@interface ThemeView()
{
    //保存上一次图片的高度
    CGFloat  _previousImageBottom;
    
}
@end
@implementation ThemeView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configView];
    }
    return self;
}
- (void)configView{
    [self addSubview:self.mainScrollView];
    [self.IndexScrollView addSubview:self.headImageView];
    
}

- (UIScrollView *)mainScrollView{
    if (_IndexScrollView == nil) {
        self.IndexScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 1000)];
        self.IndexScrollView.contentSize = CGSizeMake(0, 10000);
    }
    return _IndexScrollView;
}
- (UIImageView *)headImageView{
    if (_headImageView == nil) {
        self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 186)];
    }
    return _headImageView;
}
- (void)setDataDic:(NSDictionary *)dataDic{
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:dataDic[@"image"]] placeholderImage:nil];
    
    [self drawConnectWithArray:dataDic[@"content"]];
}

- (void)drawConnectWithArray:(NSArray *)contentArray{
    for (NSDictionary *dic in contentArray) {
        
        CGFloat height = [DateTools getTextHeightWithBigestSize:dic[@"description"] bigestSize:CGSizeMake(kWidth, 1000) textFont:15.0];
        //如果图片底部的高度没有值（也就是小于500）,也就说明是加载第一个lable，那么y的值不应该减去500
        CGFloat y;
        if (_previousImageBottom < 186) {
            y = 186 + _previousImageBottom;
        }else{
            y = 186 + _previousImageBottom - 186;
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
        if (urlsArray == nil) {
            //当某一个段落中没有图片的时候，上次图片的高度用上次label的底部高度+10
            _previousImageBottom = label.bottom + 10;
        }else{
            CGFloat lastImgbottom = 0.0;
            for (NSDictionary *dic in urlsArray) {
                CGFloat imgY;
                if (urlsArray.count > 1) {
                    //图片不止一张的情况
                    if (lastImgbottom == 0.0) {
                        if (title != nil) { //有title的算上title的30像素
                            imgY = _previousImageBottom + label.height + 30 + 5;
                        } else {
                            imgY = _previousImageBottom + label.height + 5;
                        }
                    } else {
                        imgY = lastImgbottom + 10;
                    }
                    
                } else {
                    //单张图片的情况
                    imgY = label.bottom;
                }
                
                CGFloat width       = [dic[@"width"] integerValue];
                CGFloat imageHeight = [dic[@"height"] integerValue];
                UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, imgY, kWidth - 20, (kWidth - 20)/width * imageHeight)];
                [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"url"]] placeholderImage:nil];
                [self.IndexScrollView addSubview:imageView];
                
                //每次都保留最新的图片底部高度
                _previousImageBottom = imageView.bottom + 5;
                
                if (urlsArray.count > 1) {
                    lastImgbottom = imageView.bottom;
                }
                
            }
        }
        
        
    }
    self.IndexScrollView.contentSize = CGSizeMake(0, _previousImageBottom + 164);
}

@end








